//
//  LXDString.m
//  NSString Implementation
//
//  Created by mac on 16/4/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LXDString.h"

@implementation LXDString

- (instancetype)initWithCString:(const char *)string {
    if (self = [super init]) {
        strcpy(_str, string);
    }
    return self;
}

+ (instancetype)stringWithCString:(const char *)string {
    return [[LXDString alloc]initWithCString:string];
}

- (NSInteger)length {
    return strlen(_str);
}

- (char)characterAtIndex:(NSUInteger)index {
    return _str[index];
}

//- (LXDString *)uppercaseString {
//    
//}


@end
