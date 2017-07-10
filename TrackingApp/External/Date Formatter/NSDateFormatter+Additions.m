//
//  NSDateFormatter+Additions.m
//  Car Dispatch
//
//  Created by Master on 05/04/14.
//  Copyright (c) 2014 Snowtint Technologies Pvt. Ltd. All rights reserved.
//

#import "NSDateFormatter+Additions.h"

@implementation NSDateFormatter (Additions)
+ (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *_dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateStyle:NSDateFormatterShortStyle];
    });
    
    return _dateFormatter;
}

+ (NSString*)stringFromDate:(NSDate *)date withFormat:(NSString*)format {
    NSDateFormatter* formatter = [NSDateFormatter dateFormatter];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

+ (NSDate*)dateFromString:(NSString *)dateString withFormat:(NSString*)format {
    NSDateFormatter* formatter = [NSDateFormatter dateFormatter];
    [formatter setDateFormat:format];
    return [formatter dateFromString:dateString];
}

@end
