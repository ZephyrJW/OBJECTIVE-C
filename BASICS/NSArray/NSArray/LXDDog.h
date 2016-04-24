//
//  LXDDog.h
//  NSArray
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXDDog : NSObject {
    NSInteger _age;
    NSString *_name;
}

- (instancetype)initWithAge : (NSInteger)age name : (NSString *)name; 

- (NSInteger)age;

- (NSString *)name ;

- (void)showSelf ;

- (BOOL)ageCompare : (LXDDog *)dog;
- (BOOL)nameCompare : (LXDDog *)dog;

@end
