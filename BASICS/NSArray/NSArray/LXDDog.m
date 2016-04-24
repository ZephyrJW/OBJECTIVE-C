//
//  LXDDog.m
//  NSArray
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LXDDog.h"

@implementation LXDDog

- (instancetype)initWithAge:(NSInteger)age name:(NSString *)name {
        if (self = [super init]) {
            _age = age;
            _name = name;
        }
        return self;
}

- (BOOL)ageCompare:(LXDDog *)dog {
    return [self age] < [dog age];
}

- (BOOL)nameCompare:(LXDDog *)dog {
    return [_name compare:dog.name] == NSOrderedAscending;
}

- (NSInteger)age {
    return _age;
}

- (NSString *)name {
    return _name;
}

- (void)showSelf {
    NSLog(@"name:%@, age:%ld", _name, _age);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %ld", _name, _age ];
}


@end
