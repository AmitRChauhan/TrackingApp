//
//  MenuViewController.h
//  TrackingApp
//
//  Created by sumo on 05/07/17.
//  Copyright © 2017 Snowtint Snowtint. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenuTableViewCell;

@interface MenuViewController : UIViewController
{
    MenuTableViewCell *preSelectedCell;
}
@property (weak, nonatomic) IBOutlet UIImageView *proImg;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)didTapOnHideSlideBar:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *Edit;
- (IBAction)EditBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *proLbl;
@property (weak, nonatomic) IBOutlet UIView *proView;
@property (weak, nonatomic) IBOutlet UILabel *Phoneno;


@end
