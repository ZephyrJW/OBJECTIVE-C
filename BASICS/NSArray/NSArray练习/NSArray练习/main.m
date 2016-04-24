//
//  main.m
//  NSArray练习
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXDDog.h"
#import "LXDStudent.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // 1.
        NSArray *array1 = [[NSArray alloc]initWithObjects:@"one", @"two", @"three", @"four", nil];
        for (NSString *str in array1) {
            NSLog(@"%@", str);
        }
        NSLog(@"--------------1 over----------------");
        NSEnumerator *enumerator = [array1 objectEnumerator];
        NSString *tmp = nil;
        while (tmp = [enumerator nextObject]) {
            NSLog(@"%@", tmp);
        }
        NSLog(@"--------------1 over----------------");
        // 2.
        LXDDog *xiaobai = [LXDDog dogWithAge:3 Name:@"xiaobai"];
        LXDDog *bolt = [LXDDog dogWithAge:4 Name:@"bolt"];
        LXDDog *hachi = [LXDDog dogWithAge:18 Name:@"hachi"];
        LXDDog *wangcai = [LXDDog dogWithAge:13 Name:@"wangcai"];
        LXDDog *snoopy = [LXDDog dogWithAge:8 Name:@"snoopy"];
        
        NSMutableArray *dogs = [[NSMutableArray alloc]initWithObjects:xiaobai, bolt, hachi, wangcai, snoopy, nil];
        
        for (LXDDog *dog in dogs) {
            [dog bark];
        }
        NSLog(@"--------------2 over----------------");
        // 3. isMemberOfClass:判断一个对象是否是一个类的实例 & isKindOfClass:对象是不是该类或者该类的descendant的实例
            //NSLog(@"%@ ----  %@", [bolt class], [LXDDog class]); 结果一致
        NSArray *array3 = @[@"abcdef", @"ghijkl", bolt, snoopy, hachi];
        enumerator = [array3 objectEnumerator];
        for (id obj in array3) {
            if ([obj isMemberOfClass:[LXDDog class]]) {
                [obj bark];
            } else {
                NSLog(@"This is a string man!");
            }
        }
        NSLog(@"--------------3 over----------------");
        // 4.
        LXDStudent *a = [LXDStudent studentWithName:@"aad" Age:22 Num:10028 Score:87.2];
        LXDStudent *b = [LXDStudent studentWithName:@"aec" Age:20 Num:10018 Score:83.5];
        LXDStudent *c = [LXDStudent studentWithName:@"nec" Age:25 Num:10023 Score:90];
        
        NSMutableArray *students = [NSMutableArray arrayWithObjects: a, b, c, nil];
        NSLog(@"%@", students);
        [students sortUsingSelector:@selector(numSort:)];
        NSLog(@"%@", students);
        [students sortUsingSelector:@selector(scoreSort:)];
        NSLog(@"%@", students);
        [students sortUsingSelector:@selector(ageSort:)];
        NSLog(@"%@", students);
        // 字符串比较要用compare方法
        [students sortUsingSelector:@selector(nameSort:)];
        NSLog(@"%@", students);
        NSLog(@"--------------4 over----------------");
        
        //5.
        NSString *string1 = @"I am a good girl";
        NSString *string2 = @"You are a bad boy";
        NSArray *arrayGirl = [string1 componentsSeparatedByString:@" "];
        NSArray *arrayBoy = [string2 componentsSeparatedByString:@" "];
        NSMutableArray *arraySum = [[NSMutableArray alloc]init];
        for (NSInteger i = 0; i<5; i++) {
            [arraySum addObject:arrayGirl[i]];
            [arraySum addObject:arrayBoy[i]];
        }
        NSString *res = [arraySum componentsJoinedByString:@" "];
        NSLog(@"%@", res);
        
    }
    return 0;
}
