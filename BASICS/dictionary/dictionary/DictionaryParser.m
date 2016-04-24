//
//  DictionaryParser.m
//  dictionary
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DictionaryParser.h"
#import "DictionaryItem.h"

@implementation DictionaryParser

- (instancetype)initWithFile:(NSString *)file {
    if (self = [super init]) {
        // 放在init中初始化数组属性，保证它在第一时间初始化且只初始化一次
        _items = [[NSMutableArray alloc]init];
        [self analyzeFile:file];
    }
    return self;
}

- (void)analyzeFile:(NSString *)file {
    NSString *info = [NSString stringWithContentsOfFile:file encoding: NSUTF8StringEncoding error:nil];
    
    NSArray *array = [info componentsSeparatedByString:@"\n"];
    
    for (int i = 0; i < [array count]; i += 2) {
        NSString *word = array[i];
        NSString *trans = array[i+1];
        
        word = [[word componentsSeparatedByString:@"#"] lastObject];
        trans = [trans substringFromIndex:[@"Trans:" length]];
        DictionaryItem *item = [[DictionaryItem alloc]initWithWord:word Trans:trans];
        // 若不先初始化这个成员变量(数组),那么这里不会有结果，因为是nil指针。 没有init!
        [_items addObject:item];
    }
}

- (NSString *)transForWord:(NSString *)word {
    // NSMutableString *res = [[NSMutableString alloc]init]; 用NSString就可以了，说白了也就是指针
    NSString *ans = nil;
    // NSEnumerator *enumerator = [_items objectEnumerator];
    for (DictionaryItem *item in _items) {
        if ([item.word isEqualToString:word]) {
            // [res setString:item.trans];
            ans = item.trans;
            break;
        }
    }    
    return ans;
}

- (NSArray *)wordsForTrans:(NSString *)trans {
    NSMutableArray *res = [[NSMutableArray alloc]init];
    for (DictionaryItem *item in _items) {
        NSRange range = [item.trans rangeOfString:trans];
        if (range.location != NSNotFound) {
            [res addObject:item.word];
        }
    }
    return res;
}

-(void)changeTrans:(NSString *)newTrans toWord:(NSString *)word {
    for (DictionaryItem *item in _items) {
        if ([word isEqualToString:item.word]) {
            [item setTrans:newTrans];
            break;
        }
    }
}

- (void)addWord:(NSString *)word trans:(NSString *)trans {
    DictionaryItem *newItem = [[DictionaryItem alloc]initWithWord:word Trans:trans];
    [_items addObject:newItem];
}



@end
