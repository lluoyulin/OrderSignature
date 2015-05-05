//
//  RootTableViewController.h
//  OrderSignature
//
//  Created by freedom on 15/4/22.
//  Copyright (c) 2015年 freedom_luo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RootTableViewControllerDelegate <NSObject>

-(void)didSelectRowWithIndew:(NSInteger) rowIndex;

@end

@interface RootTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain) NSArray *listItem;

@property(nonatomic,weak) id<RootTableViewControllerDelegate> delegate;

@end
