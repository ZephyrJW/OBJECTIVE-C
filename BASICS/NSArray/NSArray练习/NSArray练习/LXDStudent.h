//
//  LXDStudent.h
//  NSArray练习
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXDStudent : NSObject {
    NSString *_name;
    NSInteger _age;
    NSInteger _num;
    //可以用  CGFloat 
    float _score;
}

- (instancetype)initWithName:(NSString *)name Age:(NSInteger)age Num:(NSInteger)num Score:(float)score;
+ (instancetype)studentWithName:(NSString *)name Age:(NSInteger)age Num:(NSInteger)num Score:(float)score;

- (NSString *)name;
- (NSInteger)age;
- (NSInteger)num;
- (float)score;

- (BOOL)nameSort : (LXDStudent *)student;
- (BOOL)ageSort : (LXDStudent *)student;
- (BOOL)numSort : (LXDStudent *)student;
- (BOOL)scoreSort : (LXDStudent *)student;

- (NSString *)description;

@end
