//
//  Player.m
//  HighSchoolHeroes
//
//  Created by Randy Collier on 1/19/14.
//  Copyright (c) 2014 Randy Collier. All rights reserved.
//

#import "Player.h"

@implementation Player

- (instancetype)initWithNumber:(NSString *)number
                  WithLastName:(NSString *)lastName
                 WithFirstName:(NSString *)firstName
                    WithHeight:(NSString *)height
                    WithWeight:(NSString *)weight
                      WithYear:(NSString *)year
                  WithPosition:(NSString *)position
{
    self = [super init];
    if (self)
    {
        self.number = number;
        self.lastName = lastName;
        self.firstName = firstName;
        self.height = height;
        self.weight = weight;
        self.year = year;
        self.position = position;
    }
    
    return self;
}

@end
