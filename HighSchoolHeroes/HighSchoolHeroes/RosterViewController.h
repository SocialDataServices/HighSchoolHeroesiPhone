//
//  RosterViewController.h
//  HighSchoolHeroes
//
//  Created by Randy Collier on 1/19/14.
//  Copyright (c) 2014 Randy Collier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RosterViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *schoolLabel;
@property (strong, nonatomic) IBOutlet UILabel *rosterLabel;
@property (strong, nonatomic) IBOutlet UITableView *rosterTable;

@property (nonatomic, strong) NSArray *roster; // of type Game
@property (nonatomic, strong) NSString *school;
@property (nonatomic, strong) NSString *sport;
@property (nonatomic, strong) NSString *sex;


@end
