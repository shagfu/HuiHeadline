//
//  HHActivityTaskDetailWebViewController.h
//  HuiHeadline
//
//  Created by eyuxin on 2017/10/27.
//  Copyright © 2017年 eyuxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHBaseViewController.h"


@interface CustomBrowserViewController : HHBaseViewController

@property (nonatomic, copy)void(^callback)();

@property(nonatomic,copy)NSString *URLString;

@property(nonatomic,copy)NSString *activityTitle;

@end
