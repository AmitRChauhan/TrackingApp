//
//  CountryCell.h
//  Vow Passenger
//
//  Created by sumo on 06/04/17.
//  Copyright © 2017 Innate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountryCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *cImg;
@property (strong, nonatomic) IBOutlet UILabel *cTitle;
@property (weak, nonatomic) IBOutlet UILabel *cCode;

@end
