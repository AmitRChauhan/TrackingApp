//
//  NSData+AES.m
//  VPassbook
//
//  Created by Girish on 03/10/13.
//  Copyright (c) 2013 Snowtint Technologies Pvt. Ltd., All rights reserved.
//

#import "NSData+AES.h"


@implementation NSData(AES)

- (NSData*) encryptedDataUsingAESKey: (NSData *) key {
    char keyPtr [ kCCKeySizeAES128 +1 ];
    bzero( keyPtr, sizeof(keyPtr) );
    
    // The secret key is masked for obvious reason, but you can use "12345678912345678912345678912345"
    [key getBytes:keyPtr length:sizeof(keyPtr)];
    
    NSUInteger dataLength = [self length];
    // Initialization vector; dummy in this case 0's.
    uint8_t iv[ kCCBlockSizeAES128 ];
    memcpy((void*)iv, (void *)keyPtr, kCCBlockSizeAES128);
    /*
     For block ciphers, the output size will always be less than or
     equal to the input size plus the size of one block.
     */
    size_t bufferSize = (dataLength + kCCBlockSizeAES128);
    void  *buffer     = malloc(bufferSize);
    memset(buffer, 0x0, bufferSize);
    
    size_t numBytesEncrypted    = 0;
    NSData* returnData = nil;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          iv,
                                          [self bytes],
                                          dataLength, /* input */
                                          buffer,
                                          bufferSize, /* output */
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        returnData = [NSData dataWithBytesNoCopy:buffer
                                          length:numBytesEncrypted
                                    freeWhenDone:YES];
    }
    
//    free(buffer); //free the buffer;
    return returnData;
    
//    uint8_t iv[kCCBlockSizeAES128];
//    memset((void *) iv, 0x0, (size_t) sizeof(iv));
//
//    char keyPtr [ kCCKeySizeAES128 +1 ];
//    bzero( keyPtr, sizeof(keyPtr) );
//    
//    // The secret key is masked for obvious reason, but you can use "12345678912345678912345678912345"
//    [key getBytes:keyPtr length:sizeof(keyPtr)];
//
//#if TARGET_OS_IPHONE
//    if (0 != SecRandomCopyBytes(0, sizeof(iv), iv))
//    {
//        return nil;
//    }
//#else
//    {
//        int fd = open("/dev/urandom", O_RDONLY);
//        if (fd < 0) { return nil; }
//        ssize_t bytesRead;
//        for (uint8_t * p = iv; (bytesRead = read(fd,p,iv+sizeof(iv)-p)); p += (size_t)bytesRead) {
//            // 0 means EOF.
//            if (bytesRead == 0) { close(fd); return nil; }
//            // -1, EINTR means we got a system call before any data could be read.
//            // Pretend we read 0 bytes (since we already handled EOF).
//            if (bytesRead < 0 && errno == EINTR) { bytesRead = 0; }
//            // Other errors are real errors.
//            if (bytesRead < 0) { close(fd); return nil; }
//        }
//        close(fd);
//    }
//#endif
//    size_t retSize = 0;
//    CCCryptorStatus result = CCCrypt(kCCEncrypt,
//                                     kCCAlgorithmAES128,                        
//                                     kCCOptionPKCS7Padding,                         
//                                     keyPtr,                               
//                                     kCCKeySizeAES128,
//                                     iv,
//                                     [self bytes],
//                                     [self length],
//                                     NULL,
//                                     0,
//                                     &retSize);
//    if (result != kCCBufferTooSmall) { return nil; }
//    
//    // Prefix the data with the IV (the textbook method).
//    // This requires adding sizeof(iv) in a few places later; oh well.
//    void * retPtr = malloc(retSize+sizeof(iv));
//    if (!retPtr) { return nil; }
//    
//    // Copy the IV.
//    memcpy(retPtr, iv, sizeof(iv));
//    
//    result = CCCrypt(kCCEncrypt,
//                     kCCAlgorithmAES128,
//                     kCCOptionPKCS7Padding,
//                     keyPtr,
//                     kCCKeySizeAES128,
//                     iv,
//                     [self bytes],
//                     [self length],
//                     retPtr+sizeof(iv),retSize,
//                     &retSize);
//    if (result != kCCSuccess) { free(retPtr); return nil; }
//    
//    NSData * ret = [NSData dataWithBytesNoCopy:retPtr length:retSize+sizeof(iv)];
//    // Does +[NSData dataWithBytesNoCopy:length:] free if allocation of the NSData fails?
//    // Assume it does.
//    if (!ret) { free(retPtr); return nil; }
//    return ret;
}

//FIXME: Not working right now
- (NSData*) decryptedDataUsingAESKey: (NSData *) key {
    char keyPtr [ kCCKeySizeAES128 +1 ];
    bzero( keyPtr, sizeof(keyPtr) );
    
    // The secret key is masked for obvious reason, but you can use "12345678912345678912345678912345"
    [key getBytes:keyPtr length:sizeof(keyPtr)];
    
    NSUInteger dataLength = [self length];
    // Initialization vector; dummy in this case 0's.
    uint8_t iv[ kCCBlockSizeAES128 ];
    memcpy((void*)iv, (void *)keyPtr, kCCBlockSizeAES128);
    /*
     For block ciphers, the output size will always be less than or
     equal to the input size plus the size of one block.
     */
    size_t bufferSize = (dataLength + kCCBlockSizeAES128);
    void  *buffer     = malloc(bufferSize);
    memset(buffer, 0x0, bufferSize);
    
    size_t numBytesEncrypted    = 0;
    NSData* returnData = nil;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          iv,
                                          [self bytes],
                                          dataLength, /* input */
                                          buffer,
                                          bufferSize, /* output */
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        returnData = [NSData dataWithBytesNoCopy:buffer
                                          length:numBytesEncrypted
                                    freeWhenDone:YES];
    }
    
//    free(buffer); //free the buffer;
    return returnData;

//    const uint8_t * p = [self bytes];
//    size_t length = [self length];
//    if (length < kCCBlockSizeAES128) { return nil; }
//    
//    size_t retSize = 0;
//    CCCryptorStatus result = CCCrypt(kCCDecrypt,
//                                     kCCAlgorithmAES128,
//                                     kCCOptionPKCS7Padding,
//                                     [key bytes],
//                                     [key length],
//                                     p,
//                                     p+kCCBlockSizeAES128,
//                                     length-kCCBlockSizeAES128,
//                                     NULL, 0,
//                                     &retSize);
//    if (result != kCCBufferTooSmall) { return nil; }
//    
//    void * retPtr = malloc(retSize);
//    if (!retPtr) { return nil; }
//    
//    result = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
//                     [key bytes], [key length],
//                     p,
//                     p+kCCBlockSizeAES128, length-kCCBlockSizeAES128,
//                     retPtr, retSize,
//                     &retSize);
//    if (result != kCCSuccess) { free(retPtr); return nil; }
//    
//    NSData * ret = [NSData dataWithBytesNoCopy:retPtr length:retSize];
//    // Does +[NSData dataWithBytesNoCopy:length:] free if allocation of the NSData fails?
//    // Assume it does.
//    if (!ret) { free(retPtr); return nil; }
//    return ret;
}

@end

