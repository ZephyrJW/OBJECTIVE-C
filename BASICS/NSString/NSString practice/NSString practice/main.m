//
//  main.m
//  NSString practice
//
//  Created by mac on 16/4/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

// NSString from range : -->

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // 1.
        NSString *string1 = [NSString stringWithFormat:@"%d",123];
        NSLog(@"%@", string1);
        NSString *string2 = [NSString stringWithFormat:@"%f",1.23];
        NSLog(@"%@", string2);
        // 2.
        
        // 3.
        NSString *str1 = @"My name is";
        NSString *str2 = @"Lilei";
        NSString *str3 = @"I am";
        int age = 20;
        NSMutableString *str4 = [[NSMutableString alloc]initWithString:str1];
        [str4 appendString:[NSString stringWithFormat:@" %@, %@ %d",str2, str3, age]];
        NSLog(@"%@", str4);
        // 4.
        NSLog(@"%ld", (long)[str1 compare:str2 options: NSCaseInsensitiveSearch]);
        NSLog(@"%ld", [[str1 lowercaseString]compare:[str2 lowercaseString]]) ;
        // 5.
        NSString *str5 = @"Welcome to Here.";
        NSRange range = [str5 rangeOfString:@"Here"];
        NSLog(@"%ld %ld", range.location, range.length);
        // 6.
        NSString *str6 = @"Welcome to Beijing.";
        NSLog(@"%@", [str6 substringWithRange:NSMakeRange(3, 4)]);
        // 7. 取was 到 radio 之间的字符串
        NSString *str7 = @"when i was young, i'd listen to the radio, waiting for my favorite songs.";
        NSRange r1 = [str7 rangeOfString:@"was"];
        NSRange r2 = [str7 rangeOfString:@"radio"];
        NSRange nr = NSMakeRange(r1.location, r2.location-r1.location+r2.length);
        NSLog(@"%@", NSStringFromRange(nr));
        NSLog(@"%@", [str7 substringWithRange:NSMakeRange(r1.location, r2.location-r1.location+r2.length)]);
        
        
        NSLog(@"%@", [str7 substringWithRange:NSMakeRange(7, 34)]);
       // NSString *temp1 = str7 substringToIndex:
        
        // 8.
        NSMutableString *str8 = [[NSMutableString alloc]initWithString:@"I love ios"];
        [str8 deleteCharactersInRange:NSMakeRange(2, 4)];
        NSLog(@"%@", str8);
        // 9.
        NSMutableString *str9 = [[NSMutableString alloc]initWithString:@"Hello World"];
        [str9 insertString:@"holly " atIndex:6];
        NSLog(@"%@", str9);
        // 10.
        NSMutableString *str10 = [[NSMutableString alloc]initWithString:@"when i was young, i loved a girl from neighbor class"];
        [str10 replaceCharactersInRange:NSMakeRange(0, 15) withString:@"teacher"];
        [str10 replaceCharactersInRange:NSMakeRange(10, 30) withString:@"rather teaching the students"];
        [str10 setString:@"teacher, i rather teaching students"];
        NSLog(@"%@", str10);
    }
    return 0;
}
