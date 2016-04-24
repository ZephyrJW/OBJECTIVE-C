//
//  DictionaryItem.m
//  dictionary
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DictionaryItem.h"

@implementation DictionaryItem

- (instancetype)initWithWord:(NSString *)word Trans:(NSString *)trans {
    if (self = [super init]) {
        _word = word;
        _trans = trans;
    }
    return self;
}

+ (instancetype)wordWithWord:(NSString *)word Trans:(NSString *)trans {
    return [[DictionaryItem alloc]initWithWord:word Trans:trans];
}

-(NSString *)word {
    return _word;
}

- (NSString *)trans {
    return _trans;
}

-(void)setWord:(NSString *)word {
    _word = word;
}

-(void)setTrans:(NSString *)trans {
    _trans = trans;
}

@end
