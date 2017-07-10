//
//  NSData+AES.h
//  VPassbook
//
//  Created by Avinash on 03/10/13.
//  Copyright (c) 2013 Snowtint Technologies Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

@interface NSData (AES)
- (NSData*) encryptedDataUsingAESKey: (NSData *) key ;

//FIXME: Not working
- (NSData*) decryptedDataUsingAESKey: (NSData *) key;
@end
