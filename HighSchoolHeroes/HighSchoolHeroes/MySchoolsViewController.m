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
    @property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
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
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    // Fetching Records and saving it in "fetchedRecordsArray" object
    self.mySchools = [delegate getMySchools];
    
    if (self.mySchools.count == 0)
    {
        [self.schoolsTableView setHidden:YES];
    }
    else
    {
        [self.schoolsTableView setHidden:NO];
        [self.schoolsTableView reloadData];
    }
    
    if (delegate.school == nil)
    {
        [self hideTabBar:self.tabBarController];
    }
    else
    {
        [self showTabBar:self.tabBarController];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = delegate.managedObjectContext;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
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
    return self.mySchools.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"schoolCell";
    SchoolCell *cell = [tableView
                        dequeueReusableCellWithIdentifier:CellIdentifier
                        forIndexPath:indexPath];
    
    // Configure the cell...
    School *school = [self.mySchools objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = school.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    School *school = [self.mySchools objectAtIndex:indexPath.row];
    
    delegate.school = school.name;
    delegate.sport = @"Football";
    delegate.sex = @"0";
    delegate.dataHasChangedForSchedule = YES;
    delegate.dataHasChangedForRoster = YES;
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
}

- (void) hideTabBar:(UITabBarController *) tabbarcontroller
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.0];
    float fHeight = screenRect.size.height;
    if(  UIDeviceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) )
    {
        fHeight = screenRect.size.width;
    }
    
    for(UIView *view in tabbarcontroller.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, fHeight, view.frame.size.width, view.frame.size.height)];
        }
        else
        {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, fHeight)];
            view.backgroundColor = [UIColor blackColor];
        }
    }
    [UIView commitAnimations];
}

- (void) showTabBar:(UITabBarController *) tabbarcontroller
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    float fHeight = screenRect.size.height - 49.0;
    
    if(  UIDeviceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) )
    {
        fHeight = screenRect.size.width - 49.0;
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.0];
    for(UIView *view in tabbarcontroller.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, fHeight, view.frame.size.width, view.frame.size.height)];
        }
        else
        {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, fHeight)];
        }
    }
    [UIView commitAnimations];
}

@end
