//
//  MyTeamsViewController.h
//  HighSchoolHeroes
//
//  Created by Randy Collier on 1/28/14.
//  Copyright (c) 2014 Randy Collier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StateViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *selectState;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (strong, nonatomic) NSArray *stateNames;

@end
