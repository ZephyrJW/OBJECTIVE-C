//
//  LXDFraction.m
//  class structure
//
//  Created by mac on 16/4/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LXDFraction.h"

@implementation LXDFraction

- (void)setNumerator:(NSInteger)numerator {
    _numerator = numerator;
}

- (NSInteger)numerator {
    return _numerator;
}

- (void)setDenominator:(NSInteger)denominator {
    if (denominator != 0) {
        _denominator = denominator;
    }
}

- (NSInteger)denominator {
    return _denominator;
}

- (void)setNumerator:(NSInteger)numerator Denominator:(NSInteger)denominator {
    [self setNumerator:numerator];
    //_denominator = denominator;
    [self setDenominator:denominator];
}

- (instancetype)initWithNumerator:(NSInteger)numerator Dnominator:(NSInteger)denominator {
    if (self = [super init]) {
        _numerator = numerator;
        _denominator = denominator;
    }
    return self;
}

+ (instancetype)fractionWithNumerator:(NSInteger)numerator Denominator:(NSInteger)denominator {
    return [[LXDFraction alloc] initWithNumerator:numerator Dnominator:denominator];
}

- (void)show {
    NSLog(@"%ld/%ld", _numerator,_denominator);
}

// 约分方法在.h中不声明，但在这里实现，这样就只能在.m文件中使用，称为类内部的私有方法，让使用者能够更清楚的使用，防止一个类中方法太多，使用者需要在其中挑选合适的
- (void)reductionOfFraction {
    NSInteger i = 2;
    // 这里应该用<= 还是单纯的 < 呢
    while (i < _numerator && i < _denominator) {
        while (_numerator%i == 0 && _denominator%i == 0) {
            _numerator /= i;
            _denominator /= i;
        }
        i++;
    }
    /* 怎么用for循环来解决
     for (; i<_numerator && i<_denominator; ) {
         if (_numerator %i == 0 && _denominator %i ==0) {
             _numerator/=2;
             _denominator/=2;
         }else i++:
     }
     */
}
// 注意各种方法间的调用是很很很很很重要的!!!这是OO编程的核心
// 另外，这样很明显的可以减少许多代码量
- (LXDFraction *)addFraction:(LXDFraction *)fraction {
     return [LXDFraction addfraction:self another:fraction];
}

+ (LXDFraction *)addfraction:(LXDFraction *)fraction1 another:(LXDFraction *)fraction2 {
    LXDFraction *res = [[LXDFraction alloc]init];
    //[res numerator] 就是 res->_numerator? 对的 numerator return的就是_numerator,尽量避免使用->这个符号，因为这样影响封装性，加点即res.numerator也是调用这个方法，不过还是用oc写法吧
    res->_denominator = fraction1->_denominator * fraction2->_denominator;
    res->_numerator = fraction1->_numerator * fraction2->_denominator + fraction2->_numerator * fraction1->_denominator;
    [res reductionOfFraction];
    
    return res;
}










@end
