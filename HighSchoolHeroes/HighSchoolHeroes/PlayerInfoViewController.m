//
//  PlayerInfoViewController.m
//  HighSchoolHeroes
//
//  Created by Randy Collier on 1/25/14.
//  Copyright (c) 2014 Randy Collier. All rights reserved.
//

#import "PlayerInfoViewController.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
	
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
