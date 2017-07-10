//
//  SignInViewController.h
//  TrackingApp
//
//  Created by Snowtint Snowtint on 30/01/17.
//  Copyright © 2017 Snowtint Snowtint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *MobileNumber;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *SignIn;
- (IBAction)userSignInBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ForgotPwd;
- (IBAction)PasswordBtn:(id)sender;

@end
