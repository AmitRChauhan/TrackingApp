//
//  PCUserDefaults.m
//  Passenger
//
//  Created by Snowtint on 11/12/14.
//  Copyright (c) 2014 Snowtint. All rights reserved.
//

#import "PCUserDefaults.h"
#import "PCConstant.h"

static PCUserDefaults *sharedDefaults;
@implementation PCUserDefaults

+(PCUserDefaults *)sharedUserDefaults
{
    if (!sharedDefaults) {
        sharedDefaults  =   [[PCUserDefaults alloc] init];
    }
    return sharedDefaults;
}

+(id)allocWithZone:(NSZone*)inZone
{
    @synchronized(self)
    {
        if(nil == sharedDefaults)
        {
            sharedDefaults = [super allocWithZone:inZone];
            return sharedDefaults;  // assignment and return on first allocation
        }
    }
    return nil; //on subsequent allocation attempts return nil
}

-(id)copyWithZone:(NSZone *)inZone
{
    return self;
}


#pragma  mark - Facebook 

- (void)storeFBAuthData:(NSString *)accessToken expiresAt:(NSDate *)expiresAt
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:@"FBAccessTokenKey"];
    [defaults setObject:expiresAt forKey:@"FBExpirationDateKey"];
    [defaults synchronize];

}

-(void)removeFBAuthDetails
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"FBAccessTokenKey"];
    [defaults removeObjectForKey:@"FBExpirationDateKey"];
    [defaults removeObjectForKey:@"FBUSERDETAILS"];
    [defaults synchronize];
}

-(void)storeFBUserDetails:(NSDictionary*)details
{
    [[NSUserDefaults standardUserDefaults] setObject:details forKey:@"FBUSERDETAILS"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSDictionary*)fbUserDetails;
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"FBUSERDETAILS"];

}

#pragma  mark - User Access token

-(void)removeAccessToken;
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kResponceDataToken];
    [[NSUserDefaults standardUserDefaults]synchronize];

}

-(void)storeDevicePushNotificationToken:(NSString*)devieToken;
{
    [[NSUserDefaults standardUserDefaults] setObject:devieToken forKey:@"DEVICEPUSHTOKEN"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

-(NSString*)devicePushNotificationToken;
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"DEVICEPUSHTOKEN"];

}
#pragma mark -
#pragma mark Promocode


-(void)setPromoCode:(NSString*)code
{
    [[NSUserDefaults standardUserDefaults] setObject:code forKey:KINVITECODE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}



-(NSString*)getPromoCode
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:KINVITECODE];
    
}

#pragma mark -
#pragma mark Location




-(void)setStoredServiceTime:(NSString*)time
{
    [[NSUserDefaults standardUserDefaults] setObject:time forKey:KSERVICEUPDATEDTIME];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

-(NSString*)getStoredServiceTime;
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:KSERVICEUPDATEDTIME];

}


-(void)setNewAmtTollerence:(NSString*)amt;
{
    [[NSUserDefaults standardUserDefaults] setObject:amt forKey:KNEWAMTTOLLERENCE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString*)getNewAmtTollerence;
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:KNEWAMTTOLLERENCE];

}



-(void)storeLocation:(NSString*)location;
{
    [[NSUserDefaults standardUserDefaults] setObject:location forKey:@""];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

-(NSString*)getLastLocation
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@""];

}

-(void)setAccessToken:(NSString*)accessToken;
{
    [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:kResponceDataToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString*)accessToken;
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kResponceDataToken];
}

-(void)setUserId:(NSString*)userId;
{
    [[NSUserDefaults standardUserDefaults] setObject:userId forKey:kCustomerId];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString*)userId
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kCustomerId];

}

-(void)storeUserDetails:(NSDictionary*)details
{
    [[NSUserDefaults standardUserDefaults] setObject:details forKey:kResponceData];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSDictionary*)UserDetails;
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kResponceData];
    
}

-(void)storeWellWisherDetails:(NSArray*)details;
{
    [[NSUserDefaults standardUserDefaults] setObject:details forKey:@"WELLWISHER"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSArray*)UserWellWisherDetails;
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"WELLWISHER"];

}

-(void)removeLoginDetails
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kResponceDataToken];

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAccessToken];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCustomerId];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kResponceData];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"WELLWISHER"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KINVITECODE];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KSERVICEUPDATEDTIME];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kContryCodeeKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kRemberSetting];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kDirectionKEy];

    [[NSUserDefaults standardUserDefaults]synchronize];
}

#pragma mark-
#pragma mark  logined view
-(BOOL)isUserLogedIn
{
    return  [[[NSUserDefaults standardUserDefaults] valueForKey:kRemberSetting] boolValue];
    
}

-(void)setUserLogedinState:(BOOL)islogin
{
    [[NSUserDefaults standardUserDefaults] setBool:islogin forKey:kRemberSetting];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL)isKeyIsUsedForDirectionGoogleAPI;
{
    return  [[[NSUserDefaults standardUserDefaults] valueForKey:kDirectionKEy] boolValue];

}

-(void)setKeyIsUsedForDirectionGoogleAPI:(BOOL)isUsed;
{
    [[NSUserDefaults standardUserDefaults] setBool:isUsed forKey:kDirectionKEy];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark-
#pragma mark- setting details


-(NSDictionary *)getPanicDetails;
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kPanicNumber];

}


-(void)setPanicDetails:(NSDictionary *)panicDetail;
{
    [[NSUserDefaults standardUserDefaults] setObject:panicDetail forKey:kPanicNumber];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setServiceTax:(NSString*)amt;
{
    [[NSUserDefaults standardUserDefaults] setObject:amt forKey:kServiceTax];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString*)getServiceTax;
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kServiceTax];

}

-(void)setFareChartUrl:(NSString*)url;
{
    [[NSUserDefaults standardUserDefaults] setObject:url forKey:kFareChart];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString*)getFareChartUrl;
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kFareChart];

}

-(void)setCallSupportNo:(NSString*)number;
{
    [[NSUserDefaults standardUserDefaults] setObject:number forKey:kCallSuport];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString*)getCallSupportNo;
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kCallSuport];

}

-(void)setGooglePlaceKey:(NSString*)key;
{
    [[NSUserDefaults standardUserDefaults] setObject:key forKey:kGooglePlaceKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString*)getGooglePlaceKey;
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kGooglePlaceKey];
    
}

-(void)setGoogleDirectionKey:(NSString*)key;
{
    [[NSUserDefaults standardUserDefaults] setObject:key forKey:kGoogleDirectionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString*)getGoogleDirectionKey;
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kGoogleDirectionKey];
    
}

-(void)setLocationData:(NSString*)cntrycode withState:(NSString*)statecode
{
//    [[NSUserDefaults standardUserDefaults] setObject:cntrycode forKey:kCityCodeeKey];
//    [[NSUserDefaults standardUserDefaults] setObject:statecode forKey:kStateCodeeKey];

    [[NSUserDefaults standardUserDefaults] synchronize];
}

//-(NSString*)getCityCode;
//{
////    NSString *code = [[NSUserDefaults standardUserDefaults] objectForKey:kCityCodeeKey];
//    if(code == nil)
//    {
//        code = @"Bangalore";
//    }
//    return code;
//
//}

//-(NSString*)getStateCode;
//{
//    NSString *code = [[NSUserDefaults standardUserDefaults] objectForKey:kStateCodeeKey];
//    if(code == nil)
//    {
//        code = @"KR";
//    }
//    return code;
//
//}


//-(void)setCountryCode:(NSString*)code
//{
//    [[NSUserDefaults standardUserDefaults] setObject:code forKey:kContryCodeeKey];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//-(NSString*)getCountryCode;
//{
//    NSString *code = [[NSUserDefaults standardUserDefaults] objectForKey:kContryCodeeKey];
//    if(code == nil)
//    {
//        code = @"IN";
//    }
//    return code;
//
//}




@end
