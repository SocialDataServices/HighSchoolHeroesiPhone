//
//  Game.m
//  HighSchoolHeroes
//
//  Created by Randy Collier on 1/17/14.
//  Copyright (c) 2014 Randy Collier. All rights reserved.
//

#import "Game.h"

@implementation Game

- (instancetype)initOnDate:(NSString *)date
           AgainstOpponent:(NSString *)opponent
                 WithScore:(NSString *)score
                AtLocation:(NSString *)location
{
    self = [super init];
    if (self)
    {
        self.date = date;
        self.opponent = opponent;
        self.score = score;
        self.location = location;
        
    }
    
    return self;
}

@end
