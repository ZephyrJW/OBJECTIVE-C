//
//  LXDDog.m
//  NSArray练习
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LXDDog.h"

@implementation LXDDog 

- (instancetype)initWithAge:(NSInteger)age Name:(NSString *)name {
    if (self = [super init]) {
        _age = age;
        _name = name;
    }
    return self;
}

+(instancetype)dogWithAge:(NSInteger)age Name:(NSString *)name {
    return [[LXDDog alloc]initWithAge:age Name:name];
}

-(NSInteger)age {
    return _age;
}

-(NSString *)name {
    return _name;
}

-(void)bark {
    NSLog(@"%@ dog is barking :wang wang wang", _name);
}

@end
