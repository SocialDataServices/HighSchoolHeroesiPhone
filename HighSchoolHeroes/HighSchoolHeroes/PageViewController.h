//
//  PageViewController.h
//  HighSchoolHeroes
//
//  Created by Randy Collier on 1/25/14.
//  Copyright (c) 2014 Randy Collier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;

@end
