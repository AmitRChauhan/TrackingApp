//
//  SignUpVC.m
//  TrackingApp
//
//  Created by sumo on 05/07/17.
//  Copyright © 2017 Snowtint Snowtint. All rights reserved.
//

#import "SignUpVC.h"
#import "PasswordVC.h"

@interface SignUpVC ()<UITextFieldDelegate>
{
    UITextField *activeField;

}
@property (strong, nonatomic) IBOutlet UITextField *firstNameTF;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTF;
@property (strong, nonatomic) IBOutlet UITextField *emailIdTF;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation SignUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // set delagate for textFields
    _firstNameTF.delegate = self;
    _lastNameTF.delegate = self;
    _emailIdTF.delegate = self;
    
     [self registerForKeyboardNotifications];
    
   
    
}

- (IBAction)hideKeyBoarad:(id)sender {
    [self.view endEditing:YES];
    
}
- (IBAction)backBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)nextBtnActionClicked:(id)sender {
    
    PasswordVC * passwordVC = [self.storyboard instantiateViewControllerWithIdentifier:@"passwordID"];
    [self.navigationController pushViewController:passwordVC animated:YES];
}




- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:)name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:)name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:activeField.frame animated:YES];
    }
}
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets=UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
    
    
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    activeField = nil;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    
    [self.view endEditing:YES];
    return YES;
}

- (void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated
{
    
}
@end
