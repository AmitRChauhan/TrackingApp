//
//  LoginViewController.h
//  Vow Passenger
//
//  Created by Vinay  on 22/03/17.
//  Copyright © 2017 Innate. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MRActivityIndicatorView.h"

#import "CountryCodeVC.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *backVC;
@property (weak, nonatomic) IBOutlet UILabel *mobileLbl;
@property (weak, nonatomic) IBOutlet UIImageView *flag;
@property (weak, nonatomic) IBOutlet UIButton *dropDown;
@property (weak, nonatomic) IBOutlet UITextField *mobileNumber;

@property (weak, nonatomic) IBOutlet UIButton *nextOtp;
- (IBAction)nextOtp:(id)sender;
@property (strong, nonatomic)UITextField *currentText;
@property (weak, nonatomic) IBOutlet MRActivityIndicatorView *circularLoader;

@property (weak,nonatomic) id<CountryDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *phoneCode;

@end
