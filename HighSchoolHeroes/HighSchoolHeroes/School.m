//
//  Team.m
//  HighSchoolHeroes
//
//  Created by Randy Collier on 1/29/14.
//  Copyright (c) 2014 Randy Collier. All rights reserved.
//

#import "School.h"

@implementation School

- (instancetype)initWithName:(NSString *)name
                    WithCity:(NSString *)city
                   WithState:(NSString *)state
                     WithZIP:(NSString *)zip
                    Withsize:(NSString *)size
{
    self = [super init];
    if (self)
    {
        self.name = name;
        self.city = city;
        self.state = state;
        self.zip = zip;
        self.size = size;
    }
    
    return self;
}

@end
