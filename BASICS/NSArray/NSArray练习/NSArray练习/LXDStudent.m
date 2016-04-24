//
//  LXDStudent.m
//  NSArray练习
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LXDStudent.h"

@implementation LXDStudent

-(instancetype)initWithName:(NSString *)name Age:(NSInteger)age Num:(NSInteger)num Score:(float)score {
    if (self = [super init]) {
        _name = name;
        _age = age;
        _num = num;
        _score = score;
    }
    return self;
}

+(instancetype)studentWithName:(NSString *)name Age:(NSInteger)age Num:(NSInteger)num Score:(float)score {
    return [[LXDStudent alloc]initWithName:name Age:age Num:num Score:score];
}

-(NSString *)name {
    return _name;
}

-(NSInteger)age {
    return _age;
}

-(NSInteger)num {
    return _num;
}

-(float)score {
    return _score;
}

-(BOOL)numSort:(LXDStudent *)student{
    return _num > [student num];
}

-(BOOL)scoreSort:(LXDStudent *)student {
    return _score < [student score];
}

-(BOOL)ageSort:(LXDStudent *)student {
    return _age > [student age];
}

- (BOOL)nameSort:(LXDStudent *)student {
    return [_name compare: [student name]] == NSOrderedAscending;
}



-(NSString *)description {
    return [NSString stringWithFormat:@"name:%@, age:%ld, number:%ld, score:%.2f", _name, _age, _num, _score];
}






@end
