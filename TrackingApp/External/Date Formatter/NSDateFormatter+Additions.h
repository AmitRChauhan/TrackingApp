//
//  NSDateFormatter+Additions.h
//  Car Dispatch
//
//  Created by Master on 05/04/14.
//  Copyright (c) 2014 Snowtint Technologies Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (Additions)
+ (NSDateFormatter *)dateFormatter;
+ (NSString*)stringFromDate:(NSDate *)date withFormat:(NSString*)format;
+ (NSDate*)dateFromString:(NSString *)dateString withFormat:(NSString*)format;
@end
