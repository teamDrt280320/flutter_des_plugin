//
//  Des3Tools.h
//  MobileOffice
//
//  Created by Wayne on 2017/12/4.
//  Copyright © 2017年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Des3Tools : NSObject

+ (NSString *)encryptWithText:(NSString *)sText withIv:(NSString*)iv;

+ (NSString *)decryptWithText:(NSString *)sText  withIv:(NSString*)iv;

@end
