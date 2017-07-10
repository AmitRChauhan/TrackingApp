//
//  IDViewControllersManager.h
//  Passenger
//
//  Created by Avinash on 16/10/15.
//  Copyright © 2015 Snowtint. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import "IDAppRootViewController.h"
#import "ProfileVC.h"
//#import "IDWebViewController.h"
#import "FleetVC.h"
#import "AboutUsVc.h"
#import "MapScreenViewController.h"


@interface IDViewControllersManager : NSObject



@property (readonly, nonatomic) UIScreen*     displayedScreen;


@property (retain, nonatomic) UINavigationController        *navigationController;
@property (retain, nonatomic) MapScreenViewController       *rootViewController;
@property (assign, nonatomic) UIViewController              *currentViewController;
@property (retain, nonatomic) UIView       *sideMenuContainerView;
@property (retain, nonatomic) UIView       *dimView;
@property(assign,nonatomic)float kEPSideMenuWidth;
@property (retain, nonatomic) NSLayoutConstraint     * leadingContraint;

#pragma mark - controller

//@property (retain, nonatomic) NewBookingViewController       *homeViewController;
//@property (retain, nonatomic) IDWebViewController       *webViewController;
@property (retain, nonatomic) ProfileVC       *profileViewController;
@property (retain, nonatomic) FleetVC       *fleetVCController;
@property (retain, nonatomic) AboutUsVc       *aboutVCController;





#pragma mark -
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark                                                                    Singleton
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
+ (IDViewControllersManager *)sharedObject;

#pragma mark -
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark                                                                    Navigation handler
//---------------------------------------------------------------------------------------------------------------------------------------------------------------

- (void)showSideMenu:(BOOL)inValue;

- (void)logout;

- (void)showFeedbackController;


@end
