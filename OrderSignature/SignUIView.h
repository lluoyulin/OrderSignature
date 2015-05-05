//
//  SignUIView.h
//  OrderSignature
//
//  Created by freedom on 15/4/20.
//  Copyright (c) 2015年 freedom_luo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUIView : UIView

@property(nonatomic,strong) UIImage *pickedImage;
@property(nonatomic,retain) NSMutableArray *arrayStrokes;
@property(nonatomic,retain) UIColor *currentColor;
@property(nonatomic,assign) CGFloat currentSize;

-(void)drawTable;

@end
