//
//  DictionaryItem.h
//  dictionary
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DictionaryItem : NSObject {
    NSString *_word;
    NSString *_trans;
}

- (instancetype)initWithWord:(NSString *)word Trans:(NSString *)trans ;
+ (instancetype)wordWithWord:(NSString *)word Trans:(NSString *)trans ;

- (NSString *)word;
- (NSString *)trans;

- (void)setWord:(NSString *)word;
- (void)setTrans:(NSString *)trans;


@end
