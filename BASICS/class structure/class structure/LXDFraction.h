//
//  LXDFraction.h
//  class structure
//
//  Created by mac on 16/4/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXDFraction : NSObject {
    NSInteger _numerator;
    NSInteger _denominator;
}

- (void)setNumerator : (NSInteger)numerator;
- (NSInteger)numerator;

- (void)setDenominator : (NSInteger)denominator;
- (NSInteger)denominator;



- (void)setNumerator : (NSInteger)numerator Denominator : (NSInteger)denominator;
+ (instancetype)fractionWithNumerator:(NSInteger)numerator Denominator:(NSInteger)denominator;

- (void)show;
//- (void)reductionOfFraction;
- (LXDFraction *)addFraction : (LXDFraction *)fraction;
+ (LXDFraction *)addfraction : (LXDFraction *)fraction1 another:(LXDFraction *)fraction2;

@end
