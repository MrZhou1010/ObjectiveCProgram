//
//  MZWebSocketManager.m
//  MZWebSocket
//
//  Created by Mr.Z on 2020/5/25.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

#import "MZWebSocketManager.h"
#import "SocketRocket.h"

static NSString * const kWebSocketDefaultUrlString = @"http://192.168.79.113:8480/imserver/test";

@interface MZWebSocketManager () <SRWebSocketDelegate>

@property (nonatomic, strong) SRWebSocket *webSocket;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSTimer *pingTimer;

/// 当前重连次数
@property (nonatomic, assign) NSUInteger currentCount;

/// 当前连接状态
@property (nonatomic, assign, readwrite) MZWebSocketStatus status;

@end


@implementation MZWebSocketManager

#pragma mark - 单例
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static MZWebSocketManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
        instance.overtime = 3.0;
        instance.reconnectCount = NSUIntegerMax;
        instance.urlString = kWebSocketDefaultUrlString;
        // 开启ping定时器
        instance.pingTimer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:instance selector:@selector(sendPingMessage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:instance.pingTimer forMode:NSRunLoopCommonModes];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

#pragma mark - API
- (void)connect {
    if (self.webSocket) {
        [self.webSocket close];
        self.webSocket.delegate = nil;
    }
    self.webSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:self.urlString]];
    self.webSocket.delegate = self;
    self.status = MZWebSocketStatusConnecting;
    [self.webSocket open];
}

- (void)close {
    [self.webSocket close];
    self.webSocket = nil;
    [self.timer invalidate];
    self.timer = nil;
}

- (void)reconnect {
    if (self.currentCount < self.reconnectCount) {
        self.currentCount++;
        if ([self.delegate respondsToSelector:@selector(webSocketCurrentConnect:)]) {
            [self.delegate webSocketCurrentConnect:self.currentCount];
        }
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.overtime target:self selector:@selector(connect) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        self.timer = timer;
    } else {
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
        if ([self.delegate respondsToSelector:@selector(webSocketConnectTimeout)]) {
            [self.delegate webSocketConnectTimeout];
        }
    }
}

- (void)sendMessage:(NSString *)message {
    if (message) {
        [self.webSocket send:message];
    }
}

- (void)sendPingMessage {
    // 只有开启状态(SR_OPEN)才能调send方法,不然会崩溃
    if (self.webSocket.readyState == SR_OPEN) {
        [self.webSocket sendPing:[NSData data]];
    }
}

#pragma mark - SRWebSocketDelegate
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    if ([self.delegate respondsToSelector:@selector(webSocketDidReceiveMessage:)]) {
        [self.delegate webSocketDidReceiveMessage:message];
    }
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    // 重置计数器
    self.currentCount = 0;
    self.status = MZWebSocketStatusConnected;
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    self.status = MZWebSocketStatusFailed;
    // 尝试重新连接
    [self reconnect];
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(nullable NSString *)reason wasClean:(BOOL)wasClean {
    if (code == SRStatusCodeNormal) {
        self.status = MZWebSocketStatusClosedByUser;
    } else {
        self.status = MZWebSocketStatusClosedByServer;
        // 尝试重新连接
        [self reconnect];
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload {
    if ([self.delegate respondsToSelector:@selector(webSocketDidReceivePong:)]) {
        [self.delegate webSocketDidReceivePong:pongPayload];
    }
}

@end
