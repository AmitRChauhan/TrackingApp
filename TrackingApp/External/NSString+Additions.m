//
//  NSString+Additions.m
//  Car Dispatch
//
//  Created by Girish Sawargi on 02/05/14.
//  Copyright (c) 2014 Snowtint Technologies Pvt. Ltd. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)
- (NSString*)trimmedString {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
- (NSInteger)trimmedStringLength {
    return [[self trimmedString] length];
}
@end
