//
//  MainViewController.h
//  HighSchoolHeroes
//
//  Created by Randy Collier on 1/25/14.
//  Copyright (c) 2014 Randy Collier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UIPageViewControllerDataSource>
- (IBAction)getStarted:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *getStartedButton;

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;

@end
