//
//  CityViewController.h
//  HighSchoolHeroes
//
//  Created by Randy Collier on 1/28/14.
//  Copyright (c) 2014 Randy Collier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *selectCity;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSArray *cityNames;

@end
