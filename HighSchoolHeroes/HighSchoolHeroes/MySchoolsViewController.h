//
//  MyTeamsViewController.h
//  HighSchoolHeroes
//
//  Created by Randy Collier on 1/29/14.
//  Copyright (c) 2014 Randy Collier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySchoolsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *mySchools;
@property (weak, nonatomic) IBOutlet UITableView *schoolsTableView;

@end
