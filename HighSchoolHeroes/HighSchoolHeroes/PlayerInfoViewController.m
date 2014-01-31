//
//  PlayerInfoViewController.m
//  HighSchoolHeroes
//
//  Created by Randy Collier on 1/25/14.
//  Copyright (c) 2014 Randy Collier. All rights reserved.
//

#import "PlayerInfoViewController.h"
#import "AppDelegate.h"

@interface PlayerInfoViewController ()

@end

@implementation PlayerInfoViewController

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
    if (delegate.dataHasChangedForRoster)
    {
        //self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:2];
        [self.navigationController popViewControllerAnimated:NO];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    self.nameLabel.text = self.playerName;
    self.numberLabel.text = self.playerNumber;
    self.yearLabel.text = self.playerYear;
    self.heightLabel.text = self.playerHeight;
    self.weightLabel.text = self.playerWeight;
    self.positionLabel.text = self.playerPosition;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
