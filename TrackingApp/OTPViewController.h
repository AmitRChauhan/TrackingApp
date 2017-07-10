//
//  OTPViewController.h
//  TrackingApp
//
//  Created by Snowtint Snowtint on 07/02/17.
//  Copyright © 2017 Snowtint Snowtint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTPViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *ResendOtp;
- (IBAction)OtpBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *Next;
- (IBAction)UsernextBtn:(id)sender;

@end
