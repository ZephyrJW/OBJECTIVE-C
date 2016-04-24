//
//  LXDDog.h
//  NSArray练习
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXDDog : NSObject{
    NSInteger _age;
    NSString *_name;
}

-(instancetype)initWithAge:(NSInteger)age Name:(NSString *)name;
+(instancetype)dogWithAge:(NSInteger)age Name:(NSString *)name;

-(NSInteger)age;
-(NSString *)name;

-(void)bark;

@end
