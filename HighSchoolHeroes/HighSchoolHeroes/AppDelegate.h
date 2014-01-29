//
//  AppDelegate.h
//  HighSchoolHeroes
//
//  Created by Randy Collier on 1/17/14.
//  Copyright (c) 2014 Randy Collier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSString *school;
@property (nonatomic, strong) NSString *sport;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic) BOOL dataHasChangedForSchedule;
@property (nonatomic) BOOL dataHasChangedForRoster;

@end
