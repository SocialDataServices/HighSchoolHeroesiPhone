//
//  SecondViewController.h
//  HighSchoolHeroes
//
//  Created by Randy Collier on 1/19/14.
//  Copyright (c) 2014 Randy Collier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UILabel *schoolLabel;
@property (strong, nonatomic) IBOutlet UILabel *scheduleLabel;
@property (strong, nonatomic) IBOutlet UITableView *scheduleTable;

@property (nonatomic, strong) NSArray *schedule; // of type Game
@property (nonatomic, strong) NSString *school;
@property (nonatomic, strong) NSString *sport;
@property (nonatomic, strong) NSString *sex;

@end
