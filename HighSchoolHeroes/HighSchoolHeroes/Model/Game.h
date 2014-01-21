//
//  Game.h
//  HighSchoolHeroes
//
//  Created by Randy Collier on 1/17/14.
//  Copyright (c) 2014 Randy Collier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject

@property (nonatomic, strong)NSString *date;
@property (nonatomic, strong)NSString *opponent;
@property (nonatomic, strong)NSString *score;
@property (nonatomic, strong)NSString *location;

- (instancetype)initOnDate:(NSString *)date
           AgainstOpponent:(NSString *)opponent
                 WithScore:(NSString *)score
                AtLocation:(NSString *)location;

@end
