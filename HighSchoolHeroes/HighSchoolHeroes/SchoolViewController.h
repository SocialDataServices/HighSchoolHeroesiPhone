//
//  SchoolViewController.h
//  HighSchoolHeroes
//
//  Created by Randy Collier on 1/28/14.
//  Copyright (c) 2014 Randy Collier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchoolViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *selectSchools;
- (IBAction)schedule:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSArray *schools;

@end
