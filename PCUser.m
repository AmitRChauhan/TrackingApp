
//
//  PCUser.m
//  Passenger
//
//  Created by Snowtint on 11/12/14.
//  Copyright (c) 2014 Snowtint. All rights reserved.
//

#import "PCUser.h"
#define kPromoKey @"INVITECODE"
#define kContryCodeKey @"COUNTRYCODE"

#define kNameKey @"NAME"
#define kEmailKey @"EMAIL"
#define kPhoneNoKey @"PHONE"
#define kGenderKey @"GENDER"
#define kPasswordKey @"PASSWORD"
#define kAdressKey @"ADDRESS1"

static PCUser *_currentLoggedUser;

@implementation PCUser
@synthesize name,phoneNumber,email,gender,address,password,confirmPassword,profilePicUrl,geoPlaceId,alterPhone,promocode,countryCode;

-(id)initWithDictionary:(NSDictionary*)details
{
    if (self=[super init]) {
        self.name    =   [details valueForKey:kNameKey];
        self.email    =   [details valueForKey:kEmailKey];
        self.phoneNumber    =   [details valueForKey:kPhoneNoKey];

        self.gender    =   [details valueForKey:kGenderKey];
        self.password    =   [details valueForKey:kPasswordKey];
        self.promocode    =   [details valueForKey:kPromoKey];

        self.address    =   [details valueForKey:kAdressKey];
        
       
        self.geoPlaceId = [details objectForKey:@"GEOPLACEID"];
        self.alterPhone = [details objectForKey:@"ALTERTPHONE"];
        
        NSString *baseUrl = [details objectForKey:@"BASEURL"];
        NSString *picUrl = [details objectForKey:@"USERPIC"];

        double lat = [[details objectForKey:@"LAT"] doubleValue];
        double lng = [[details objectForKey:@"LNG"] doubleValue];

        if (baseUrl && ![picUrl isEqualToString:@""]) {
            self.profilePicUrl  =   [NSString stringWithFormat:@"%@%@",baseUrl,picUrl];

        }

    }
    return self;
}

//-(NSDictionary*)dictionryRepresentation
//{
//    NSMutableDictionary *dict   =   [[NSMutableDictionary alloc] init];
//    if (self.name) {
//        [dict setObject:self.name forKey:kNameKey];
//    }
//    if (self.countryCode) {
//        [dict setObject:self.countryCode forKey:kContryCodeKey];
//    }
//    if (self.email) {
//        [dict setObject:self.email forKey:kEmailKey];
//    }
//    if (self.phoneNumber) {
//        [dict setObject:self.phoneNumber forKey:kPhoneNoKey];
//    }
//    if (self.gender) {
//        [dict setObject:self.gender forKey:kGenderKey];
//    }
//    if (self.password) {
//        [dict setObject:self.password  forKey:kPasswordKey];
//    }
//    if (self.address) {
//        [dict setObject:self.address forKey:kAdressKey];
//    }
//    if (geoPlaceId) {
//        [dict setObject:geoPlaceId forKey:@"GEOPLACEID"];
//        
//    }
//    if (self.promocode) {
//        [dict setObject:self.promocode forKey:kPromoKey];
//    }
//    if( alterPhone){
//        [dict setObject:alterPhone forKey:@"ALTERTPHONE"];
//    }
//}


@end
