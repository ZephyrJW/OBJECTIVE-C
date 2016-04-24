//
//  main.m
//  NSDictionary
//
//  Created by mac on 16/4/22.
//  Copyright © 2016年 mac. All rights reserved.
//
// 任意类型的对象 key-value : hashmap

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // 输出格式: key = value 每个键值对之间用;来分割，而数组用的是,
        // 快速创建一个字典,不需要写nil作为结尾标记
        NSDictionary *dict1 = @{@"one":@"1", @"two":@"2", @"three":@"3"};
        NSLog(@"dict1 : %@", dict1);
        // 用一个字典来初始化
        NSDictionary *dict2 = [[NSDictionary alloc]initWithDictionary:dict1];
        NSLog(@"dict2 : %@", dict2);
        // 用键值来初始化一个字典 obj , key , obj , key 注意obj和key的顺序哦
        NSDictionary *dict3 = [[NSDictionary alloc]initWithObjectsAndKeys:@[@"this", @"is",@"array"],@"one",  @"2", @"two", @"3", @"three", nil];
        NSLog(@"dict3 : %@",dict3);
        // 用key和value的数组来初始化一个字典
        NSDictionary *dict4 = [NSDictionary dictionaryWithObjects:@[@[@"this",@"is",@"array"], @"2", @"2",@"3"] forKeys:@[@"one", @"two", @"three", @"four"]];
        NSLog(@"dict4 : %@", dict4);
        
        // 字典的常用方法
        // 字典键值对的个数
        NSLog(@"%ld", [dict4 count]);
        // 通过key 找到对应的value, 没有则返回null
        NSLog(@"%@", [dict4 valueForKey:@"one"]);
        NSLog(@"%@", [dict4 valueForKey:@"xxx"]);
        // 类似数组的写法是中括号里面写key值
        NSLog(@"one>>>%@  xxx>>>%@", dict4[@"one"], dict4[@"xxx"]);
        
        // 返回字典中所有key的数组
        NSLog(@"%@", [dict4 allKeys]);
        // 返回字典中所有value的数组
        NSLog(@"%@", [dict4 allValues]);
        // 返回字典中所有value为@"2"的key的数组
        NSLog(@"%@", [dict4 allKeysForObject:@"2"]);
        
        // 字典的枚举器(key的枚举器,和value<object>的枚举器)
        NSEnumerator *enumerator = [dict4 keyEnumerator];
        NSString *str = nil;
        while (str = [enumerator nextObject]) {
            NSLog(@"%@  %@", str, dict4[str]);
        }
        
        enumerator = [dict4 objectEnumerator];
        str = nil;
        while (str = [enumerator nextObject]) {
            NSLog(@"---%@", str);
        }
        // 字典的快速枚举，是对key的枚举
        for (NSString *string in dict4) {
            NSLog(@"string枚举对象--%@ : %@", string, dict4[string]);
        }
        
        
/*------------------------------NSMutableDictionary-------------------------------------*/
        // 单个value和key的创建,没有减方法
        NSMutableDictionary *dict5 = [NSMutableDictionary dictionaryWithObject:@"4" forKey:@"three"];
        NSLog(@"dict5 : %@", dict5);
        // 相当于[[ alloc]init]的＋方法
        NSMutableDictionary *dict6 = [NSMutableDictionary dictionary];
        NSMutableDictionary *dict7 = [NSMutableDictionary dictionaryWithCapacity:10];
        // 想string和array一样，虽然你初始化的时候给了capacity，但它的长度还是0
        NSLog(@"dict6,7 count : %lu %lu", [dict6 count], [dict7 count]);
        // 如果没有key就添加，有某个key的话就用新的value来替换这个key的内容
        [dict5 addEntriesFromDictionary:dict4];
        NSLog(@"dict5 : %@", dict5);
        
        
        // NSMutableDictionary 常用方法(字典是无序的，没有增加、插入、交换...)
        // 用set方法，如果没有该key，则增加key-value键值对
        // 如果有该key， 则更新该key对应的value
        [dict7 setObject:@"1" forKey:@"one"];
        NSLog(@"dict7 : %@", dict7);
        [dict7 setObject:@"2" forKey:@"two"];
        NSLog(@"dict7 : %@", dict7);
        [dict7 setObject:@"3" forKey:@"two"];
        NSLog(@"dict7 : %@", dict7);
        [dict7 setObject:@"3" forKey:@"three"];
        NSLog(@"dict7 : %@", dict7);
        
        // 移除方法:
        // 根据key移除
        [dict7 removeObjectForKey:@"one"];
        NSLog(@"dict7 : %@", dict7);
        [dict7 removeObjectsForKeys:@[@"two",@"three"]];
        NSLog(@"dict7 : %@", dict7);
        // 重设dictionary
        [dict7 setDictionary:dict4];
        NSLog(@"dict7 : %@", dict7);
        // 移除所有得objects
        [dict7 removeAllObjects];
        NSLog(@"dict7 : %@", dict7);
        
        NSString *str1 = @"sdfesdfesdf";
        [str1 writeToFile:@"/Users/mac/Desktop/a.txt" atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    return 0;
}
