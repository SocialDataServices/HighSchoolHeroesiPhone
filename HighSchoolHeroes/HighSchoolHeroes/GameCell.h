//
//  GameCell.h
//  HighSchoolHeroes
//
//  Created by Randy Collier on 1/17/14.
//  Copyright (c) 2014 Randy Collier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *opponentLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;

@end
