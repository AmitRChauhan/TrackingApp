//
//  NSString+SHA.h
//  MMDrawerControllerKitchenSink
//
//  Created by Avinash on 01/10/13.
//  Copyright (c) 2013 Mutual Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SHA)
+ (NSString *)GetUUID;
- (NSString*)SHA1EncodedString;
@end
