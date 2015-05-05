//
//  OrderTableUIView.m
//  OrderSignature
//
//  Created by freedom on 15/5/5.
//  Copyright (c) 2015年 freedom_luo. All rights reserved.
//

//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#import "OrderTableUIView.h"

@implementation OrderTableUIView

- (void)drawRect:(CGRect)rect {
    
    UIColor *color=[UIColor blackColor];
    [color set];
    
    UIBezierPath *apath=[UIBezierPath bezierPath];
    apath.lineWidth=1.5;
    apath.lineCapStyle=kCGLineCapRound;
    apath.lineJoinStyle=kCGLineCapRound;
    
    [apath moveToPoint:CGPointMake(10, 10)];
    [apath addLineToPoint:CGPointMake(ScreenWidth-10-200, 10)];
    [apath addLineToPoint:CGPointMake(ScreenWidth-10-200, 374)];
    [apath addLineToPoint:CGPointMake(10, 374)];
    [apath addLineToPoint:CGPointMake(10, 10)];
    
    [apath stroke];
}

@end
