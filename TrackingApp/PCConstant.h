//
//  PCConstant.h
//  Passenger
//
//  Created by Snowtint on 11/12/14.
//  Copyright (c) 2014 Snowtint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCConstant : NSObject
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define isPhone568 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568)
#define isPhoneLessThan568 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height <= 568)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_STANDARD_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height >= 667.0  && IS_OS_8_OR_LATER)
#define IS_STANDARD_IPHONE_6_plus (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0  && IS_OS_8_OR_LATER)

#pragma mark -
#pragma mark settings Code
#define kCallSuport                                            @"CALLSUPPORT"
#define kFareChart                                            @"FareChart"
#define kServiceTax                                            @"ServiceTax"
#define kPanicNumber                                                  @"Panic number"
#define kGooglePlaceKey                                                  @"google place key"
#define kGoogleDirectionKey                                                  @"google direction key"
#define kNotificationServerKey                  @"server_key"
#define kNotificationCodeKey                    @"code"
#define kContryCodeeKey                    @"Cntrycode"
#define kStateCodeeKey                    @"statecode"
#define kCityCodeeKey                    @"citycode"


#define kCustomerId                                            @"CUSTOMERID"
#define kAccessToken                                            @"Access_Token"
#define kDEVICETYPE                                             @"IOS"
#define kDEVICETYPEKey                                             @"DEVICETYPE"
#define kDEVICEIDKey                                               @"DEVICEID"
#define kPUSHTOKEN                                             @"PUSHTOKEN"
#define kAPPVERSION                                             @"1.0.1"

#pragma mark -
#pragma mark Resonse Code From API

#define kResponceCode                           @"RESPONSECODE"
#define kResponceData                           @"CUSTOMER"
#define kResponceDataToken                      @"SESSIONID"
#define KINVITECODE                                            @"INVITECODE"
#define KNEWAMTTOLLERENCE                                            @"Amount tollerence"
#define KSERVICEUPDATEDTIME                                            @"Service updatd time"
#define KSERIVCECURRETNTLOCATION                                            @"user location"
#define kRemberSetting                          @"rememberselected"
#define kDirectionKEy                          @"directionKey"

#define kRemoteNotificationTokenAvailableNotification @"Rmote notification token avilable"
#define KCountryChanged @"Country Changed"
#define kRemoteNotificationAvailableFrTrackNotification @"Rmote notification token For track screen"

typedef enum
{
    eResponseSuccess            =   000,
    eResponseWrongEntryFound     =   101,
    eResponseOtherError         =   999,
    eResponseNotregisterError         =   105

}PCResponceCodeType;





#pragma mark - FaceBook Contstant
#define kPCFBDidLoginNotifictaion                              @"Facebook Login With succes"
#define kPCUserFBLoginFailedNotification                       @"Facebook Login Failed"
#define kFBDidLoutNotifictaion                                 @"Facebook LogOut session"


#pragma mark -font
#define HelveticaNeue                           @"HelveticaNeue"
#define HelveticaNeue_Bold                      @"HelveticaNeue-Bold"
#define HelveticaNeue_Medium                    @"HelveticaNeue-Medium"
#define HelveticaNeue_Italic                    @"HelveticaNeue-Italic"
#define HelveticaNeue_BoldItalic                @"HelveticaNeue-BoldItalic"

#pragma mark -
#define KApplicationDidEnterBackground                           @"ApplicationDidEnterBackground"
#define KApplicationDidBecomeActive                             @"applicationDidBecomeActive"

#pragma mark - CLLOcation Manger
#define kLocationDidUpdateLocations                    @"LocationDidUpdateLocations"
#define kPCLocationDidChangeNotification                    @"LocationDidChange"

#pragma mark -  Login Api 

#define KLoginNAMEKey                          @"NAME"
#define KLoginPhoneKey                          @"PHONE"
#define KLoginEmailKey                              @"EMAIL"
#define KLoginPasswordKey                           @"PASSWORD"



#define kBBImageLoadingCompletedNotification    @"kBBImageLoadingCompletedNotification"
#define KSAMPATHPAYMANETURL   @"http://www.payments.vowcabs.com:1250/payment_init?amount="



@end


extern NSString const *kProfilePictureDidChangeNotification;
