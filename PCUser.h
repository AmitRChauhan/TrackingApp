//
//  PCUser.h
//  Passenger
//
//  Created by Snowtint on 11/12/14.
//  Copyright (c) 2014 Snowtint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCUser : NSObject

@property (retain,nonatomic)NSString *name;
@property (retain,nonatomic)NSString *email;
@property (retain,nonatomic)NSString *gender;
@property (retain,nonatomic)NSString *password;
@property (retain,nonatomic)NSString *confirmPassword;
@property (retain,nonatomic)NSString *address;
@property (retain,nonatomic)NSString *phoneNumber;
@property (nonatomic, retain)NSString* geoPlaceId;
@property (nonatomic, retain)NSString* alterPhone;
@property (nonatomic,retain)NSString  *profilePicUrl;
@property (nonatomic,retain)NSString  *promocode;
@property (nonatomic,retain)NSString  *countryCode;

- (NSString*)getProfilePicDataString;
- (id)initWithDictionary:(NSDictionary*)details;
- (NSDictionary*)dictionryRepresentation;

-(void)getPngImage;

@end
