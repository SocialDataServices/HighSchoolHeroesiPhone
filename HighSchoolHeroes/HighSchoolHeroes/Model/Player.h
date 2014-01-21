//
//  Player.h
//  HighSchoolHeroes
//
//  Created by Randy Collier on 1/19/14.
//  Copyright (c) 2014 Randy Collier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (nonatomic, strong)NSString *number;
@property (nonatomic, strong)NSString *lastName;
@property (nonatomic, strong)NSString *firstName;
@property (nonatomic, strong)NSString *height;
@property (nonatomic, strong)NSString *weight;
@property (nonatomic, strong)NSString *year;
@property (nonatomic, strong)NSString *position;

- (instancetype)initWithNumber:(NSString *)number
                  WithLastName:(NSString *)lastName
                 WithFirstName:(NSString *)firstName
                    WithHeight:(NSString *)height
                    WithWeight:(NSString *)weight
                      WithYear:(NSString *)year
                  WithPosition:(NSString *)position;

@end
