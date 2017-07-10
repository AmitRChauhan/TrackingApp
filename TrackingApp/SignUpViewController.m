//
//  SignUpViewController.m
//  TrackingApp
//
//  Created by Snowtint Snowtint on 30/01/17.
//  Copyright © 2017 Snowtint Snowtint. All rights reserved.
//

#import "SignUpViewController.h"
#import "PCUser.h"
#import "NSString+Additions.h"

@interface SignUpViewController ()
{

BOOL    _isLoginloadView;
PCUser   *_customer;

}

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITextField *NameField = [[UITextField alloc] init];
    
    _MobileNumber.delegate= self;
    
//    _NameField.rightViewMode = UITextFieldViewModeAlways;
//_NameField.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yellowtick.png"]];
//    _MobileNumber.rightViewMode = UITextFieldViewModeAlways;
//_MobileNumber.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yellowtick.png"]];
//    _Password.rightViewMode = UITextFieldViewModeAlways;
//_Password.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yellowtick.png"]];
//    _EmailId.rightViewMode = UITextFieldViewModeAlways;
//_EmailId.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yellowtick.png"]];
//    _ConfrimPassword.rightViewMode = UITextFieldViewModeAlways;
//_ConfrimPassword.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yellowtick.png"]];

    
}

- (BOOL)checkEnterFielfIsOfEmailType {
    BOOL isEmail    =   NO;
    NSString    *strTemp                 =   self.EmailId.text;
    
    NSString *emailRegularExpression =  @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate   *emailTest         =  [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegularExpression];
    if ([emailTest evaluateWithObject:strTemp])
    {
        isEmail =   YES;
    }
    
    return isEmail;
    
}

- (NSString*)validatePhoneNumber {
    NSString  *mess                      = @"";
    
    if (_isLoginloadView)
    {
        _customer.phoneNumber = self.EmailId.text;
        
    }
    NSString    *strTemp                 =  _customer.phoneNumber;//_customer.phoneNumber = self.loginEmailTextField.text;
    if(_customer.phoneNumber.length>=1 )
    {
        
        NSString *phoneRegularExpression =  @"^[0-9]{10,12}$";
        NSPredicate   *phoneNumberTest         =  [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegularExpression];
        NSString *substring =_customer.phoneNumber;// [customerPhoneField.text substringFromIndex:[customerPhoneField.text length] - 10];
        
        if(_customer.phoneNumber.length>=10)
        {
            // substring = [_customer.phoneNumber substringFromIndex:[_customer.phoneNumber length] - 10];
            
        }
        
        //        if ( ![phoneNumberTest evaluateWithObject:strTemp]) {
        //            mess                         =   [mess stringByAppendingString:NSLocalizedString(@"Enter valid Phone Number", nil)];
        //            mess                         =   [mess stringByAppendingString:@"\n"];
        //
        //        }
        //        else if ([_customer.phoneNumber integerValue]==0 || ([substring integerValue]/1000000000)<=0)
        //        {
        //            mess                         =   [mess stringByAppendingString:NSLocalizedString(@"Enter valid Phone Number", nil)];
        //            mess                         =   [mess stringByAppendingString:@"\n"];
        //
        //        }
        
    }
    if(_customer.phoneNumber.length==0 )
    {
        mess                         =   [mess stringByAppendingString:NSLocalizedString(@"Enter valid Phone Number", nil)];
        
    }
    return mess;
}

- (NSString *)checkLoginDetailsToRegister {
    
    NSString  *mess                      = @"";
    
    NSString    *strTemp                 =   _customer.email;
    
    if (!([strTemp length]==0) ) {
        
        NSString *emailRegularExpression =  @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate   *emailTest         =  [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegularExpression];
        if (![emailTest evaluateWithObject:strTemp]) {
            mess                         =   [mess stringByAppendingString:NSLocalizedString(@"enter valid Email", nil)];
            mess                         =   [mess stringByAppendingString:@"\n"];
            
        }
    }
    else
    {
        mess                             =   [mess stringByAppendingString:NSLocalizedString(@"Email field is empty", nil)];
        mess                             =   [mess stringByAppendingString:@"\n"];
    }
    
    strTemp                              =  _customer.name.trimmedString;
    if ([strTemp length]==0)
    {
        mess                             =   [mess stringByAppendingString:NSLocalizedString(@"Name field is empty", nil)];
        mess                             =   [mess stringByAppendingString:@"\n"];
    }
    
    strTemp                              =  _customer.phoneNumber;
    if ([strTemp length]==0)
    {
        mess                             =   [mess stringByAppendingString:NSLocalizedString(@"phoneNumber field is empty", nil)];
        mess                             =   [mess stringByAppendingString:@"\n"];
    }
    
    if ( _customer.password.trimmedStringLength==0) {
        mess                         =   [mess stringByAppendingString:NSLocalizedString(@"Password field is empty", nil)];
        mess                         =   [mess stringByAppendingString:@"\n"];
        
    }
    
    
    if (![_customer.password isEqualToString:_customer.confirmPassword] && _customer.password.trimmedStringLength>1) {
        mess                         =   [mess stringByAppendingString:NSLocalizedString(@"Password did not match", nil)];
        mess                         =   [mess stringByAppendingString:@"\n"];
        
    }
    
    
    return mess;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)UserRegisterBtn:(id)sender {
    
    [self.view endEditing:YES];
    NSString *isValidate     = [self checkLoginDetailsToRegister];
    
    if ([isValidate isEqualToString:@""]) {
        isValidate = [self validatePhoneNumber];
    }
    
    if([isValidate isEqualToString:@""])
    {
//        [self callRegisterApi];
        
        
    }
    else
    {
        UIAlertView  *alert                    =   [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"INVALID_ENTRY_TEXT", nil) message:isValidate delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }

    
}
@end
