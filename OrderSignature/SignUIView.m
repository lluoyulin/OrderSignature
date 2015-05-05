//
//  SignUIView.m
//  OrderSignature
//
//  Created by freedom on 15/4/20.
//  Copyright (c) 2015年 freedom_luo. All rights reserved.
//

//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#import "SignUIView.h"

@implementation SignUIView

- (void) drawRect: (CGRect) rect
{
    [self drawTable];
    
    //绘制图片
    int width = self.pickedImage.size.width;
    int height = self.pickedImage.size.height;
    CGRect rectForImage = CGRectMake(0,0, width, height);
    [self.pickedImage drawInRect:rectForImage];
    
    if (self.arrayStrokes)
    {
        int arraynum = 0;
        // each iteration draw a stroke
        // line segments within a single stroke (path) has the same color and line width
        for (NSDictionary *dictStroke in self.arrayStrokes)
        {
            NSArray *arrayPointsInstroke = [dictStroke objectForKey:@"points"];
            UIColor *color = [dictStroke objectForKey:@"color"];
            float size = [[dictStroke objectForKey:@"size"] floatValue];
            [color set];		// Sets the color of subsequent stroke and fill operations to the color that the receiver represents.
            
            // draw the stroke, line by line, with rounded joints
            UIBezierPath* pathLines = [UIBezierPath bezierPath];
            CGPoint pointStart = CGPointFromString([arrayPointsInstroke objectAtIndex:0]);
            [pathLines moveToPoint:pointStart];
            for (int i = 0; i < (arrayPointsInstroke.count - 1); i++)
            {
                CGPoint pointNext = CGPointFromString([arrayPointsInstroke objectAtIndex:i+1]);
                [pathLines addLineToPoint:pointNext];
            }
            pathLines.lineWidth = size;
            pathLines.lineJoinStyle = kCGLineJoinRound; //拐角的处理
            pathLines.lineCapStyle = kCGLineCapRound; //最后点的处理
            [pathLines stroke];
            
            arraynum++;//统计笔画数量
        }
    }
}

// Start new dictionary for each touch, with points and color
- (void) touchesBegan:(NSSet *) touches withEvent:(UIEvent *) event
{
    NSMutableArray *arrayPointsInStroke = [NSMutableArray array]; //点数组，相当于一个笔画
    
    NSMutableDictionary *dictStroke = [NSMutableDictionary dictionary];
    
    [dictStroke setObject:arrayPointsInStroke forKey:@"points"];
    [dictStroke setObject:self.currentColor forKey:@"color"];
    [dictStroke setObject:[NSNumber numberWithFloat:self.currentSize] forKey:@"size"];
    
    CGPoint point = [[touches anyObject] locationInView:self];
    [arrayPointsInStroke addObject:NSStringFromCGPoint(point)];
    
    [self.arrayStrokes addObject:dictStroke];//添加的是一个字典：点数组，颜色，粗细
}

// Add each point to points array
- (void) touchesMoved:(NSSet *) touches withEvent:(UIEvent *) event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    
    CGPoint prevPoint = [[touches anyObject] previousLocationInView:self];
    
    NSMutableArray *arrayPointsInStroke = [[self.arrayStrokes lastObject] objectForKey:@"points"];
    
    [arrayPointsInStroke addObject:NSStringFromCGPoint(point)];
    
    
    CGRect rectToRedraw = CGRectMake(\
                                     ((prevPoint.x>point.x)?point.x:prevPoint.x)-self.currentSize,\
                                     ((prevPoint.y>point.y)?point.y:prevPoint.y)-self.currentSize,\
                                     fabs(point.x-prevPoint.x)+2*self.currentSize,\
                                     fabs(point.y-prevPoint.y)+2*self.currentSize\
                                     );
    //Marks the specified rectangle of the receiver as needing to be redrawn.
    //在指定的rect范围进行重绘
    [self setNeedsDisplayInRect:rectToRedraw];
    //	[self setNeedsDisplay];
}

-(void)drawTable
{
    UIColor *color=[UIColor blackColor];
    [color set];
    
    UIBezierPath *apath=[UIBezierPath bezierPath];
    apath.lineWidth=1.5;
    apath.lineCapStyle=kCGLineCapRound;
    apath.lineJoinStyle=kCGLineCapRound;
    
    [apath moveToPoint:CGPointMake(10, 74)];
    [apath addLineToPoint:CGPointMake(ScreenWidth-10, 74)];
    [apath addLineToPoint:CGPointMake(ScreenWidth-10, 374)];
    [apath addLineToPoint:CGPointMake(10, 374)];
    [apath addLineToPoint:CGPointMake(10, 74)];
    //    [apath closePath];
    
    [apath moveToPoint:CGPointMake(10, 104)];
    [apath addLineToPoint:CGPointMake(ScreenWidth-10, 104)];
    
    [apath moveToPoint:CGPointMake(100, 74)];
    [apath addLineToPoint:CGPointMake(100, 104)];
    
    [apath moveToPoint:CGPointMake(200, 74)];
    [apath addLineToPoint:CGPointMake(200, 104)];
    
    [apath moveToPoint:CGPointMake(300, 74)];
    [apath addLineToPoint:CGPointMake(300, 104)];
    
    [apath moveToPoint:CGPointMake(500, 74)];
    [apath addLineToPoint:CGPointMake(500, 104)];
    
    [apath stroke];
}

@end
