//
//  ViewController.h
//  TrackingApp
//
//  Created by Snowtint Snowtint on 30/01/17.
//  Copyright © 2017 Snowtint Snowtint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *LogoImageView;

@property (weak, nonatomic) IBOutlet UIButton *SingUp;

@property (weak, nonatomic) IBOutlet UIButton *SignIn;

- (IBAction)SignUp:(id)sender;

- (IBAction)SignIn:(id)sender;

@end

