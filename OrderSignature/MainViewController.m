//
//  MainViewController.m
//  OrderSignature
//
//  Created by freedom on 15/4/20.
//  Copyright (c) 2015年 freedom_luo. All rights reserved.
//

#import "MainViewController.h"
#import "SignUIView.h"

@interface MainViewController ()

@property(nonatomic,strong) SignUIView *sign;

@property(nonatomic,strong) UILabel *label;
@property(nonatomic,strong) UISplitViewController *splitVC;
@property(nonatomic,strong) UIPopoverController *popoverController;
@property(nonatomic,strong) UIToolbar *toolbar;

@end

@implementation MainViewController

@synthesize popoverController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveDraw:)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(clearDraw:)];
    
    self.sign=[[SignUIView alloc] init];
    self.sign.backgroundColor=[UIColor whiteColor];
    self.sign.currentSize=3.0;
    self.sign.currentColor=[UIColor blackColor];
    //    self.sign.pickedImage=[UIImage imageNamed:@"Default"];
    self.sign.arrayStrokes=[[NSMutableArray alloc] init];
    
    self.view=self.sign;    
}

/**
 *  清除画布
 *
 *  @param btn 清除按钮
 */
-(void)clearDraw:(UIBarButtonItem *)btn
{
    [self.sign.arrayStrokes removeAllObjects];
    [self.sign setNeedsDisplay];
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
