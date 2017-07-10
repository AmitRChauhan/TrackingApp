//
//  ViewController.m
//  TrackingApp
//
//  Created by Snowtint Snowtint on 30/01/17.
//  Copyright © 2017 Snowtint Snowtint. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "SocialIntegrationVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
     [IDViewControllersManager sharedObject].navigationController = self.navigationController;
    // Dispose of any resources that can be recreated.
}
- (IBAction)mobileNumberBtnClickedAction:(id)sender {
    
    LoginViewController * loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"loginID"];
    [self.navigationController pushViewController:loginVC animated:YES];
    
   
    
}
- (IBAction)socialBtnAction:(id)sender {
    
    SocialIntegrationVC * socialVC = [self.storyboard instantiateViewControllerWithIdentifier:@"socialID"];
    [self.navigationController pushViewController:socialVC animated:YES];
    
    
    
}









@end
