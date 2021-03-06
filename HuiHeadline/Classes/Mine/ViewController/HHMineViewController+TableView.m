//
//  HHMineViewController+TableView.m
//  HuiHeadline
//
//  Created by eyuxin on 2017/10/19.
//  Copyright © 2017年 eyuxin. All rights reserved.
//

#import "HHMineViewController+TableView.h"
#import "HHMineTableViewCell.h"
#import "HHMineNormalTableViewCell.h"
#import "HHMineNormalCellModel.h"
#import "HHMineInvitedViewController.h"
#import "HHMallViewController.h"
#import "HHMallSegmentViewController.h"
#import "HHMyOrderSegmentViewController.h"
#import "HHIncomeDetailViewController.h"
#import "CustomBrowserViewController.h"
#import "HHAboutHHViewController.h"
#import "HHMyMessageViewController.h"

@implementation HHMineViewController (TableView)

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1) {
        
        return self.models.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        HHMineTableViewCell *itemCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HHMineTableViewCell class]) forIndexPath:indexPath];
        itemCell.selectionStyle = UITableViewCellSelectionStyleNone;
        itemCell.delegate = self;
        return itemCell;
    } else if (indexPath.section == 1 || indexPath.section == 2) {
        HHMineNormalTableViewCell *normalCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HHMineNormalTableViewCell class]) forIndexPath:indexPath];
        [normalCell setModel:indexPath.section == 1 ? self.models[indexPath.row] : self.settingModels[indexPath.row]];
        return normalCell;
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return  G.$.bs ? 0 : 85;
        
    } else if (indexPath.section == 1 || indexPath.section == 2) {
        
        return 50;
        
    } else  {
        
        return 40;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return self.headerView;
        
    } else {
        
        return G.$.bs ? [UIView new] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 12)];
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    if (section == 0) {
        
        return H(self.headerView) + 10;
        
    } else {
        
        if (G.$.bs) {
            return 0.01;
        }
        
        return 12.0f;
    }
}

kRemoveCellSeparator


#pragma mark UITableViewDelegate

- (void)clearMemory {
    [HHHeadlineAwardHUD showHUDWithText:@"正在清理..." animated:YES];
    [HHUtils clearFile:^(NSString *cache) {
        
        [HHHeadlineAwardHUD hideHUDAnimated:YES];
        [HHHeadlineAwardHUD showMessage:[NSString stringWithFormat:@"成功清除%@缓存！", cache] animated:YES duration:2];
    }];
}

- (void)checkVersion {
    [HHHeadlineAwardHUD showHUDWithText:@"正在检查当前版本，请稍后" animated:YES];
    [HHMineNetwork versionCheck:^(id error, HHResponse *response) {
        [HHHeadlineAwardHUD hideHUDAnimated:YES];
        if (response.statusCode == 200 && !response.msg) {
            
            [HHHeadlineAwardHUD showMessage:@"当前已经是最新版本了" animated:YES duration:2];
        } else {
            
        }
        
    }];
}

- (void)gotoAppStore {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:k_appstore_link]];
    
}

- (void)userProtocol {
    CustomBrowserViewController *webView = [CustomBrowserViewController new];
    webView.activityTitle = @"惠头条用户服务协议";
    webView.URLString = k_user_protocol;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webView animated:1];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)aboutCashtoutiao {
    
    HHAboutHHViewController *aboutVC = [HHAboutHHViewController new];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:aboutVC animated:1];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)pushMyMessageVC {
    
    HHMyMessageViewController *myMessageVC = [HHMyMessageViewController new];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myMessageVC animated:1];
    self.hidesBottomBarWhenPushed = NO;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        if (indexPath.row == 0) {
            
            [self clearMemory];
//            [self pushMyMessage VC];
            
        } else if (indexPath.row == 1) {
            
            [self checkVersion];
            
        } else if (indexPath.row == 2) {
            
           
            [self gotoAppStore];
            
        } else if (indexPath.row == 3) {
            
            [self userProtocol];
            
        } else if (indexPath.row == 4) {
            
            [self aboutCashtoutiao];
        }
    }
    
}

#pragma mark HHMineTableViewCellDelegate

- (void)HHMineTableViewCellDidClickButtonText:(NSString *)text {
    
    [self pushVC:text];
}



- (void)pushVC:(NSString *)title {
    __block UIViewController *vc =nil;
    if ([title isEqualToString:@"商城兑换"]) {
        vc = [HHMallSegmentViewController new];
    } else if ([title isEqualToString:@"我的订单"]) {
        vc = [HHMyOrderSegmentViewController new];
    }  else if ([title isEqualToString:@"师徒邀请"]) {
        
        vc = [HHMineInvitedViewController new];
        
    }  else if ([title isEqualToString:@"收益明细"]) {
        vc = [HHIncomeDetailViewController new];
    }
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}








@end
