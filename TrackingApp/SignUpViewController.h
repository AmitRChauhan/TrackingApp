//
//  SignUpViewController.h
//  TrackingApp
//
//  Created by Snowtint Snowtint on 30/01/17.
//  Copyright © 2017 Snowtint Snowtint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *NameField;
@property (weak, nonatomic) IBOutlet UITextField *MobileNumber;
@property (weak, nonatomic) IBOutlet UITextField *EmailId;
@property (weak, nonatomic) IBOutlet UITextField *Password;
@property (weak, nonatomic) IBOutlet UITextField *ConfrimPassword;
@property (weak, nonatomic) IBOutlet UIButton *RegisterButton;
- (IBAction)UserRegisterBtn:(id)sender;

@end
