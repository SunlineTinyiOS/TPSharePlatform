//
//  TPSharePlatform.h
//  TinyBuilder
//
//  Created by kingdomrain on 2017/2/27.
//  Copyright © 2017年 Sunline. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JSExport.h>
#import <UIKit/UIKit.h>

@protocol TPUmengLoginProtocol <JSExport>
/**
 *  平台名称
 *  wxtimeline:朋友圈
 *  wxsession:微信好友
 *  sina:微博
 *  qq:qq好友
 *  qzone:qzone空间
 */
@property(nonatomic, strong) NSString *platformName;
/**
 *  分享的内容
 */
@property(nonatomic, strong) NSString *shareContent;

/**
 *  分享跳转地址
 */
@property(nonatomic, strong) NSString *shareUrl;

/**
 *  分享标题
 */
@property(nonatomic, strong) NSString *shareTitle;
/**
 *  分享图片
 */
@property(nonatomic, strong) NSString *shareimage;
@property(nonatomic, strong) JSValue *success;
@property(nonatomic, strong) JSValue *error;

/**
 *  第三方
 */
- (void)share;
@end

@interface TPSharePlatform : NSObject<TPUmengLoginProtocol>
@property (nonatomic , strong) UIViewController *viewController;


@end

