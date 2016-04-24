//
//  LXDURLParser.h
//  LXDURLParser
//
//  Created by mac on 16/4/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXDURLParser : NSObject {
    NSString *_protocol;
    NSString *_user;
    NSString *_password;
    NSString *_host;
    NSString *_port;
    NSString *_path;
    NSString *_parameters;
}

- (instancetype)initWithURL : (NSString *)url;


- (NSString *)protocol;
- (NSString *)user;
- (NSString *)password;
- (NSString *)host;
- (NSString *)port;
- (NSString *)path;
- (NSString *)parameters;


@end
