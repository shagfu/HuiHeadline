//
//  XHLaunchAdView.h
//  XHLaunchAdExample
//
//  Created by zhuxiaohui on 16/12/3.
//  Copyright © 2016年 it7090.com. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHLaunchAd

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import "XHLaunchAdImage.h"

@interface XHLaunchAdView : UIImageView

@property(nonatomic,copy) void(^adClick)(void); 

@end

#pragma mark - imageAdView
@interface XHLaunchImageAdView : XHLaunchAdView
@property (nonatomic,copy) NSString *runLoopMode;
@end

#pragma mark - videoAdView
@interface XHLaunchVideoAdView : XHLaunchAdView

@property (strong, nonatomic) MPMoviePlayerController *adVideoPlayer;
@property(nonatomic,assign)MPMovieScalingMode adVideoScalingMode;
-(void)stopVideoPlayer;
@end

