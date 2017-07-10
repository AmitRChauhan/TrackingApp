//
//  IDViewControllersManager.m
//  Passenger
//
//  Created by Avinash on 16/10/15.
//  Copyright © 2015 Snowtint. All rights reserved.
//

#import "IDViewControllersManager.h"
#import "ProfileVC.h"

#import <MessageUI/MessageUI.h>
#import "AppDelegate.h"
//#import <Google/SignIn.h>

#define kEPSideMenuAnimationDuration  0.3;


@implementation IDViewControllersManager
@synthesize navigationController = _navigationController;

static IDViewControllersManager *sSharedControllersManager = nil;

#pragma mark -
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark                                                                    Singleton
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
+ (IDViewControllersManager *)sharedObject {
    @synchronized(self) {
        if(nil == sSharedControllersManager)
            [[self alloc] init];
    }
    return sSharedControllersManager;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    @synchronized(self) {
        if(nil == sSharedControllersManager)
            sSharedControllersManager = [super allocWithZone:zone];
        return sSharedControllersManager;
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}



#pragma mark -
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark                                                                    Memory + Initialisers
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
- (id)init {
    if(self = [super init]) {
        _currentViewController =  _rootViewController = [self mapViewControl];


        [self addSideMenuContanierView];
     
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countryChnged:) name:KCountryChanged object:nil];
//
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(remoteNotificationTokenAvialble:) name:kRemoteNotificationTokenAvailableNotification object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(remoteNotificationTrackAvialble:) name:kRemoteNotificationAvailableFrTrackNotification object:nil];

        
    }
    return self;
}

-(void)addSideMenuContanierView
{
    if(self.sideMenuContainerView != nil)
    {
        return;
    }
    UIWindow *theWindow     = [[UIApplication sharedApplication].delegate window];
    self.kEPSideMenuWidth = 250.0f;
    self.kEPSideMenuWidth = CGRectGetWidth(theWindow.bounds);
    
    self.dimView.frame = theWindow.bounds;
    [self.dimView setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0]];
    [theWindow addSubview:self.dimView];
    self.dimView.alpha = 0;
    
    self.sideMenuContainerView = [[UIView alloc] initWithFrame:CGRectMake(-_kEPSideMenuWidth, 0.0, CGRectGetWidth(theWindow.bounds), CGRectGetHeight(theWindow.bounds))];
    [self.sideMenuContainerView setBackgroundColor:[UIColor clearColor]];
    [self.sideMenuContainerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [theWindow addSubview:self.sideMenuContainerView];

    
    self.sideMenuContainerView.alpha = 0.5;

    [self.sideMenuContainerView addConstraint:[NSLayoutConstraint constraintWithItem:self.sideMenuContainerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:_kEPSideMenuWidth]];
    
    self.leadingContraint = [NSLayoutConstraint constraintWithItem:self.sideMenuContainerView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:theWindow attribute:NSLayoutAttributeLeading multiplier:1.0 constant:-_kEPSideMenuWidth];
    
    [self.leadingContraint setActive:YES];
    
    NSLayoutConstraint *topContraint = [NSLayoutConstraint constraintWithItem:self.sideMenuContainerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:theWindow attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    NSLayoutConstraint *bottomContraint = [NSLayoutConstraint constraintWithItem:self.sideMenuContainerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:theWindow attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];

    
    [theWindow addConstraint:self.leadingContraint];
    [theWindow addConstraint:topContraint];
    [theWindow addConstraint:bottomContraint];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];

    self._sideBarViewController = [storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];

    CGRect rect = CGRectMake(0, 0, CGRectGetWidth(self.sideMenuContainerView.frame), CGRectGetHeight(self.sideMenuContainerView.bounds));
    
    self._sideBarViewController.view.frame = rect;
    [self.sideMenuContainerView addSubview:self._sideBarViewController.view];
    [self.sideMenuContainerView setBackgroundColor:[UIColor clearColor]];
    [self._sideBarViewController.view setBackgroundColor:[UIColor clearColor]];

    
    
}

- (void)releaseAllControllers {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
   }

#pragma mark -
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark                                                                    Navigation handler
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
- (void)displayScreen:(EScreen)inScreen animated:(BOOL)inAnimation {
 
    UIViewController *oldViewController = _currentViewController;
    [oldViewController.view endEditing:YES];
    
    [self showSideMenu:NO];

    _displayedScreen = inScreen;

    switch (_displayedScreen) {
            
        case eHomeView:
            _currentViewController = [self mapViewControl];
            
            break;
        case eProfileView:
            _currentViewController = [self profileViewControl];

            break;
            
        case eFleetView:
            _currentViewController = [self fleetViewCntrl];
            break;

            
        case eAboutUsView:
            _currentViewController = [self aboutUsViewCntrl];
            break;
            
            
        case eLogOutView:
           // [self callLogoutAction];
            break;
            
            
 
            
              default:
            break;
    }

    if(_currentViewController != oldViewController) {
        if([_navigationController.viewControllers containsObject:_rootViewController])
            [_navigationController popToViewController:_rootViewController animated:NO];

        if(_navigationController.topViewController != _rootViewController)
            [_navigationController pushViewController:_rootViewController animated:NO];

        if(_currentViewController != _rootViewController)
            [_navigationController pushViewController:_currentViewController animated:NO];
    }
    else {
        if([_navigationController.viewControllers containsObject:_currentViewController])
        {
            if(_currentViewController != _navigationController.topViewController)
                [_navigationController popToViewController:_currentViewController animated:YES];
        }
        else
        {
            [_navigationController pushViewController:_currentViewController animated:YES];

        }
        
    }

    
}

- (void)showSideMenu:(BOOL)inValue {

    self.sideMenuContainerView.alpha = 1.0;
    [_currentViewController.view endEditing:YES];

    if(inValue)
    {
        [self showSideMenuController];
    }
    else
    {
        [self hideSideMenuController];
    }
}

-(void)hideSideMenuController
{
    UIWindow *theWindow     = [[UIApplication sharedApplication].delegate window];
    self.leadingContraint.constant = -self.kEPSideMenuWidth;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.dimView setAlpha:0];
        [theWindow layoutIfNeeded];
    }];
}

-(void)showSideMenuController
{
    self.leadingContraint.constant = 0;

    UIWindow *theWindow     = [[UIApplication sharedApplication].delegate window];
    [theWindow bringSubviewToFront:self.sideMenuContainerView];
    [self.dimView setFrame:theWindow.bounds];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.dimView setAlpha:1];
        [theWindow layoutIfNeeded];
    }];
}


-(void)showMailFeedback
{
    if ( [MFMailComposeViewController canSendMail] )
    {
        
        MFMailComposeViewController * mailComposer = [[MFMailComposeViewController alloc] init] ;
        mailComposer.delegate = self;
        mailComposer.mailComposeDelegate    =   self;

        [mailComposer setSubject:@"Feedback for Vow Cabs"];
        [mailComposer setToRecipients:[NSArray arrayWithObjects:@"info@vowcabs.com", nil]];
        [self.navigationController presentViewController:mailComposer animated:YES completion:nil];
       
        
    }
    else
    {
        NSLog(@"MFMailComposeViewController cant not send ");
    }

}

- (void)showFeedbackController {
    [self showSideMenu:NO];
    [self showMailFeedback];
    return;
    
    NSString *textToShare    = @"Share yours feedback to info@vowcabs.com";
//    NSURL *myWebsite = [NSURL URLWithString:@"http://www.vowcabs.com/"];
//    UIImage  *imageToShare   = [UIImage imageNamed:@"map.png"];
//    NSURL *toRecepient = [NSURL URLWithString:@"feedback@innateics.com"];
//    NSURL *recipients = [NSURL URLWithString:@"mailto:me@example.com?subject=Hi"];
//
   // NSArray  *objectsToShare = @[ self,myWebsite,recipients];
    NSArray  *objectsToShare = @[ textToShare];

  
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    NSArray *excludeActivities = @[UIActivityTypeAirDrop, UIActivityTypeCopyToPasteboard,UIActivityTypePrint, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll, UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr, UIActivityTypePostToVimeo];
 //   [activityVC setValue:@"adad" forKey:@"mailto"];
    [activityVC setValue:@"Feedback for Vow Cabs" forKey:@"subject"];
   // [activityVC setValue:[NSArray arrayWithObjects:@"feedback@innateics.com", nil] forKey:@"ToRecipients"];

    activityVC.excludedActivityTypes = excludeActivities;

    [self.navigationController presentViewController:activityVC animated:YES completion:nil];
}
#pragma mark -

-(void)navigateToAppStore
{
    NSString *iTunesLink =@"http://tinyurl.com/gsgqlaw";// @"itms://
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:iTunesLink]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink] options:@{} completionHandler:nil];
        
    }
}

#pragma mark - UIActivityViewController

-(void)countryChnged:(NSNotification *)notification
{

}

-(void)remoteNotificationTrackAvialble:(NSNotification*)notification
{
    NSDictionary *notificationObject = [notification object];
   // NSLog(@"Notifiaction showNotificationScreen: %@ code ",notificationObject);
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    if ( sessionID && customerId && notificationObject)
    {
        NSString *tripId = [notificationObject valueForKey:@"trip_id"];
      //  NSLog(@"Notifiaction showNotificationScreen: %@ code is %@ ",notificationObject,tripId);

        if (tripId) {

        }
    }
}

-(void)remoteNotificationTokenAvialble:(NSNotification*)notification
{
    
    NSString *token = [[PCUserDefaults sharedUserDefaults] devicePushNotificationToken];
    NSString *sessionID =[[PCUserDefaults sharedUserDefaults] accessToken];
    NSString *customerId   =[[PCUserDefaults sharedUserDefaults] userId];
    
    if (token && sessionID && customerId)
    {
       
        
    }
}

#pragma mark - UIActivityViewController
- (id)activityViewController:(UIActivityViewController *)activityViewController
         itemForActivityType:(NSString *)activityType
{
    if ([activityType isEqualToString:UIActivityTypeMail]) {
        return nil;
    }
       else {
        return nil;
    }
}

#pragma mark -
#pragma mark MFMailComposeViewController delegates
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    //  CDAppDelegate *app  =   ((CDAppDelegate *)[[UIApplication sharedApplication] delegate]);
    
    [controller dismissViewControllerAnimated:YES completion:^{
        //  [app cycleTheGlobalMailComposer];
        
    }];
}



#pragma mark -
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark                                                                    ViewControllers
//---------------------------------------------------------------------------------------------------------------------------------------------------------------

- (MapScreenViewController *)mapViewControl {
    
    
    
    if (!_rootViewController) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
        _rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"MapSign"];
        
    }
    return _rootViewController;
    
}


- (ProfileVC *)profileViewControl {

    
        
    if (!_profileViewController) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
        _profileViewController = [storyboard instantiateViewControllerWithIdentifier:@"profileID"];
        
    }
    return _profileViewController;

}


- (FleetVC *)fleetViewCntrl {
    if (!_fleetVCController) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
        _fleetVCController = [storyboard instantiateViewControllerWithIdentifier:@"fleetID"];
        
    }
    return _fleetVCController;
}

- (AboutUsVc *)aboutUsViewCntrl {
    if (!_aboutVCController) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
        _aboutVCController = [storyboard instantiateViewControllerWithIdentifier:@"aboutID"];
        
    }
    return _aboutVCController;
}













@end
