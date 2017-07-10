//
//  PCUserDefaults.h
//  Passenger
//
//  Created by Snowtint on 11/12/14.
//  Copyright (c) 2014 Snowtint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCUserDefaults : NSObject

+(PCUserDefaults *)sharedUserDefaults;


- (void)storeFBAuthData:(NSString *)accessToken expiresAt:(NSDate *)expiresAt;
-(void)removeFBAuthDetails;
-(void)storeFBUserDetails:(NSDictionary*)details;
-(NSDictionary*)fbUserDetails;

-(void)removeAccessToken;
-(void)setAccessToken:(NSString*)accessToken;
-(NSString*)accessToken;
-(void)storeDevicePushNotificationToken:(NSString*)devieToken;
-(NSString*)devicePushNotificationToken;

-(void)setUserId:(NSString*)userId;
-(NSString*)userId;
-(void)storeUserDetails:(NSDictionary*)details;
-(void)storeWellWisherDetails:(NSArray*)details;
-(NSArray*)UserWellWisherDetails;

-(void)setPromoCode:(NSString*)code;
-(NSString*)getPromoCode;

-(void)setStoredServiceTime:(NSString*)time;
-(NSString*)getStoredServiceTime;

-(void)setNewAmtTollerence:(NSString*)amt;
-(NSString*)getNewAmtTollerence;


-(void)setLocationData:(NSString*)cntrycode withState:(NSString*)statecode;
-(NSString*)getCityCode;
-(NSString*)getStateCode;


-(void)storeLocation:(NSString*)location;
-(NSString*)getLastLocation;

-(NSDictionary*)UserDetails;
-(void)removeLoginDetails;


-(BOOL)isUserLogedIn;
-(void)setUserLogedinState:(BOOL)islogin;

-(BOOL)isKeyIsUsedForDirectionGoogleAPI;
-(void)setKeyIsUsedForDirectionGoogleAPI:(BOOL)isUsed;

#pragma mark- setting details
-(NSDictionary *)getPanicDetails;
-(void)setPanicDetails:(NSDictionary *)panicDetail;

-(void)setServiceTax:(NSString*)amt;
-(NSString*)getServiceTax;

-(void)setFareChartUrl:(NSString*)url;
-(NSString*)getFareChartUrl;

-(void)setCallSupportNo:(NSString*)number;
-(NSString*)getCallSupportNo;

-(void)setGooglePlaceKey:(NSString*)key;
-(NSString*)getGoogleDirectionKey;
-(void)setGoogleDirectionKey:(NSString*)key;

-(NSString*)getGooglePlaceKey;


-(void)setCountryCode:(NSString*)code;
-(NSString*)getCountryCode;



@end
