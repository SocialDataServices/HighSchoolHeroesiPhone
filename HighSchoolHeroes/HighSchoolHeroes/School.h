//
//  Team.h
//  HighSchoolHeroes
//
//  Created by Randy Collier on 1/29/14.
//  Copyright (c) 2014 Randy Collier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface School : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *zip;
@property (nonatomic, strong) NSString *size;

- (instancetype)initWithName:(NSString *)name
                    WithCity:(NSString *)city
                   WithState:(NSString *)state
                     WithZIP:(NSString *)zip
                    Withsize:(NSString *)size;

@end
