//
//  HHVideoSegmentViewController.h
//  HuiHeadline
//
//  Created by eyuxin on 2017/9/26.
//  Copyright © 2017年 eyuxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHVideoSegmentViewController : WMPageController

+ (UINavigationController *)defaultSegmentVC;

@property (nonatomic, strong)NSMutableArray *itemNames;

@end
