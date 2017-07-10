//
//  NSString+Encoding.h
//  VijayaMirror
//
//  Created by Shankar BS on 03/08/16.
//  Copyright © 2016 snowtint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encoding)
- (NSString *)percentEscapedQueryStringPairMemberWithEncoding:(NSStringEncoding) encoding;
@end
