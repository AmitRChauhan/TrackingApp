//
//  NSString+Encoding.m
//  VijayaMirror
//
//  Created by Shankar BS on 03/08/16.
//  Copyright © 2016 snowtint. All rights reserved.
//

#import "NSString+Encoding.h"

@implementation NSString(Encoding)
- (NSString *)percentEscapedQueryStringPairMemberWithEncoding:(NSStringEncoding) encoding {
    static NSString * const kAFCharactersToBeEscaped = @":/?&=;+!@#$()~',* ";
    static NSString * const kAFCharactersToLeaveUnescaped = @"[].";
    
    NSString* encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                    (CFStringRef)self,
                                                                                                    (CFStringRef)kAFCharactersToLeaveUnescaped,
                                                                                                    (CFStringRef)kAFCharactersToBeEscaped,
                                                                                                    CFStringConvertNSStringEncodingToEncoding(encoding)));
    return encodedString;
}
@end
