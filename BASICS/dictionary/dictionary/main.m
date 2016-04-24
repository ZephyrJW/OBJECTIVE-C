//
//  main.m
//  dictionary
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DictionaryParser.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        DictionaryParser *parser = [[DictionaryParser alloc]initWithFile:@"/Users/mac/Desktop/课件/day19/dict_eng.txt"];
        
        NSLog(@"\n%@",[parser transForWord:@"make"]);
        
        NSLog(@"%@", [parser wordsForTrans:@"中国"]);
        
        [parser changeTrans:@"hhh" toWord:@"make"];
        
        NSLog(@"\n%@",[parser transForWord:@"make"]);
        
        
    }
    return 0;
}
