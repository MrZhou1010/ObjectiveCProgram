//
//  MZWebSocketManager.h
//  MZWebSocket
//
//  Created by Mr.Z on 2020/5/25.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MZWebSocketStatus) {
    MZWebSocketStatusConnecting = 0,  // 正在连接
    MZWebSocketStatusConnected,       // 已连接
    MZWebSocketStatusFailed,          // 失败
    MZWebSocketStatusClosedByServer,  // 系统关闭
    MZWebSocketStatusClosedByUser,    // 用户关闭
    MZWebSocketStatusReceived         // 接收消息
};

@protocol MZWebSocketManagerDelegate <NSObject>

@optional

/// 接收消息
/// @param message 消息
- (void)webSocketDidReceiveMessage:(id)message;

/// 收到Pong信息
/// @param pongPayload 信息数据

- (void)webSocketDidReceivePong:(NSData *)pongPayload;

/// 当前的重连次数
/// @param currentCount 当前的重连次数
- (void)webSocketCurrentConnect:(NSInteger)currentCount;

/// 超过最大重连次数,webSoctet连接超时
- (void)webSocketConnectTimeout;

@end

@interface MZWebSocketManager : NSObject

/// 重连时间间隔,默认3秒钟
@property (nonatomic, assign) NSTimeInterval overtime;

/// 重连次数,默认无限次
@property (nonatomic, assign) NSUInteger reconnectCount;

/// webSocket地址
@property (nonatomic, copy) NSString *urlString;

/// 当前连接状态
@property (nonatomic, assign, readonly) MZWebSocketStatus status;

/// 代理
@property (nonatomic, weak) id <MZWebSocketManagerDelegate> delegate;

/// 单例
+ (instancetype)sharedInstance;

/// 开始连接
- (void)connect;

/// 关闭连接
- (void)close;

/// 发送一条消息
/// @param message 消息体
- (void)sendMessage:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
