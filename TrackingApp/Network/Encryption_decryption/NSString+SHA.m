//
//  NSString+SHA.m
//  MMDrawerControllerKitchenSink
//
//  Created by Avinash on 01/10/13.
//  Copyright (c) 2013 Mutual Mobile. All rights reserved.
//

#import "NSString+SHA.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (SHA)
+ (NSString *)GetUUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)(string);
}

- (NSString*)SHA1EncodedString {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];

    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);

    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];

    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

@end
