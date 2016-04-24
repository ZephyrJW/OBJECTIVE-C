//
//  DictionaryParser.h
//  dictionary
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DictionaryParser : NSObject {
    NSMutableArray *_items;
}

- (instancetype)initWithFile:(NSString *)file;

- (NSString *)transForWord:(NSString *)word;

- (NSArray *)wordsForTrans:(NSString *)trans;

- (void)changeTrans:(NSString *)newTrans toWord:(NSString *)word;

- (void)addWord:(NSString *)word trans:(NSString *)trans;

- (void)saveToFile:(NSString *)file;

@end
