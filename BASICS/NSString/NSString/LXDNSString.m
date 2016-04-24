//
//  LXDNSString.m
//  NSString
//
//  Created by mac on 16/4/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LXDNSString.h"

@implementation LXDNSString

+ (void)creatNSString {
    // 1.
    NSString *string1 = @"Hello World";
    NSLog(@"string1 : %@", string1);
    // 2.
    //NSString *s2 = [NSString stringWithString:@"abcd"]; 这样报警，警告如下： 你不如直接nsstring *s2 = @"abcd";
    NSString *string2 = [[NSString alloc]initWithString:string1];
    NSLog(@"string2 : %@", string2);
    // 对应的加方法
    NSString *string3 = [NSString stringWithString:string1];
    NSLog(@"string3 : %@", string3);
    /* 加方法的实现:
     +(instancetype)stringWithString : (NSString)*string{
        return [[LXDNSString alloc] initWithString:string]
     }
     */
    // 3. 用格式化字符串 @"blabla"
    NSString *string4 = [[NSString alloc]initWithFormat:@"%c %.2f %@ %d %s", 'A', 9.8, @"HELLO", 1234, "world"];
    NSLog(@"string4 : %@", string4);
    // 4.
    NSString *string5 = [NSString stringWithUTF8String:"Hello World!"];
    NSLog(@"string5 : %@", string5);
    // 5. c字符串以及后面一个 枚举
    NSString *string6 = [NSString stringWithCString:"Good Noon" encoding:NSUTF8StringEncoding];
    NSLog(@"string6 : %@", string6);
    // 6. 根据文件来获取字符串
    NSString *string7 = [[NSString alloc]initWithContentsOfFile:@"/Users/mac/1.c" encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@", string7);
}

+ (void)stringSimpleMethods {
    // oc的字符串用的是unichar(typedef unsigned short unichar)
    NSString *string = @"你好世界, Hello world!";
    NSLog(@"%lu", [string length]); // 17
    
    //选取某个元素(unichar元素), unichar用%C来打印 大写的C
    NSLog(@"%C", [string characterAtIndex:2]);
    NSLog(@"%C", [string characterAtIndex:12]);
    
    //将小写字符转换为大写字符,vice versa
    NSLog(@"%@", [@"hello 中国!" uppercaseString]);
    NSLog(@"%@", [@"HELLO 中国!" lowercaseString]);
    
    //将一组单词，转换成只有首字母大写的新的字符串对象 : capitalizedString
    NSLog(@"%@", [@"NO MATTER what wE breath, we STILL are MADE of GREED" capitalizedString]);
    
    //判断一个字符串是否以xxx字符串开头
    if ([@"http://www.douban.com" hasPrefix:@"http"]) {
        NSLog(@"this is a website");
    }
    //判断一个字符串是否以xxx字符串结尾
    if ([@"scent of a woman.mkv" hasSuffix:@"mkv"]) {
        NSLog(@"this is a movie");
    }
    
    //截取子串 substringfrom substringto substringwithrange
    NSString *testSub = @"kuo na duo ku dai mo";
    
    NSLog(@"%@", [testSub substringToIndex:5]); //不包含index的元素字符
    NSLog(@"%@", [testSub substringFromIndex:5]); //包含index的元素字符
    NSLog(@"%@", [testSub substringWithRange:NSMakeRange(5, 10)]); //location:起点，len:长度
    
    //数字转换相关
    NSLog(@"%d", [@"12.3ab" intValue]);
    NSLog(@"%ld", [@"123abc" integerValue]);
    NSLog(@"%f", [@"12.3131241abc" floatValue]);
    NSLog(@"%f", [@"12.3131241abc" doubleValue]);
    NSLog(@"%lld", [@"1234567ab" longLongValue]);
    NSLog(@"%d %d %d %d", [@"YES" boolValue], [@"NO" boolValue], [@"123" boolValue], [@"0" boolValue]);
    
    //字符串比较
    if ([@"hello" compare:@"hello"] == NSOrderedSame) {
        NSLog(@"相等啊");
    }
    
    if ([@"aaa" isEqualToString:@"aaa"]) {
        NSLog(@"equal");
    }
    
}

//NSMutableString
+ (void)creatNSMutableString {
    NSMutableString *string1 = [[NSMutableString alloc]init];
    [string1 appendString:@"qwer"];
    
    NSMutableString *string2 = [[NSMutableString alloc]initWithString:@"what?"];
    NSLog(@"string2: %@", string2);
    
    
    NSMutableString *string3 = [NSMutableString stringWithCapacity:10];
    [string3 appendString:@"abcdef"];
    [string3 insertString:@"xxx" atIndex:4];
    NSLog(@"string3 : %@", string3);
    
    //CFTypeId
    NSMutableString *string5 = [[NSMutableString alloc]initWithCapacity:10];
    //虽然设定了capacity了 但是长度可以超出这个值
    NSLog(@"string5 : %ld", [string5 length]);
    [string5 appendString:@"abc"];
    NSLog(@"string5_new : %ld", [string5 length]);
}

@end
