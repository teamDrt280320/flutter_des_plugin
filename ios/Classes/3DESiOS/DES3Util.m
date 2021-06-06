//
//  DES3Util.m
//  DES
//
//  Created by Toni on 12-12-27.
//  Copyright (c) 2012年 sinofreely. All rights reserved.
//

#import "DES3Util.h"
#define gkey            @"app_key_ioved1cm!@#$5678"
//#define gkey            @"liuyunqiang@lx100$#365#$"
#define gIv             @"01234567"

@implementation DES3Util
//1,2,3,4,5,6,7,8
const Byte iv[] = {1,2,3,4,5,6,7,8};
//Des加密
 +(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key
 {
    
     NSString *ciphertext = nil;
     NSData *textData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
     NSUInteger dataLength = [textData length];
     
     unsigned char buffer[1024 *900];
     memset(buffer, 0, sizeof(char));
     size_t numBytesEncrypted = 0;
     CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                        kCCOptionECBMode | kCCOptionPKCS7Padding,
                                              [key UTF8String], kCCKeySizeDES,
                                                            NULL,
                                                [textData bytes], dataLength,
                                                        buffer, 1024*900,
                                                    &numBytesEncrypted);
      if (cryptStatus == kCCSuccess)
     {
    NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
         
         
         ciphertext = [GTMBase64 stringByEncodingData:data];
         
         
//         ciphertext = [[NSString alloc] initWithData:[GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
         
     }
    return ciphertext;
}



//Des解密
 +(NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key
 {
     
//     NSString *plaintext = nil;
//     NSData *cipherdata = [GTMBase64 decodeString:cipherText];
//     unsigned char buffer[1024 *900];
//     memset(buffer, 0, sizeof(char));
//     size_t numBytesDecrypted = 0;
//     CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
//                                           kCCOptionECBMode|kCCOptionPKCS7Padding,
//                                           [key UTF8String], kCCKeySizeDES,
//                                           iv,
//                                           [cipherdata bytes], [cipherdata length],
//                                           buffer, 1024 *900,
//                                           &numBytesDecrypted);
//     if(cryptStatus == kCCSuccess)
//     {
//         NSData *plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
//         plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
//     }
//     return plaintext;

    NSString *plaintext = @"";
    NSData *cipherdata = [GTMBase64 decodeString:cipherText];
     unsigned char buffer[1024 *900];
     memset(buffer, 0, sizeof(char));
     if ([cipherdata length] > 1024 *900) {
         NSInteger i = [cipherdata length] /(1024 *900);
         for (int j = 0; j < i+1; j ++) {
             size_t in = 0;
             if (([cipherdata length] - 1024 *900*j) >0 && ([cipherdata length] - 1024 *900*j) <1024 *900) {
                  in =[cipherdata length] - 1024 *900*j ;
             }else{
                  in = 1024 *900;
             }
            NSData *newData = [cipherdata subdataWithRange:NSMakeRange(1024 *900*j, in)];
            size_t numBytesDecrypted = 0;
             CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                                   kCCOptionECBMode|kCCOptionPKCS7Padding,
                                                   [key UTF8String], kCCKeySizeDES,
                                                   iv,
                                                   [newData bytes], [newData length],
                                                   buffer, 1024 *900,
                                                   &numBytesDecrypted);
             if(cryptStatus == kCCSuccess)
             {
                 NSData *plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
                 
                 NSString *pst =[[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
                 plaintext = [plaintext stringByAppendingString:pst];
             }
         }
     }else{

         size_t numBytesDecrypted = 0;
         CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                               kCCOptionECBMode|kCCOptionPKCS7Padding,
                                               [key UTF8String], kCCKeySizeDES,
                                               iv,
                                               [cipherdata bytes], [cipherdata length],
                                               buffer, 1024 *900,
                                               &numBytesDecrypted);
         if(cryptStatus == kCCSuccess)
         {
             NSData *plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
             plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
         }
     }

     return plaintext;
     
}

+(NSString *)decryptUseDES34:(NSString *)cipherText43 key:(NSString *)key{
         //    key=[self md5:key];
         NSData *keyDate=[key dataUsingEncoding:NSUTF8StringEncoding];
         //    转换成byte数组
         Byte *iv = (Byte *)[keyDate bytes];
    
         NSString *plaintext = nil;
    
         NSData *dataa =[GTMBase64 decodeString:cipherText43];;
    
    
    
         //改
         const void *dataIn;
         size_t dataInLength;
    
         dataInLength = [dataa length];
         dataIn = [dataa bytes];
    
         uint8_t *dataOut = NULL; //可以理解位type/typedef 的缩写（有效的维护了代码，比如：一个人用int，一个人用long。最好用typedef来定义）
         size_t dataOutAvailable = 0; //size_t  是操作符sizeof返回的结果类型
         size_t dataOutMoved = 0;
    
         dataOutAvailable = (dataInLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
         dataOut = malloc( dataOutAvailable * sizeof(uint8_t));
         memset((void *)dataOut, 0x0, dataOutAvailable);//将已开辟内存空间buffer的首 1 个字节的值设为值 0
    
         //CCCrypt函数 解密
         CCCryptorStatus ccStatus = CCCrypt(kCCDecrypt,//  解密
                                            kCCAlgorithmDES,//  解密根据哪个标准（des，3des，aes。。。。）
                                            kCCOptionPKCS7Padding,//  选项分组密码算法(des:对每块分组加一次密  3DES：对每块分组加三个不同的密)
                                            [key UTF8String],  //密钥    加密和解密的密钥必须一致
                                            kCCKeySizeDES,//   DES 密钥的大小（kCCKeySizeDES=8）
                                            iv, //  可选的初始矢量
                                            dataIn, // 数据的存储单元
                                            dataInLength,// 数据的大小
                                            (void *)dataOut,// 用于返回数据
                                            dataOutAvailable,
                                            &dataOutMoved);
    
    
    
         if(ccStatus == kCCSuccess) {
             NSData *plaindata = [NSData dataWithBytes:(void *)dataOut length:(NSUInteger)dataOutMoved];
             plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
         }
         return plaintext;
}



+(id)dataWithData:(id)responsObject{
    return
    [NSJSONSerialization JSONObjectWithData:[[NSString stringWithFormat:@"%@", [self decryptUseDES:[responsObject objectForKey:@"data"] key:[[[UIDevice currentDevice].identifierForVendor UUIDString] substringFromIndex:[[UIDevice currentDevice].identifierForVendor UUIDString].length- 8]]] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
}

+ (NSString *)encrypt:(NSString *)sText  key:(NSString *)key
{
    const void *dataIn;
    size_t dataInLength;
    
    //解码 base64
    NSData *decryptData = [GTMBase64 decodeData:[sText dataUsingEncoding:NSUTF8StringEncoding]];//转成utf-8并decode
    dataInLength = [decryptData length];
    dataIn = [decryptData bytes];

    /*
     DES加密 ：用CCCrypt函数加密一下，然后用base64编码下，传过去
     DES解密 ：把收到的数据根据base64，decode一下，然后再用CCCrypt函数解密，得到原本的数据
     */
    CCCryptorStatus ccStatus;
    uint8_t *dataOut = NULL; //可以理解位type/typedef 的缩写（有效的维护了代码，比如：一个人用int，一个人用long。最好用typedef来定义）
    size_t dataOutAvailable = 0; //size_t  是操作符sizeof返回的结果类型
    size_t dataOutMoved = 0;
    
    dataOutAvailable = (dataInLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    dataOut = malloc(dataOutAvailable * sizeof(uint8_t));
    memset((void *)dataOut, 0x0, dataOutAvailable);//将已开辟内存空间buffer的首 1 个字节的值设为值 0
    
    const void *vkey = (const void *) [key UTF8String];
    const void *iv = (const void *) [gIv UTF8String];
    
    //CCCrypt函数 加密/解密
    ccStatus = CCCrypt(kCCDecrypt,//  加密/解密
                       kCCAlgorithm3DES,//  加密根据哪个标准（des，3des，aes。。。。）
                       kCCOptionPKCS7Padding,//  选项分组密码算法(des:对每块分组加一次密  3DES：对每块分组加三个不同的密)
                       vkey,  //密钥    加密和解密的密钥必须一致
                       kCCKeySize3DES,//   DES 密钥的大小（kCCKeySizeDES=8）
                       iv, //  可选的初始矢量
                       dataIn, // 数据的存储单元
                       dataInLength,// 数据的大小
                       (void *)dataOut,// 用于返回数据
                       dataOutAvailable,
                       &dataOutMoved);
    
    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved] encoding:NSUTF8StringEncoding] ;


    return result;
}





@end
