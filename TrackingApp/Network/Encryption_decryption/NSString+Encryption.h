//
//  NSString+Encryption.h
//  VPassbook
//
//  Created by Avinash on 03/10/13.
//  Copyright (c) 2013 Snowtint Technologies Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
#import <Security/Security.h>

#import "NSString+SHA.h"
#import "NSData+Base64.h"
#import "NSData+AES.h"

@interface NSString (Encryption)
- (NSString*)md5HexDigest;
- (NSString*)encryptedStringWithKey:(NSString*)key; //Vijaya Bank specific encryption technique.

//Normal AES encryption technique.
+ (NSString*)AESEncrypt:(NSString*)string withKey:(NSString*) key;
+ (NSString*)AESDecrypt:(NSString*)string withKey:(NSString*)key;
+ (NSString*)AESEncrypt:(NSString*)string withKey:(NSString*)key addChecksumHash:(BOOL)needsHash;
+ (NSString*)AESDecrypt:(NSString*)string withKey:(NSString*)key hasChecksumHash:(BOOL)conatainsHash;
@end