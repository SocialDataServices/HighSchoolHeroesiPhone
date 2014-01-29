//
//  MyTeamsViewController.m
//  HighSchoolHeroes
//
//  Created by Randy Collier on 1/29/14.
//  Copyright (c) 2014 Randy Collier. All rights reserved.
//

#import "MySchoolsViewController.h"
#import "SchoolCell.h"
#import "School.h"
#import "AppDelegate.h"

@interface MySchoolsViewController ()

@end

@implementation MySchoolsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    
    [self.schoolsTableView reloadData];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (delegate.mySchools.count == 0)
    {
        [self.schoolsTableView setHidden:YES];
    }
    else
    {
        [self.schoolsTableView setHidden:NO];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    return delegate.mySchools.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    static NSString *CellIdentifier = @"schoolCell";
    SchoolCell *cell = [tableView
                        dequeueReusableCellWithIdentifier:CellIdentifier
                        forIndexPath:indexPath];
    
    // Configure the cell...
    School *school = [delegate.mySchools objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = school.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    School *school = [delegate.mySchools objectAtIndex:indexPath.row];
    delegate.school = school.name;
    delegate.dataHasChangedForSchedule = YES;
    delegate.dataHasChangedForRoster = YES;
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
}

@end
