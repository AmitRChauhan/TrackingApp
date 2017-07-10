//
//  PCWebServiceManager.h
//  Vow Passenger
//
//  Created by Bhavana on 25/05/17.
//  Copyright © 2017 Innate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"



@interface PCWebServiceManager : NSObject
{
  
}


+ (PCWebServiceManager *)sharedInstance;
- (void)loginWithSocialDetails:(NSDictionary *)loginDetails  onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError ;
- (void)updateRatingOfLastTrip:(NSString *)tripId WithRating:(NSString *)ratingValue andComment:(NSString *)comment onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
- (void)cancelBookingWithId:(NSString *)bookingId withReason:(NSString *)reason onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
- (void)registerWithSocialDetails:(NSDictionary *)loginDetails  onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError ;
- (void)registerWithDetails:(NSDictionary *)loginDetails  onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError ;
- (void)loginWithDetails:(NSDictionary *)loginDetails  onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError ;
- (void)loginWithPhoneNumber:(NSString *)phoneNumber  onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))ontError ;
- (void)checkServiceStatusonSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
- (void)loginOutOnSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError ;
-(void)getNearDriverWtihLocation:(NSDictionary *)pickLocation onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
- (void)getUserProfileDetailOnSuccess:(void(^)(id))onSuccess  error:(void(^)(NSError *))onError;

- (void)forgotPasswordForNumber:(NSString *)phoneNumber  withNewPswd:(NSString *)pswd forAccountToken:(NSString *)token ForAccountKitId:(NSString *)kitId  onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError ;
- (void)verifywithPswd:(NSString *)pswd onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError ;
- (void)updateProfileDetail:(NSString *)userEmail withPswd:(NSString *)pswd OnSuccess:(void(^)(id))onSuccess  error:(void(^)(NSError *))onError;
- (void)getAllNotificationOnSuccess:(void(^)(id))onSuccess  error:(void(^)(NSError *))onError;
- (void)clearAllNotificationOnSuccess:(void(^)(id))onSuccess  error:(void(^)(NSError *))onError;
- (void)clearNotificationwithNotificationId:(NSString *)notId OnSuccess:(void(^)(id))onSuccess  error:(void(^)(NSError *))onError;
- (void)updateProfilePic:(UIImage *)profilePic withFilePAth:(NSString *)path OnSuccess:(void(^)(id))onSuccess  error:(void(^)(NSError *))onError;
- (void)getVowCashOnSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
- (void)addRedeemCode:(NSString *)code OnSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
-(void)doPanicForCustomer:(NSDictionary *)customerDetail onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
- (void)getHomeDetailsOnSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
- (void)updateHomeDetails:(NSDictionary *)homeDetails onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
- (void)CheckAppVersionOnSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
- (void)getTokenForWalletForMobileNo:(NSString *)number withTripId:(NSString *)tripdId withAmt:(NSString *)amt onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
- (void)createBookingWithUserBookingDetails:(NSDictionary *)userBookingDetails onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
- (void)getPackagesWithsuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
- (void)getNewAmtTollerenceBasedOnCuntry:(NSString *)city onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;

- (void)addFavPlaceForCustomerWithPlace:(NSDictionary *)place  onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
- (void)removeFavPlaceId:(NSString *)placeId  onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
- (void)getFavPlacesonSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
- (void)getAllSosContactonSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;

- (void)addSosContact:(NSDictionary *)sosInfo onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;

- (void)removeSosContact:(NSDictionary *)sosInfo  onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;

- (void)getTripsDetailForTripId:(NSString *)tripId onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
- (void)getAllTripsWithTripStatus:(NSString *)tripStatus withStartIndex:(NSString *)startIndex withEndIndex:(NSString *)endIndex onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
- (void)getTrackdetailsForTrip:(NSString *)tripId onSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;

- (void)getActiveTriponSuccess:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;

@end
