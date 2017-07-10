//
//  LoginViewController.m
//  Vow Passenger
//
//  Created by Vinay  on 22/03/17.
//  Copyright © 2017 Innate. All rights reserved.
//

#import "LoginViewController.h"
#import "SignUpVC.h"
//#import "PCViewController.h"
//#import "OtpViewController.h"
//#import "CountryCodeVC.h"
//#import "PCWebServiceManager.h"
//#import "SocialConnectViewController.h"
//#import "PasswordViewController.h"
//#import "PCWelcomeBackViewController.h"
//#import "RegistrationViewController.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[PCErrorHandler sharedErrorHandler] setNavigationController:self.navigationController];
//    [[PCAccountKitHandler sharedInstance] setNavigationController:self.navigationController];
//
//    [[self navigationController] setNavigationBarHidden:YES animated:YES];
   self.mobileNumber.delegate=self;
//    [_mobileNumber becomeFirstResponder];
  //  [_mobileNumber becomeFirstResponder];
    
    _mobileNumber.keyboardAppearance = UIKeyboardAppearanceDark;

//    [_mobileNumber resignFirstResponder];
    // Do any additional setup after loading the view.
    [self checkSampleForLoading];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self checkSampleForLoading];
}

-(void)checkSampleForLoading
{
    self.circularLoader.layer.masksToBounds = YES;
    self.circularLoader.layer.cornerRadius = CGRectGetWidth(self.circularLoader.frame)/2;
    self.circularLoader.lineWidth = 5;
    self.circularLoader.tintColor = [UIColor clearColor];//[UIColor colorWithRed:255/255.0f green:123/255.0f blue:32/255.0f alpha:0.8];
     self.circularLoader.backgroundColor = [UIColor clearColor];
}

-(void)resetCirculatColor:(BOOL)isReset
{
    self.nextOtp.selected = NO;

    if(isReset)
    {
        self.circularLoader.tintColor = [UIColor clearColor];//[UIColor colorWithRed:255/255.0f green:123/255.0f blue:32/255.0f alpha:0.8];
        self.circularLoader.backgroundColor = [UIColor clearColor];

    }
    else{
        self.circularLoader.tintColor = [UIColor colorWithRed:188/255.0f green:136/255.0f blue:55/255.0f alpha:1];
        self.circularLoader.backgroundColor = [UIColor colorWithRed:188/255.0f green:136/255.0f blue:55/255.0f alpha:0.1];
    }
   
}
-(BOOL)validatePhoneNo:(NSString *)candidate{
    
    NSString *emailRegex = @"[0-9]{10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}
-(void)showAlertControllerWithMsg:(NSString*)message withTitle:(NSString *)title{
    
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:@"Error"
                                message:message
                                preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okAction = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                               }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 10);
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    _currentText = textField;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (_currentText == _mobileNumber) {
        
        [_mobileNumber resignFirstResponder];
    }
    return YES;
}
-(BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}



- (IBAction)backVC:(id)sender {
    [self performSegueWithIdentifier:@"mySegue1" sender:self];
}


- (IBAction)dropDown:(id)sender {
    
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CountryCodeVC *country  = [main instantiateViewControllerWithIdentifier:@"CountryCodeVC"];
    country.delegate = self;
    [self presentViewController:country animated:YES completion:nil];

}


-(void)sendNameToLogin:(CountryModel *)model{
    
    self.phoneCode.text= [NSString stringWithFormat:@"+%@",model.countryMobileCode];
    
    NSLog(@"countryCode:%@",model.countryName);
    NSLog(@"countryCode:%@",model.countryMobileCode);
    
    
    self.flag.image = [UIImage imageNamed:model.countryFlag inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];

}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)nextOtp:(id)sender{
//    BOOL isValidPhoneNum = YES;
//    if (self.mobileNumber.text.length == 0) {
//        [self showAlertControllerWithMsg:@"Please Enter Mobile Number" withTitle:@"Error"];
//        isValidPhoneNum = NO;
//    } else if (![self validatePhoneNo: [_mobileNumber text]]){
//        [self showAlertControllerWithMsg:@"Please Enter Valid Mobile Number" withTitle:@"Error"];
//        isValidPhoneNum = NO;
//        
//    }
//    if(isValidPhoneNum){
//        [self doValidateNumberRegisterOrNot];
//        
//    }
//    else{
//
//    }
    
    SignUpVC * signupVC = [self.storyboard instantiateViewControllerWithIdentifier:@"signupID"];
    [self.navigationController pushViewController:signupVC animated:YES];
    
    
    

}

#pragma mark - Controller

-(void)showOtpCntrl
{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//    OtpViewController *Sign = [storyboard instantiateViewControllerWithIdentifier:@"OtpView"];
//    [self.navigationController pushViewController:Sign animated:YES];

}

-(void)showSocialConnectCntrl
{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//    SocialConnectViewController *signup = [storyboard instantiateViewControllerWithIdentifier:@"Connect"];
//    
//    [self.navigationController pushViewController:signup animated:YES];
    
}

-(void)showWelcomeBackCntrl
{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//    PCWelcomeBackViewController*passwd = [storyboard instantiateViewControllerWithIdentifier:@"PCWelcomeBackViewController"];
//    passwd.phoneNumber = self.mobileNumber.text;
//    passwd.cntryCode = self.phoneCode.text;
//
//    [self.navigationController pushViewController:passwd animated:YES];
    
}

-(void)showRegisterCntrlWithToken:(NSString *)token withId:(NSString *)kitid
{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//    RegistrationViewController *Sign = [storyboard instantiateViewControllerWithIdentifier:@"regscreen"];
//    Sign.phoneNumber = self.mobileNumber.text;
//    Sign.accountKitId = kitid;
//    Sign.token = token;
//    Sign.cntryCode = self.phoneCode.text;
//
//    [self.navigationController pushViewController:Sign animated:YES];
    
}

-(void)checkAccountVerify
{
//    [[PCAccountKitHandler sharedInstance] verifyPhoneNumber:self.mobileNumber.text withCntryCode:self.phoneCode.text onSuccess:^(id accountKitInfo) {
//        NSLog(@"inside account id = %@, acces token = %@",[accountKitInfo accountID],[accountKitInfo tokenString]);
//        [self showRegisterCntrlWithToken:[accountKitInfo tokenString] withId:[accountKitInfo accountID]];
//
//
//    } onError:^(NSError *error) {
//        
//    }];
}
#pragma mark - API

-(void)doValidateNumberRegisterOrNot
{

    [self resetCirculatColor:NO];
   // MBProgressHUD* tmhHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
   // tmhHUD.labelText = @"Loading";
    [self.circularLoader startAnimating];

//    [[PCWebServiceManager sharedInstance] loginWithPhoneNumber:self.mobileNumber.text onSuccess:^(id json) {
//        [self.circularLoader stopAnimating];
//        [self resetCirculatColor:YES];
//        self.nextOtp.selected = YES;
//
//        NSString* responseCode = [json objectForKey:@"RESPONSECODE"];
//        bool successCode = [[json objectForKey:@"SUCCESS"] integerValue] == 1 ? YES : NO;
//
//        if ([responseCode isEqualToString:@"000"] && successCode == YES) {
//
//            NSString* loginType = [json objectForKey:@"LOGINTYPE"];
//
//            if([loginType isEqualToString:@"N"])
//            {
//                // show pasword welcome back
//                [self showWelcomeBackCntrl];
//            }
//            else if ([loginType isEqualToString:@"FB"])
//            {
//                // show social connect page
//                [self showSocialConnectCntrl];
//
//            }
//            else if ([loginType isEqualToString:@"GPlus"])
//            {
//                // show social connect page
//                NSString* mseeage = [json objectForKey:@"MESSAGE"];
//
//                UIAlertController * alert = [UIAlertController
//                                             alertControllerWithTitle:nil
//                                             message:mseeage
//                                             preferredStyle:UIAlertControllerStyleAlert];
//                
//                
//                UIAlertAction* yesButton = [UIAlertAction
//                                            actionWithTitle:@"Ok"
//                                            style:UIAlertActionStyleDefault
//                                            handler:^(UIAlertAction * action) {
//                                                [self showSocialConnectCntrl];
//
//                                            }];
//                
//                
//                [alert addAction:yesButton];
//                
//                [self.navigationController presentViewController:alert animated:YES completion:nil];
//                
//
//            }
//            
//            
//            
//            
//        }
//        else if(successCode == NO){ // user not yet register show register
//            /// Call Account kit for verifiyt number thorught otp thn from its response get kit id and token and call register pi
//            [self checkAccountVerify];
//        }
//        
//    } error:^(NSError *error) {
//        [self.circularLoader stopAnimating];
//        [self resetCirculatColor:YES];
//
////        [[PCErrorHandler sharedErrorHandler] showDetailsOfError:error withDelegate:nil];
//
//    }];
    
}

#pragma mark -

- (IBAction)backBtnActionClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];

    
}




    @end

