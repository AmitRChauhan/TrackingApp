//
//  MapScreenViewController.m
//  TrackingApp
//
//  Created by Snowtint Snowtint on 31/01/17.
//  Copyright © 2017 Snowtint Snowtint. All rights reserved.
//

#import "MapScreenViewController.h"
#import "SWRevealViewController.h"




@interface MapScreenViewController ()<SWRevealViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *shadowView;


@end

@implementation MapScreenViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
   
 
    
    
}

- (void) viewWillAppear:(BOOL)animated
{
    self.shadowView.hidden = YES;
}

- (IBAction)toggleBtnAction:(UIBarButtonItem *)sender {
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    [self.revealViewController revealToggleAnimated:YES];
    [self.revealViewController setRearViewRevealWidth:screenWidth-70];
    self.shadowView.hidden = NO;
    self.revealViewController.delegate =self;
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
