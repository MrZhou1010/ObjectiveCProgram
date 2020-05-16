//
//  NSString+AES256.h
//  MZExtension
//
//  Created by Mr.Z on 2020/5/14.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AESCryptoType) {
    AESCryptoType128 = 0,
    AESCryptoType256,
};

@interface NSString (AES256)

/**
 *  AES加密结果
 *
 *  @param key 加解密密钥
 *  @param type 加解密类型
 *  @return 加密结果
 */
- (NSString *)aesEncryptWithKey:(NSString *)key type:(AESCryptoType)type;

/**
 *  AES解密结果
 *
 *  @param key 加解密密钥
 *  @param type 加解密类型
 *  @return 加密结果
 */
- (NSString *)aesDecryptWithKey:(NSString *)key type:(AESCryptoType)type;

/**
 *  AES加密结果
 *
 *  @param data 加解数据
 *  @param key 加解密密钥
 *  @param type 加解密类型
 *  @return 加密结果
 */
+ (NSData *)aesEncryptWithData:(NSData *)data key:(NSString *)key type:(AESCryptoType)type;

/**
 *  AES加密结果
 *
 *  @param data 解密数据
 *  @param key 加解密密钥
 *  @param type 加解密类型
 *  @return 加密结果
 */
+ (NSData *)aesDecryptWithData:(NSData *)data key:(NSString *)key type:(AESCryptoType)type;

@end

NS_ASSUME_NONNULL_END
