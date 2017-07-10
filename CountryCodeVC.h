//
//  CountryCodeVC.h
//  Vow Passenger
//
//  Created by sumo on 06/04/17.
//  Copyright © 2017 Innate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryModel.h"

@protocol CountryDelegate<NSObject>

-(void)sendNameToLogin:(CountryModel *)selectedCountryDetails;

@end


@interface CountryCodeVC : UIViewController


@property (weak,nonatomic) id<CountryDelegate>delegate;
@end
