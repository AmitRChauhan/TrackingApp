//
//  PCWebServiceManager.m
//  Vow Passenger
//
//  Created by Bhavana on 25/05/17.
//  Copyright © 2017 Innate. All rights reserved.
//

#import "PCWebServiceManager.h"
#import "NSString+Encryption.h"
#import "NSString+SBJSON.h"
#import "NSObject+SBJSON.h"
#import "PCUserDefaults.h"
#import "NSDateAddtions.h"
#import "NSDateFormatter+Additions.h"
#import "NSString+MD5.h"




#define BASE_URL @"http://test.passenger.vowcabs.com:1220/CDTransReceiver.aspx"
#define UUID_USER_DEFAULTS_KEY @"UUID"

#define DECRYPTION_KEY @"ditgm@1985$$"
#define ENCRYPTION_KEY @"snowtint!@#$"
#define ENCRYPTION_ENABLED 1
#define DECRYPTION_ENABLED 0
#define App_Version 1.0

@implementation PCWebServiceManager

#pragma mark -
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark                                                                    Singleton
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
+ (PCWebServiceManager*)sharedInstance {
    
    static PCWebServiceManager *_sharedInstance;
    if(!_sharedInstance) {
        static dispatch_once_t oncePredicate;
        dispatch_once(&oncePredicate, ^{
            _sharedInstance = [[super allocWithZone:nil] init];
        });
    }
    
    return _sharedInstance;
}

+ (NSString *)GetUUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)string;
}


#pragma mark -
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark                                                                    Memory + initialisers
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
- (id)init {
    if( self = [super init]) {
        [self startReachability];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:UUID_USER_DEFAULTS_KEY] == nil) {
            [defaults setObject:[PCWebServiceManager GetUUID] forKey:UUID_USER_DEFAULTS_KEY];
            [defaults synchronize];
        }
    }
    return self;
}




#pragma mark -
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark                                                                    Rechability
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
- (BOOL)isReachable {
    return [[AFNetworkReachabilityManager sharedManager] isReachable];
}

- (void)startReachability {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}


#pragma mark -
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark                                                                Login
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
- (void)loginWithDetails:(NSDictionary *)loginDetails  onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError {
    
    
    NSMutableDictionary *deviceInfo    =   [[NSMutableDictionary alloc] init];
    [deviceInfo setObject:kDEVICETYPE forKey:kDEVICETYPEKey];
    [deviceInfo setObject:[[NSUserDefaults standardUserDefaults] objectForKey:UUID_USER_DEFAULTS_KEY] forKey:kDEVICEIDKey];
    [deviceInfo setObject:[NSString stringWithFormat:@"%f",App_Version] forKey:@"APPVERSION"];
    
    NSString *pushToken = [[PCUserDefaults sharedUserDefaults] devicePushNotificationToken];
    if (pushToken) {
        [deviceInfo setObject:pushToken forKey:kPUSHTOKEN];
        
    }
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"LOGINWITHNUMBER",
                                                                  deviceInfo,loginDetails,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"DEVICEINFO",@"CUSTOMER",
                                                                  nil]];
    
    NSString * inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
    
}

- (void)loginWithSocialDetails:(NSDictionary *)loginDetails  onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError {
    
    
    NSMutableDictionary *deviceInfo    =   [[NSMutableDictionary alloc] init];
    [deviceInfo setObject:kDEVICETYPE forKey:kDEVICETYPEKey];
    [deviceInfo setObject:[[NSUserDefaults standardUserDefaults] objectForKey:UUID_USER_DEFAULTS_KEY] forKey:kDEVICEIDKey];
    [deviceInfo setObject:[NSString stringWithFormat:@"%f",App_Version] forKey:@"APPVERSION"];
    
    NSString *pushToken = [[PCUserDefaults sharedUserDefaults] devicePushNotificationToken];
    if (pushToken) {
        [deviceInfo setObject:pushToken forKey:kPUSHTOKEN];
        
    }
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"LOGINFBGPLUSUSER",
                                                                  deviceInfo,loginDetails,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"DEVICEINFO",@"CUSTOMER",
                                                                  nil]];
    
    NSString * inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
    
}




- (void)registerWithDetails:(NSDictionary *)loginDetails  onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError {
    
    
    NSMutableDictionary *deviceInfo    =   [[NSMutableDictionary alloc] init];
    [deviceInfo setObject:kDEVICETYPE forKey:kDEVICETYPEKey];
    [deviceInfo setObject:[[NSUserDefaults standardUserDefaults] objectForKey:UUID_USER_DEFAULTS_KEY] forKey:kDEVICEIDKey];
    [deviceInfo setObject:[NSString stringWithFormat:@"%f",App_Version] forKey:@"APPVERSION"];
    
    NSString *pushToken = [[PCUserDefaults sharedUserDefaults] devicePushNotificationToken];
    [deviceInfo setObject:@"" forKey:kPUSHTOKEN];
    
    if (pushToken) {
        [deviceInfo setObject:pushToken forKey:kPUSHTOKEN];
        
    }
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"REGISTRATIONWITHNUMBER",
                                                                  deviceInfo,loginDetails,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"DEVICEINFO",@"CUSTOMER",
                                                                  nil]];
    
    NSString * inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
    
}

- (void)registerWithSocialDetails:(NSDictionary *)loginDetails  onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError {
    
    
    NSMutableDictionary *deviceInfo    =   [[NSMutableDictionary alloc] init];
    [deviceInfo setObject:kDEVICETYPE forKey:kDEVICETYPEKey];
    [deviceInfo setObject:[[NSUserDefaults standardUserDefaults] objectForKey:UUID_USER_DEFAULTS_KEY] forKey:kDEVICEIDKey];
    [deviceInfo setObject:[NSString stringWithFormat:@"%f",App_Version] forKey:@"APPVERSION"];
    
    NSString *pushToken = [[PCUserDefaults sharedUserDefaults] devicePushNotificationToken];
    if (pushToken) {
        [deviceInfo setObject:pushToken forKey:kPUSHTOKEN];
        
    }
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"REGISTRATIONWITHSOCIAL",
                                                                  deviceInfo,loginDetails,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"DEVICEINFO",@"CUSTOMER",
                                                                  nil]];
    
    NSString * inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
    
}


- (void)loginWithPhoneNumber:(NSString *)phoneNumber  onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))ontError {
    
    NSString * cntryCode = [[PCUserDefaults sharedUserDefaults] getCountryCode];
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"VALIDATEPHONE",
                                                                  phoneNumber,cntryCode,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"PHONE",@"COUNTRYCODE",
                                                                  nil]];
    
    NSString * inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:ontError];
    
}


- (void)checkServiceStatusonSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError {
    
    NSString * cntryCode = [[PCUserDefaults sharedUserDefaults] getCountryCode];
    NSString * userId = [[PCUserDefaults sharedUserDefaults] userId];
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"CHKSRV",
                                                                  userId,cntryCode,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"COUNTRYCODE",@"CUSTID",
                                                                  nil]];
    
    NSString * inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
    
}


- (void)loginOutOnSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError {
    
    NSMutableDictionary *deviceInfo    =   [[NSMutableDictionary alloc] init];
    [deviceInfo setObject:kDEVICETYPE forKey:kDEVICETYPEKey];
    [deviceInfo setObject:[[NSUserDefaults standardUserDefaults] objectForKey:UUID_USER_DEFAULTS_KEY] forKey:kDEVICEIDKey];
    NSString *pushToken = [[PCUserDefaults sharedUserDefaults] devicePushNotificationToken];
    if (pushToken) {
        // [deviceInfo setObject:pushToken forKey:kPUSHTOKEN];
        
    }
    
    
    NSMutableDictionary *loginDetail    =   [[NSMutableDictionary alloc] init];
    [loginDetail setObject:[[PCUserDefaults sharedUserDefaults] userId] forKey:@"CUSTOMERID"];
    [loginDetail setObject:[[PCUserDefaults sharedUserDefaults] accessToken] forKey:@"SESSIONID"];
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"LOGOUTUSER",
                                                                  loginDetail,
                                                                  deviceInfo,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"CUSTOMER",
                                                                  @"DEVICEINFO",
                                                                  nil]];
    
    NSString * inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
    
    
}



- (void)forgotPasswordForNumber:(NSString *)phoneNumber withNewPswd:(NSString *)pswd forAccountToken:(NSString *)token ForAccountKitId:(NSString *)kitId  onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError {
    
    NSMutableDictionary *custDetail    =   [[NSMutableDictionary alloc] init];
    [custDetail setObject:phoneNumber forKey:@"PHONE"];
    [custDetail setObject:kitId forKey:@"ACCOUNTKITID"];
    [custDetail setObject:token forKey:@"ACCOUNTKITTOKEN"];
    [custDetail setObject:pswd forKey:@"NEWPASSWORD"];
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"FORGOTPASSOWRD",
                                                                  custDetail,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"CUSTOMER",
                                                                  nil]];
    
    NSString * inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
    
}
#pragma mark -
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark                                                                    settings api
//---------------------------------------------------------------------------------------------------------------------------------------------------------------

- (void)getNewAmtTollerenceBasedOnCuntry:(NSString *)city onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
{
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    
    NSMutableDictionary *customerInfo    =   [[NSMutableDictionary alloc] init];
    [customerInfo setObject:sessionID forKey:@"SESSIONID"];
    [customerInfo setObject:customerId forKey:@"CUSTOMERID"];
    [customerInfo setObject:city forKey:@"COUNTRYCODE"];
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"GETNEWSETTINGS",
                                                                  customerInfo,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"CUSTOMER",
                                                                  nil]];
    
    NSString* inputParameters = [bodyDict JSONRepresentation];
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
    
}
#pragma mark- Place API

- (void)addFavPlaceForCustomerWithPlace:(NSDictionary *)place  onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
{
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    
    NSMutableDictionary *customerInfo    =   [[NSMutableDictionary alloc] init];
    [customerInfo setObject:sessionID forKey:@"SESSIONID"];
    [customerInfo setObject:customerId forKey:@"CUSTOMERID"];
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"ADDFAVPLACE",
                                                                  customerInfo,
                                                                  place,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"CUSTOMER",
                                                                  @"FAVPLACE",
                                                                  nil]];
    
    NSString* inputParameters = [bodyDict JSONRepresentation];
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
}


- (void)removeFavPlaceId:(NSString *)placeId  onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
{
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    
    NSMutableDictionary *customerInfo    =   [[NSMutableDictionary alloc] init];
    [customerInfo setObject:sessionID forKey:@"SESSIONID"];
    [customerInfo setObject:customerId forKey:@"CUSTOMERID"];
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"REMOVEFAVPLACE",
                                                                  customerInfo,
                                                                  placeId,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"CUSTOMER",
                                                                  @"FAVID",
                                                                  nil]];
    
    NSString* inputParameters = [bodyDict JSONRepresentation];
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
}

- (void)getFavPlacesonSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
{
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    
    NSMutableDictionary *customerInfo    =   [[NSMutableDictionary alloc] init];
    [customerInfo setObject:sessionID forKey:@"SESSIONID"];
    [customerInfo setObject:customerId forKey:@"CUSTOMERID"];
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"GETFAVPLACE",
                                                                  customerInfo,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"CUSTOMER",
                                                                  nil]];
    
    NSString* inputParameters = [bodyDict JSONRepresentation];
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
}
#pragma mark -
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark                                                        Home Screen
//---------------------------------------------------------------------------------------------------------------------------------------------------------------

- (void)updateRatingOfLastTrip:(NSString *)tripId WithRating:(NSString *)ratingValue andComment:(NSString *)comment onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
{
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    
    NSMutableDictionary *customerInfo    =   [[NSMutableDictionary alloc] init];
    [customerInfo setObject:sessionID forKey:@"SESSIONID"];
    [customerInfo setObject:customerId forKey:@"CUSTOMERID"];
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"UPDATETRIPRATING",
                                                                  customerInfo,
                                                                  tripId,
                                                                  ratingValue,
                                                                  comment,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"CUSTOMER",
                                                                  @"BOOKINGID",
                                                                  @"TRIPRATING",
                                                                  @"TRIPCOMMENT",
                                                                  nil]];
    NSString * inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
}



- (void)getActiveTriponSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
{
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    NSString * cntryCode = [[PCUserDefaults sharedUserDefaults] getCountryCode];
    
    NSMutableDictionary *customerInfo    =   [[NSMutableDictionary alloc] init];
    [customerInfo setObject:sessionID forKey:@"SESSIONID"];
    [customerInfo setObject:customerId forKey:@"CUSTOMERID"];
    [customerInfo setObject:cntryCode forKey:@"COUNTRYCODE"];
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"GETACTIVETRIP",
                                                                  customerInfo,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"CUSTOMER",
                                                                  nil]];
    NSString * inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
    
}


- (void)getPackagesWithsuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError {
    
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    NSString * cntryCode = [[PCUserDefaults sharedUserDefaults] getCountryCode];
    
    NSMutableDictionary *customerInfo    =   [[NSMutableDictionary alloc] init];
    [customerInfo setObject:sessionID forKey:@"SESSIONID"];
    [customerInfo setObject:customerId forKey:@"CUSTOMERID"];
    [customerInfo setObject:cntryCode forKey:@"COUNTRYCODE"];
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"PACKAGES",
                                                                  customerInfo,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"CUSTOMER",
                                                                  nil]];
    NSString * inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
}

-(void)getNearDriverWtihLocation:(NSDictionary *)pickLocation onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
{
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    
    NSMutableDictionary *customerInfo    =   [[NSMutableDictionary alloc] init];
    [customerInfo setObject:sessionID forKey:@"SESSIONID"];
    [customerInfo setObject:customerId forKey:@"CUSTOMERID"];
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"GETNEARBYDRIVER",
                                                                  pickLocation,
                                                                  @"0",
                                                                  customerInfo,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"PICKUPLOCATION",
                                                                  @"STATUS",
                                                                  @"CUSTOMER",
                                                                  nil]];
    NSString * inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
}
#pragma mark -
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark                                                                    SOS api
//---------------------------------------------------------------------------------------------------------------------------------------------------------------


- (void)getAllSosContactonSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
{
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    
    NSMutableDictionary *customerInfo    =   [[NSMutableDictionary alloc] init];
    [customerInfo setObject:sessionID forKey:@"SESSIONID"];
    [customerInfo setObject:customerId forKey:@"CUSTOMERID"];
    
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"GETALLSOSCONTACTINFO",
                                                                  customerInfo,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"CUSTOMER",
                                                                  nil]];
    
    NSString* inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
}

- (void)addSosContact:(NSDictionary *)sosInfo onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
{
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    
    NSMutableDictionary *customerInfo    =   [[NSMutableDictionary alloc] init];
    [customerInfo setObject:sessionID forKey:@"SESSIONID"];
    [customerInfo setObject:customerId forKey:@"CUSTOMERID"];
    [customerInfo setObject:sosInfo forKey:@"SOSINFO"];
    
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"ADDSOSCONTACTINFO",
                                                                  customerInfo,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"CUSTOMER",
                                                                  nil]];
    
    NSString* inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
}


- (void)removeSosContact:(NSDictionary *)sosInfo  onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
{
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    
    NSMutableDictionary *customerInfo    =   [[NSMutableDictionary alloc] init];
    [customerInfo setObject:sessionID forKey:@"SESSIONID"];
    [customerInfo setObject:customerId forKey:@"CUSTOMERID"];
    [customerInfo setObject:sosInfo forKey:@"SOSINFO"];
    
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"REMOVESOSCONTACTINFO",
                                                                  customerInfo,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"CUSTOMER",
                                                                  nil]];
    
    NSString* inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
}

#pragma mark -
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark                                                                    Trips api
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
- (void)getTripsDetailForTripId:(NSString *)tripId onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError
{
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    
    NSMutableDictionary *customerInfo    =   [[NSMutableDictionary alloc] init];
    [customerInfo setObject:sessionID forKey:@"SESSIONID"];
    [customerInfo setObject:customerId forKey:@"CUSTOMERID"];
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"GETUSERBOOKINGDETAIL",
                                                                  customerInfo,
                                                                  tripId,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"CUSTOMER",
                                                                  @"BOOKINGID",
                                                                  nil]];
    
    
    NSString* inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
    
}


- (void)getAllTripsWithTripStatus:(NSString *)tripStatus withStartIndex:(NSString *)startIndex withEndIndex:(NSString *)endIndex onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError
{
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    
    NSMutableDictionary *customerInfo    =   [[NSMutableDictionary alloc] init];
    [customerInfo setObject:sessionID forKey:@"SESSIONID"];
    [customerInfo setObject:customerId forKey:@"CUSTOMERID"];
    
    NSString* lastSyncTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"LASTSYNCTIME"];
    //  NSString* lastSyncTime = "2015-05-11 00:00:00";
    
    //    lastSyncTime = nil;
    if( lastSyncTime == nil ) {
        //        6/10/2014 10:28:22 AM
        lastSyncTime = [NSDateFormatter stringFromDate:[[[NSDate date] dateBySubtractingDays:5] dateAtStartOfDay] withFormat:@"M/d/YYYY hh:mm:ss a"];
    } else {
        NSDate *syncTime = [NSDateFormatter dateFromString:lastSyncTime withFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
        if( [syncTime diffrenceInDates:[NSDate date]] > 4 ) {
            lastSyncTime = [NSDateFormatter stringFromDate:[[[NSDate date] dateBySubtractingDays:4] dateAtStartOfDay] withFormat:@"M/d/YYYY hh:mm:ss a"];
        }
    }
    
    NSMutableDictionary *tripInfo    =   [[NSMutableDictionary alloc] init];
    [tripInfo setObject:startIndex forKey:@"STARTINDEX"];
    [tripInfo setObject:endIndex forKey:@"LIMITCOUNT"];
    
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"GETTRIPLIST",
                                                                  customerInfo,
                                                                  tripInfo,
                                                                  lastSyncTime,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"CUSTOMER",
                                                                  @"TRIPLIST",
                                                                  @"LASTSYNCTIME",
                                                                  nil]];
    
    NSString* inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
    
    
}


#pragma mark -
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark                                                                    Track API
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
- (void)getTrackdetailsForTrip:(NSString *)tripId onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
{
    
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    
    NSMutableDictionary *customerInfo    =   [[NSMutableDictionary alloc] init];
    [customerInfo setObject:sessionID forKey:@"SESSIONID"];
    [customerInfo setObject:customerId forKey:@"CUSTOMERID"];
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"TRACKDRIVER",
                                                                  customerInfo,
                                                                  tripId,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"CUSTOMER",
                                                                  @"TRIP",
                                                                  nil]];
    
    
    NSString* inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
}

#pragma mark -
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark                                                                    Token api
//---------------------------------------------------------------------------------------------------------------------------------------------------------------

- (void)getTokenForWalletForMobileNo:(NSString *)number withTripId:(NSString *)tripdId withAmt:(NSString *)amt onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
{
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    
    NSMutableDictionary *customerInfo    =   [[NSMutableDictionary alloc] init];
    [customerInfo setObject:sessionID forKey:@"SESSIONID"];
    [customerInfo setObject:customerId forKey:@"CUSTOMERID"];
    
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"GETNEWTOKEN",
                                                                  customerInfo,
                                                                  tripdId,
                                                                  number,
                                                                  amt,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"CUSTOMER",
                                                                  @"TRIPID",
                                                                  @"MOBILE",
                                                                  @"AMOUNT",
                                                                  nil]];
    
    NSString* inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
    
}


#pragma mark -
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark                                                        Booking Screen
//---------------------------------------------------------------------------------------------------------------------------------------------------------------

- (void)cancelBookingWithId:(NSString *)bookingId withReason:(NSString *)reason onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError
{
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    
    NSMutableDictionary *customerInfo    =   [[NSMutableDictionary alloc] init];
    [customerInfo setObject:sessionID forKey:@"SESSIONID"];
    [customerInfo setObject:customerId forKey:@"CUSTOMERID"];
    
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"CANCELUSERBOOKING",                                                                             customerInfo,
                                                                  bookingId,
                                                                  reason,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"CUSTOMER",
                                                                  @"BOOKINGID",
                                                                  @"USERCANCELREASON",
                                                                  nil]];
    
    
    
    
    NSString* inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
}

- (void)createBookingWithUserBookingDetails:(NSDictionary *)userBookingDetails onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError {
    
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    
    NSMutableDictionary *customerInfo    =   [[NSMutableDictionary alloc] init];
    [customerInfo setObject:sessionID forKey:@"SESSIONID"];
    [customerInfo setObject:customerId forKey:@"CUSTOMERID"];
    
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"CREATEUSERBOOKING",                                                                             customerInfo,
                                                                  userBookingDetails,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"CUSTOMER",
                                                                  @"BOOKING",
                                                                  nil]];
    
    
    
    
    NSString* inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
}

#pragma mark -
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark                                                        Notification
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
- (void)getAllNotificationOnSuccess:(void(^)(id))onSuccess  error:(void(^)(NSError *))onError;
{
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    
    NSMutableDictionary *customerInfo    =   [[NSMutableDictionary alloc] init];
    [customerInfo setObject:sessionID forKey:@"SESSIONID"];
    [customerInfo setObject:customerId forKey:@"CUSTOMERID"];
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"GETNOTIFICATIONLIST",
                                                                  customerInfo,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"CUSTOMER",
                                                                  nil]];
    NSString * inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
    
}

- (void)clearAllNotificationOnSuccess:(void(^)(id))onSuccess  error:(void(^)(NSError *))onError;
{
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    
    NSMutableDictionary *customerInfo    =   [[NSMutableDictionary alloc] init];
    [customerInfo setObject:sessionID forKey:@"SESSIONID"];
    [customerInfo setObject:customerId forKey:@"CUSTOMERID"];
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"CLEARALLNOTIFICATION",
                                                                  customerInfo,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"CUSTOMER",
                                                                  nil]];
    NSString * inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
}



- (void)clearNotificationwithNotificationId:(NSString *)notId OnSuccess:(void(^)(id))onSuccess  error:(void(^)(NSError *))onError;
{
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    
    NSMutableDictionary *customerInfo    =   [[NSMutableDictionary alloc] init];
    [customerInfo setObject:sessionID forKey:@"SESSIONID"];
    [customerInfo setObject:customerId forKey:@"CUSTOMERID"];
    
    NSMutableDictionary *notiInfo    =   [[NSMutableDictionary alloc] init];
    [notiInfo setObject:notId forKey:@"ID"];
    
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"CLEARNOTIFICATION",
                                                                  customerInfo,
                                                                  notiInfo,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"CUSTOMER",
                                                                  @"NOTIFICATION",
                                                                  nil]];
    NSString * inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
}
#pragma mark -
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark                                                        TMH
//---------------------------------------------------------------------------------------------------------------------------------------------------------------

- (void)getHomeDetailsOnSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
{
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    
    NSMutableDictionary *customerInfo    =   [[NSMutableDictionary alloc] init];
    [customerInfo setObject:sessionID forKey:@"SESSIONID"];
    [customerInfo setObject:customerId forKey:@"CUSTOMERID"];
    
    
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"GETTAKEMEHOME",
                                                                  customerInfo,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"CUSTOMER",
                                                                  nil]];
    NSString * inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
    
}

- (void)updateHomeDetails:(NSDictionary *)homeDetails onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
{
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    
    
    NSMutableDictionary *customerInfo    =   [[NSMutableDictionary alloc] init];
    [customerInfo setObject:sessionID forKey:@"SESSIONID"];
    [customerInfo setObject:customerId forKey:@"CUSTOMERID"];
    
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"UPDATEHOMEADDRESS",
                                                                  customerInfo,
                                                                  [homeDetails valueForKey:@"HOMEADDRESS"],
                                                                  [homeDetails valueForKey:@"LAT"],
                                                                  [homeDetails valueForKey:@"LNG"],
                                                                  [homeDetails valueForKey:@"CABPREF1"],
                                                                  [homeDetails valueForKey:@"CABPREF2"],
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"CUSTOMER",
                                                                  @"HOMEADDRESS",
                                                                  @"LAT",
                                                                  @"LNG",
                                                                  @"CABPREF1",
                                                                  @"CABPREF2",
                                                                  nil]];
    NSString * inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
    
}
#pragma mark -
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark                                                        Vow Cash
//---------------------------------------------------------------------------------------------------------------------------------------------------------------

- (void)getVowCashOnSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
{
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    
    NSMutableDictionary *customerInfo    =   [[NSMutableDictionary alloc] init];
    [customerInfo setObject:sessionID forKey:@"SESSIONID"];
    [customerInfo setObject:customerId forKey:@"CUSTOMERID"];
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"CUSTOMERVOWCASH",
                                                                  customerInfo,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"CUSTOMER",
                                                                  nil]];
    NSString * inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
}

- (void)addRedeemCode:(NSString *)code OnSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
{
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    NSString * cntryCode = [[PCUserDefaults sharedUserDefaults] getCountryCode];
    
    NSMutableDictionary *customerInfo    =   [[NSMutableDictionary alloc] init];
    [customerInfo setObject:sessionID forKey:@"SESSIONID"];
    [customerInfo setObject:customerId forKey:@"CUSTOMERID"];
    [customerInfo setObject:code forKey:@"PROMOCODE"];
    [customerInfo setObject:cntryCode forKey:@"COUNTRYCODE"];
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"REDEEMPROMOCODE",
                                                                  customerInfo,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"CUSTOMER",
                                                                  nil]];
    NSString * inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
}


-(void)doPanicForCustomer:(NSDictionary *)customerDetail onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
{
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    
    NSMutableDictionary *customerInfo    =   [[NSMutableDictionary alloc] init];
    [customerInfo setObject:sessionID forKey:@"SESSIONID"];
    [customerInfo setObject:customerId forKey:@"CUSTOMERID"];
    [customerInfo addEntriesFromDictionary:customerDetail];
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"CUSTOMERPANIC",
                                                                  customerInfo,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"CUSTOMER",
                                                                  nil]];
    NSString * inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
}
#pragma mark -
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark                                                        Profile
//---------------------------------------------------------------------------------------------------------------------------------------------------------------

- (void)updateProfilePic:(UIImage *)profilePic withFilePAth:(NSString *)path OnSuccess:(void(^)(id))onSuccess  error:(void(^)(NSError *))onError;
{
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    
    NSMutableDictionary *customerInfo    =   [[NSMutableDictionary alloc] init];
    [customerInfo setObject:sessionID forKey:@"SESSIONID"];
    [customerInfo setObject:customerId forKey:@"CUSTOMERID"];
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"UPDATEPROFILEPIC",
                                                                  customerInfo,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"CUSTOMER",
                                                                  nil]];
    NSString * inputParameters = [bodyDict JSONRepresentation];
    
    
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    
    NSDictionary* imageDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:encryptedString,
                                                                   nil]
                                                          forKeys:[NSArray arrayWithObjects:@"DATA1",
                                                                   nil]];
    //  encryptedString = @"FBEpqE0fphdkVPYF3cdkh%2f%2b1pdltkO8UAJhUqp486yvvGbYJqefV3Pv%2bW2D7V29NdVEqG5SMQZuGVlG9TXurfKn0%2flKZ6LRLR4PMCEwYsO%2br2ynBW90mkYxTVbQkFJcEZCeKcM3exx3ZtPPqNlcp2F2zGBOw611JxW8hUG1TibAL7ydkIPYZBU%2boycEboiyLckSxfIecdKbtS1rBPXOt4ZUibZxt6%2fGY%2b95aKKh%2bOcH%2bnToXg7ENu2zDrglfe3EL";
    
  //  encryptedString = [encryptedString percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding];
    
    [self setImageDataFromRequest:profilePic withPAth:path withEncrytedData:encryptedString onSuccess:onSuccess error:onError];
    
}


- (void)updateProfileDetail:(NSString *)userEmail withPswd:(NSString *)pswd OnSuccess:(void(^)(id))onSuccess  error:(void(^)(NSError *))onError;
{
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    
    NSMutableDictionary *customerInfo    =   [[NSMutableDictionary alloc] init];
    [customerInfo setObject:sessionID forKey:@"SESSIONID"];
    [customerInfo setObject:customerId forKey:@"CUSTOMERID"];
    [customerInfo setObject:userEmail forKey:@"EMAIL"];
    [customerInfo setObject:[pswd MD5] forKey:@"PASSWORD"];
    
    NSDictionary* bodyDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"UPDATEUSERPROFILE",
                                                                  customerInfo,
                                                                  nil]
                                                         forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                  @"CUSTOMER",
                                                                  nil]];
    NSString * inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
}

- (void)getUserProfileDetailOnSuccess:(void(^)(id))onSuccess  error:(void(^)(NSError *))onError;
{
    NSMutableDictionary *deviceInfo    =   [[NSMutableDictionary alloc] init];
    [deviceInfo setObject:kDEVICETYPE forKey:kDEVICETYPEKey];
    [deviceInfo setObject:[[NSUserDefaults standardUserDefaults] objectForKey:UUID_USER_DEFAULTS_KEY] forKey:kDEVICEIDKey];
    [deviceInfo setObject:[NSString stringWithFormat:@"%f",App_Version] forKey:@"APPVERSION"];
    
    NSString *pushToken = [[PCUserDefaults sharedUserDefaults] devicePushNotificationToken];
    if (pushToken) {
        //  [deviceInfo setObject:pushToken forKey:kPUSHTOKEN];
        
    }
    
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    
    NSMutableDictionary *customerInfo    =   [[NSMutableDictionary alloc] init];
    [customerInfo setObject:sessionID forKey:@"SESSIONID"];
    [customerInfo setObject:customerId forKey:@"CUSTOMERID"];
    
    NSDictionary* bodyDict =   [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"USERPROFILE",
                                                                    customerInfo,
                                                                    deviceInfo,
                                                                    nil]
                                                           forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                    @"CUSTOMER",
                                                                    @"DEVICEINFO",
                                                                    nil]];
    
    NSString * inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
    
}

- (void)verifywithPswd:(NSString *)pswd onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError ;
{
    
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    
    NSMutableDictionary *customerInfo    =   [[NSMutableDictionary alloc] init];
    [customerInfo setObject:sessionID forKey:@"SESSIONID"];
    [customerInfo setObject:customerId forKey:@"CUSTOMERID"];
    [customerInfo setObject:[pswd MD5] forKey:@"PASSWORD"];
    
    NSDictionary* bodyDict =   [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"VERIFYPASSWORD",
                                                                    customerInfo,
                                                                    nil]
                                                           forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                    @"CUSTOMER",
                                                                    nil]];
    
    NSString * inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
    
}

#pragma mark -
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark
//---------------------------------------------------------------------------------------------------------------------------------------------------------------


- (void)CheckAppVersionOnSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
{
    
    NSDictionary* bodyDict =   [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"CHECKAPPVERSION",
                                                                    kAPPVERSION,
                                                                    kDEVICETYPE,
                                                                    nil]
                                                           forKeys:[NSArray arrayWithObjects:@"OPCODE",
                                                                    @"APPVERSION",
                                                                    @"DEVICETYPE",
                                                                    nil]];
    
    NSString * inputParameters = [bodyDict JSONRepresentation];
    
#if ENCRYPTION_ENABLED
    NSString* encryptedString = [NSString AESEncrypt:inputParameters withKey:ENCRYPTION_KEY addChecksumHash:YES];
#else
    NSString * inputString = [NSString stringWithFormat:@"%@%@", BASE_URL, [inputParameters percentEscapedQueryStringPairMemberWithEncoding:NSUTF8StringEncoding]];
#endif
    
    [self getDataFromRequest:encryptedString onSuccess:onSuccess error:onError];
    
}
#pragma mark -
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark
//---------------------------------------------------------------------------------------------------------------------------------------------------------------

-(void)getDataFromRequest:(NSString *)parameters onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError {
    
    NSString * inputString = [NSString stringWithFormat:@"%@", BASE_URL];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer   =   [AFJSONResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"Accept", @"Content-Type",@"text/html", nil];
    
    [manager POST:inputString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"\n============== success ====\n%@",responseObject);
        onSuccess(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n============== ERROR ====\n%@",error.userInfo);
        onError(error);
    }];
    
    
}

-(void)set5ImageDataFromRequest:(UIImage * )pic withPAth:(NSString *)path withEncrytedData:(id )data onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError {
    
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"profilepic.png"];
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    
    
    AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
   // manager1.requestSerializer   =   [AFHTTPRequestSerializer serializer];
   // manager1.responseSerializer   =   [AFHTTPResponseSerializer serializer];
    manager1.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"Accept", @"Content-Type",@"text/html",@"ENCTYPE", nil];
    
    NSURLSessionTask *task = [manager1 POST:@"http://test.passenger.vowcabs.com:1220/imageUpload.aspx" parameters:data constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSError *error;
        if (![formData appendPartWithFileURL:fileURL name:@"avatar" fileName:[path lastPathComponent] mimeType:@"image/png" error:&error]) {
            NSLog(@"error appending part: %@", error);
        }
    }  progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"responseObject = %@", responseObject);
    } failure:^(NSURLSessionTask *task, NSError *error) {
        NSLog(@"error = %@", error);
    }];
    
    if (!task) {
        NSLog(@"Creation of task failed.");
    }
    
  }
-(void)setImageDataFromRequest:(UIImage * )pic withPAth:(NSString *)path withEncrytedData:(NSString * )data onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError

{
    NSURL *fileURL = [NSURL fileURLWithPath:path];

    NSData *imageToUpload = UIImageJPEGRepresentation(pic, 0.5);
    if (imageToUpload)
    {
        NSString *url=@"http://test.passenger.vowcabs.com:1220/imageUpload.aspx";
        AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
       
        
        [manager.requestSerializer setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
        
        manager.requestSerializer.timeoutInterval=600;
        
        [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
          //  [formData appendPartWithFileData:imageToUpload name:@"avatar" fileName:@"user.jpg" mimeType:@"file"];
              [formData appendPartWithFileURL:fileURL name:@"FILE" fileName:@"profilepic.jpeg" mimeType:@"image/jpeg" error:nil];

            [formData appendPartWithFormData:[data dataUsingEncoding:NSUTF8StringEncoding] name:@"DATA1"];

        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@" %@", responseObject);
            NSLog(@"\n==============setImageDataFromRequest success ====\n%@",responseObject);

            
            
        }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  if (error) {
                      NSLog(@"Error: %@", error);
                      NSString* ErrorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
                      NSLog(@"ErrorResponse=%@",ErrorResponse);
                      
                  }
                  
              }];
    }
}
-(void)set4ImageDataFromRequest:(UIImage * )pic withPAth:(NSString *)path withEncrytedData:(NSString * )data onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError {

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://test.passenger.vowcabs.com:1220/imageUpload.aspx"]];
    
    NSData *imageData = [[NSData alloc] initWithContentsOfFile:path];

    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:200];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = [self generateBoundaryString];
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=%@\r\n\r\n", @"DATA1"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
   /* // add image data
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=%@; filename=profilepic.jpeg\r\n", @"File"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    */
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%d", [body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
  
   NSURLSessionDataTask *dataTask =  [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"completion handler with response: %@", [NSHTTPURLResponse localizedStringForStatusCode:[(NSHTTPURLResponse*)response statusCode]]);
        NSLog(@"response: %i",[(NSHTTPURLResponse*)response statusCode]);
        
        NSInteger status = [(NSHTTPURLResponse*)response statusCode];
        
        if(error){
            NSLog(@"http request error: %@", error.localizedDescription);
            // handle the error
        }
        else{
            if (status == 201)
            { // handle the success
                
                
            }
            else
            {
                // handle the error
                
            }
        }

    }];
   [dataTask resume];
   /*
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
       
        NSLog(@"completion handler with response: %@", [NSHTTPURLResponse localizedStringForStatusCode:[(NSHTTPURLResponse*)response statusCode]]);
        NSLog(@"response: %i",[(NSHTTPURLResponse*)response statusCode]);
        
        NSInteger status = [(NSHTTPURLResponse*)response statusCode];
        
        if(error){
            NSLog(@"http request error: %@", error.localizedDescription);
            // handle the error
        }
        else{
            if (status == 201)
            { // handle the success
                
                
            }
                else
                {
                    // handle the error

                }
        }
    
       
    }];
    
    */
}

-(void)set40ImageDataFromRequest:(UIImage * )pic withPAth:(NSString *)path withEncrytedData:(id )data onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError {
    NSData *imageData = UIImageJPEGRepresentation(pic, 0.5);
    
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"profilepic.png"];
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    
    
    AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
    manager1.requestSerializer   =   [AFHTTPRequestSerializer serializer];
    manager1.responseSerializer   =   [AFHTTPResponseSerializer serializer];
    manager1.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"Accept", @"Content-Type",@"text/html",@"ENCTYPE", nil];

    //[AFHTTPRequestSerializer serializer]
    NSMutableURLRequest *request = [manager1.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:@"http://test.passenger.vowcabs.com:1220/imageUpload.aspx" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

      //  [formData appendPartWithFileURL:fileURL name:@"File" fileName:@"profilepic.png" mimeType:@"image/png" error:nil];
        [formData appendPartWithFormData:[data dataUsingEncoding:NSUTF8StringEncoding] name:@"DATA1"];
        
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
   
    
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
                          
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          NSLog(@"Error: %@", error);
                          NSString* ErrorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
                          NSLog(@"ErrorResponse=%@",ErrorResponse);
                          
                      } else {
                          NSLog(@"%@ %@", response, responseObject);
                          NSLog(@"\n==============setImageDataFromRequest success ====\n%@",responseObject);
                          
                      }
                  }];
    
    [uploadTask resume];
}


-(void)set1ImageDataFromRequest:(UIImage * )pic withPAth:(NSString *)path withEncrytedData:(NSString* )data onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError {
    
    NSString * inputString = @"http://test.passenger.vowcabs.com:1220/imageUpload.aspx";
    
    
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"profilepic.png"];
    // NSURL *fileURL = [NSURL fileURLWithPath:path];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer   =   [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSString *boundary = [self generateBoundaryString];

   // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/html", nil];
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [manager.requestSerializer setValue:contentType forHTTPHeaderField:@"ENCTYPE"];
    
    [manager POST:inputString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //  [formData appendPartWithFormData:data name:@"DATA1"];
        NSError *error;
        
        //  [formData appendPartWithFileURL:path name:@"File" error:nil];
        /*   BOOL success = [formData appendPartWithFileURL:fileURL name:@"image" fileName:filePath mimeType:@"image/png" error:&error];
         if (!success)
         NSLog(@"appendPartWithFileURL error: %@", error);
         else
         {
         //    [formData appendPartWithFileURL:fileURL name:@"File" error:nil];
         }
         */

        [formData appendPartWithFormData:[data dataUsingEncoding:NSUTF8StringEncoding] name:@"DATA1"];
//        BOOL success = [formData appendPartWithFileURL:fileURL name:@"File" error:nil];
//        
//        if(success) {
//            NSLog(@"Attached file successfully");
//        }
            [formData appendPartWithFileURL:fileURL name:@"File" error:nil];

        NSData *imageData = UIImageJPEGRepresentation(pic, 0.5);
       // [formData appendPartWithFileData:imageData name:@"File" fileName:@"image.jpeg" mimeType:@"image/jpeg"];
//        if(success) {
//            NSLog(@"Attached file successfully");
//        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"\n==============setImageDataFromRequest success ====\n%@",responseObject);
        onSuccess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n============== ERROR ====\n%@",error.userInfo);
        onError(error);
    }];
    
    
}

-(void)set2ImageDataFromRequest:(UIImage * )pic withPAth:(NSString *)path withEncrytedData:(id )data onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError
{
    NSString * inputString = @"http://test.passenger.vowcabs.com:1220/imageUpload.aspx";
    
    NSData *imageData = UIImageJPEGRepresentation(pic, 0.5);
    
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"image.png"];
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    
    
    AFHTTPSessionManager *manager2 =  [AFHTTPSessionManager manager];
    manager2.requestSerializer = [AFHTTPRequestSerializer serializer];
    [ manager2.requestSerializer setValue:@"multipart/form-data; boundary=0484d4db-ff8e-4ea4-a401-4589fd5a16a7" forHTTPHeaderField:@"Content-Type"];
    [ manager2.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    
    manager2.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager2.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/hal+json"];
    [manager2 POST:inputString parameters:data constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileURL:fileURL name:@"File" error:nil];

        [formData appendPartWithFileURL:fileURL name:@"File" error:nil];
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Error: %@", uploadProgress);
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@ ", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        
    }];
}

- (NSString *)generateBoundaryString {
    return [NSString stringWithFormat:@"Boundary-%@", [[NSUUID UUID] UUIDString]];
}
//-(void)getDataFromRequest:(NSURLRequest *)request onSuccess:(void(^)(id))success error:(void(^)(NSError *))error {
//
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//
//
//
//    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//        if (error) {
//            NSLog(@"Error: %@", error);
//           // onError(error);
//        } else {
//            NSLog(@"%@ %@", response, responseObject);
//            //onSuccess(success);
//        }
//    }];
//    [dataTask resume];
//
//}


@end
