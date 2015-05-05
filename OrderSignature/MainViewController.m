//
//  MainViewController.m
//  OrderSignature
//
//  Created by freedom on 15/4/20.
//  Copyright (c) 2015年 freedom_luo. All rights reserved.
//

#import "MainViewController.h"
#import "SignUIView.h"
#import "OrderTableUIView.h"
#import "ChangeTableUIView.h"

//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface MainViewController ()

@property(nonatomic,strong) SignUIView *sign;
@property(nonatomic,strong) OrderTableUIView *order;
@property(nonatomic,strong) ChangeTableUIView *change;


@property(nonatomic,strong) UILabel *label;
@property(nonatomic,strong) UISplitViewController *splitVC;
@property(nonatomic,strong) UIPopoverController *popoverController;
@property(nonatomic,strong) UIToolbar *toolbar;

@end

@implementation MainViewController

@synthesize popoverController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"退房单";
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveDraw:)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(clearDraw:)];
    
    //初始化表格视图
    self.order=[[OrderTableUIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth-200, ScreenHeight)];
    self.order.backgroundColor=[UIColor whiteColor];
    [self.view insertSubview:self.order atIndex:0];
    
    //初始化签名视图
    self.sign=[[SignUIView alloc] initWithFrame:self.order.frame];
    self.sign.backgroundColor=[UIColor clearColor];
    self.sign.currentSize=3.0;
    self.sign.currentColor=[UIColor blackColor];
    self.sign.arrayStrokes=[[NSMutableArray alloc] init];
    [self.view insertSubview:self.sign atIndex:3];
}

/**
 *  清除画布
 *
 *  @param btn 清除按钮
 */
-(void)clearDraw:(UIBarButtonItem *)btn
{
    if (self.sign.arrayStrokes.count>0) {
        [self.sign.arrayStrokes removeAllObjects];
        [self.sign setNeedsDisplay];
    }
}

/**
 *  保存画布到相册
 *
 *  @param btn 保存按钮
 */
-(void)saveDraw:(UIBarButtonItem *)btn
{
    if (self.sign.arrayStrokes.count>0) {
        UIGraphicsBeginImageContext(self.sign.bounds.size); //currentView 当前的 view
        [self.sign.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIImageWriteToSavedPhotosAlbum(viewImage,nil,nil,nil);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark RootTableVC代理
-(void)didSelectRowWithIndew:(NSInteger)rowIndex
{
    switch (rowIndex) {
        case 0:
            self.navigationItem.title=@"退房单";
            break;
        case 1:
            self.navigationItem.title=@"换房单";
            break;
        case 2:
            self.navigationItem.title=@"入住单";
            break;
    }
    [self clearDraw:nil];
}

#pragma mark Split view support

- (void)splitViewController: (UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc {
    
    barButtonItem.title = @"Root List";
    NSMutableArray *items = [[self.toolbar items] mutableCopy];
    [items insertObject:barButtonItem atIndex:0];
    [self.toolbar setItems:items animated:YES];
    self.popoverController = pc;
}

// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController: (UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    NSMutableArray *items = [[self.toolbar items] mutableCopy];
    [items removeObjectAtIndex:0];
    [self.toolbar setItems:items animated:YES];
    self.popoverController = nil;
}

#pragma mark Rotation support

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

@end
