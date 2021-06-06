//
//  DES3Util.h
//  DES
//
//  Created by Toni on 12-12-27.
//  Copyright (c) 2012年 sinofreely. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTMBase64.h"
#import <CommonCrypto/CommonCryptor.h>
#import "NSString+NSReplace.h"
@interface DES3Util : NSObject

//加密方法
+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;
//解密方法
+(NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key;
+(NSString *)decryptUseDES34:(NSString *)cipherText43 key:(NSString *)key;

+(id)dataWithData:(id)responsObject;

+ (id)encry1Data:(id)responsObject;

+(id)encryUseDesData:(id)responseObject;
+(id)encryUseDesData22:(id)responseObject;

+ (NSString *)encrypt:(NSString *)sText key:(NSString *)key;

@end
