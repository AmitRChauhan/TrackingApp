//
//  SignInViewController.m
//  TrackingApp
//
//  Created by Snowtint Snowtint on 30/01/17.
//  Copyright © 2017 Snowtint Snowtint. All rights reserved.
//

#import "SignInViewController.h"
#import "ChangePwdViewController.h"
#import "MapScreenViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)userSignInBtn:(id)sender {
    MapScreenViewController *map = [self.storyboard instantiateViewControllerWithIdentifier:@"MapSign"];
    
    [self.navigationController pushViewController:map animated:YES];
    
    
}
- (IBAction)PasswordBtn:(id)sender {
    }
@end
