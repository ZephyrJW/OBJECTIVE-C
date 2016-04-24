//
//  LXDURLParser.m
//  LXDURLParser
//
//  Created by mac on 16/4/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LXDURLParser.h"

@implementation LXDURLParser

- (instancetype)initWithURL:(NSString *)url {
    if (self = [super init]) {
        [self analyzeURL : url];
    }
    return self;
}

- (void)analyzeURL : (NSString *)url {
    // 协议
    NSRange range = [url rangeOfString:@"://"];
    if (range.location != NSNotFound) {
        _protocol = [url substringToIndex:range.location];
        url = [url substringFromIndex:range.location+range.length];
    }else {
        _protocol = @"http";
    }
    // 用户名和密码
    range = [url rangeOfString:@"@"];
    if (range.location != NSNotFound) {
        NSRange tmp = [url rangeOfString:@":"];
        _user = [url substringToIndex:tmp.location];// 下面别＋1了，＋tmp.length吧
        //nsmakerange的两个参数分别是起始位置和 !长度!  !!
        _password = [url substringWithRange:NSMakeRange(tmp.location+tmp.length, range.location-tmp.location-tmp.length)];
        //url = [url substringFromIndex:tmp.location+tmp.length];
    } else {
        _user = nil;
        _password = nil;
    }
    url = [url substringFromIndex:range.location+range.length];
    // _host & _port 写的不好，太局限了，不光这里有:，后面也会有:的，这里找不到就找到很后面了
    
    range = [url rangeOfString:@":"];
    NSRange slash = [url rangeOfString:@"/"];
    // 有可能没有/ 了 比如  https://www.baidu.com
    
    if (range.location != NSNotFound && slash.location != NSNotFound) {
        _host = [url substringToIndex:range.location];
        _port = [url substringWithRange:NSMakeRange(range.location+range.length, slash.location)];
    } else if(range.location != NSNotFound && slash.location == NSNotFound){
        _host = [url substringToIndex:range.location];
        _port = [url substringFromIndex:range.location+range.length];
        return;
    }else if (range.location == NSNotFound && slash.location != NSNotFound){
        _host = [url substringToIndex:slash.location];
        _port = @"8000";
    }else if (slash.location == NSNotFound){
        _host = [url substringToIndex:slash.location];
        _port = @"8000";
        return;
    }
    
    
    
    
    // 需要加else嘛????????
    url = [url substringFromIndex:slash.location+slash.length];
    // path 和 parameters
    range = [url rangeOfString:@"?"];
    if (range.location != NSNotFound) {
        _path = [url substringToIndex:range.location];
        _parameters = [url substringFromIndex:range.location+range.length];
    }else {
        _path = url;
        _parameters = nil;
    }
    
}

- (void)setHostAndPortWithURL : (NSString *)url {
        NSRange range = [url rangeOfString:@":"];
        NSRange slash = [url rangeOfString:@"/"];
        
        if (range.location != NSNotFound) {
            _host = [url substringToIndex:range.location];
            _port = [url substringWithRange:NSMakeRange(range.location+range.length, slash.location)];
        } else {
            _host = [url substringToIndex:slash.location];
            _port = @"8000";

    }
}

- (NSString *)protocol {
    return _protocol;
}
- (NSString *)user {
    return _user;
}

- (NSString *)password {
    return _password;
}

- (NSString *)host {
    return _host;
}

- (NSString *)port {
    return _port;
}

- (NSString *)path {
    return _path;
}

- (NSString *)parameters {
    return _parameters;
}

@end
