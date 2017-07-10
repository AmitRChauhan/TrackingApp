//
//  FleetVC.m
//  TrackingApp
//
//  Created by sumo on 06/07/17.
//  Copyright © 2017 Snowtint Snowtint. All rights reserved.
//

#import "FleetVC.h"
#import "SWRevealViewController.h"

@interface FleetVC () <SWRevealViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *shadowView;

@end

@implementation FleetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.revealViewController.delegate =self;
    self.shadowView.hidden = YES;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)toggleBtnAction:(UIBarButtonItem *)sender {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    [self.revealViewController revealToggleAnimated:YES];
    [self.revealViewController setRearViewRevealWidth:screenWidth-70];
    _shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];

}

#pragma SwrevalViewController Delegate

/* This delegate method to tap auto-hide Left Side Navigation Drawer when tapped outside the Drawer */
- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:
(FrontViewPosition)position{
    if (position == FrontViewPositionRight){
        UIView *topview = [[UIView alloc]initWithFrame:self.view.frame];
        [topview setTag:111];
        [self.view addSubview:topview];
        SWRevealViewController *reveleViewController = self.revealViewController;
        if (reveleViewController){
            [topview addGestureRecognizer:self.revealViewController.panGestureRecognizer];
            [topview addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
            self.shadowView.hidden = NO;
            _shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];

            
        }
    }else if (position == FrontViewPositionLeft)
    {
        UIView *lower = [self.view viewWithTag:111];
        [lower removeFromSuperview];
        [UIView animateWithDuration:.1
                              delay:0
                            options:(UIViewAnimationOptionBeginFromCurrentState)
                         animations:^{
                             
                             [self.view layoutIfNeeded];
                             
                         } completion:^(BOOL finished) {
                             
                             self.shadowView.hidden = YES;
                             
                             
                             
                         }];

        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}


@end
