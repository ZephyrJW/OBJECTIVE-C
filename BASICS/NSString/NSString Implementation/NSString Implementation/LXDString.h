//
//  LXDString.h
//  NSString Implementation
//
//  Created by mac on 16/4/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXDString : NSObject {
    char _str[1024];
}

- (instancetype)initWithCString:(const char *)string;
+ (instancetype)stringWithCString:(const char *)string;

- (NSInteger)length;
+ (NSInteger)length:(LXDString *)string;
- (char)characterAtIndex:(NSUInteger)index;

- (LXDString *)uppercaseString;
- (LXDString *)lowercaseString;
- (LXDString *)capitalizedString;
- (BOOL)hasPrefix:(LXDString *)string;
- (BOOL)hasSuffix:(LXDString *)string;

- (LXDString *)substringFromIndex:(NSUInteger)from;
- (LXDString *)substringToIndex:(NSUInteger)to;
- (LXDString *)substringWithRange:(NSRange)range;

- (int)intValue;
- (BOOL)isEqualToString:(LXDString *)aString;
@end
