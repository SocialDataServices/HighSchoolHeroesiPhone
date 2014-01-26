//
//  PlayerInfoViewController.h
//  HighSchoolHeroes
//
//  Created by Randy Collier on 1/25/14.
//  Copyright (c) 2014 Randy Collier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *heightLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UITextView *bioTextView;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;

@property (strong, nonatomic) NSString *playerName;
@property (strong, nonatomic) NSString *playerNumber;
@property (strong, nonatomic) NSString *playerYear;
@property (strong, nonatomic) NSString *playerHeight;
@property (strong, nonatomic) NSString *playerWeight;
@property (strong, nonatomic) NSString *playerPosition;

@end
