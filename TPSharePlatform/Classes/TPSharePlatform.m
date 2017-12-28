//
//  TPSharePlatform.m
//  TinyBuilder
//
//  Created by kingdomrain on 2017/2/27.
//  Copyright © 2017年 Sunline. All rights reserved.
//

#import "TPSharePlatform.h"
#import <UMSocialCore/UMSocialCore.h>

@implementation TPSharePlatform
@synthesize shareContent;
@synthesize shareTitle;
@synthesize shareUrl;
@synthesize platformName;
@synthesize success;
@synthesize error;
@synthesize shareimage;
-(id)init
{
    if(self = [super init]) {
        Class TinyPlus=NSClassFromString(@"TinyPlus");
        if(TinyPlus){
            id tinyPlusInPod  =  [[TinyPlus alloc] init];
            if([tinyPlusInPod respondsToSelector:@selector(getViewController)]){
                self.viewController =[tinyPlusInPod performSelector:@selector(getViewController)];
            }
        }
    }
    return self;
}
- (void)share
{
    
    if(!self.shareimage){
        //分享网页链接
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //创建网页内容对象
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:shareTitle descr:shareContent thumImage:[UIImage imageNamed:@"icon"]];
        //设置网页地址
        shareObject.webpageUrl =shareUrl;
        
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        //分享的平台
        NSUInteger UMSocialPlatformType = UMSocialPlatformType_UnKnown;
        if([platformName isEqualToString:@"wxtimeline"]){
            UMSocialPlatformType = UMSocialPlatformType_WechatTimeLine;
        }
        else if([platformName isEqualToString:@"wxsession"]){
            UMSocialPlatformType = UMSocialPlatformType_WechatSession;
        }else if([platformName isEqualToString:@"facebook"]){
            UMSocialPlatformType = UMSocialPlatformType_Facebook;
        }
        else{
            
        }
        
        [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType messageObject:messageObject currentViewController:self.viewController completion:^(id data, NSError *terror) {
            NSString *message = nil;
            if (!terror) {
                message = [NSString stringWithFormat:@"分享成功"];
                [self.success callWithArguments:@[message]];
            } else {
                message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)terror.code];
                [self.error callWithArguments:@[message]];
            }
        }];
    }else{
        //分享纯图片
        
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        //如果有缩略图，则设置缩略图
        
        /*
         *   支持local:///和file:开头的文件路径
         *   modify  yuzhifei  20161221
         */
        NSString *path;
        NSURL *url;
        NSData *image;
        if([[self.shareimage substringWithRange:NSMakeRange(0, 5)] isEqualToString:@"local"]){
            path = [self.shareimage stringByReplacingOccurrencesOfString:@"local:///" withString:@""];
            url=[NSURL fileURLWithPath:path];       //本地的路径
            image = [NSData dataWithContentsOfURL:url];
        }
        else if([[self.shareimage substringWithRange:NSMakeRange(0, 4)] isEqualToString:@"file"]){
            /*
             *   file:开头路径
             *   modify  yuzhifei  20170622
             */
            NSString *tempStr = [[NSString alloc]initWithFormat:@"%@",self.shareimage];
            NSRange range = [tempStr rangeOfString:@"file:///"];
            NSString *PathStr = [tempStr substringFromIndex:(range.length-1)];
            //需要相对的路径转变成绝对路径，这样才能找到资源文件
            path=[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:PathStr];
            url =[NSURL fileURLWithPath:path];
            image = [NSData dataWithContentsOfURL:url];
            //本地的路径
        }else{
            path =self.shareimage;
            url =[NSURL fileURLWithPath:path];
            image = [NSData dataWithContentsOfURL:url];
        }
        
        shareObject.thumbImage = [UIImage imageWithData:image];
        [shareObject setShareImage:[UIImage imageWithData:image]];
        
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        //分享的平台
        NSUInteger UMSocialPlatformType = UMSocialPlatformType_UnKnown;
        if([platformName isEqualToString:@"wxtimeline"]){
            UMSocialPlatformType = UMSocialPlatformType_WechatTimeLine;
        }
        else if([platformName isEqualToString:@"wxsession"]){
            UMSocialPlatformType = UMSocialPlatformType_WechatSession;
        }else if([platformName isEqualToString:@"facebook"]){
            UMSocialPlatformType = UMSocialPlatformType_Facebook;
        }
        else{
            
        }
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType messageObject:messageObject currentViewController:self.viewController completion:^(id data, NSError *terror) {
            NSString *message = nil;
            if (!terror) {
                message = [NSString stringWithFormat:@"分享成功"];
                [self.success callWithArguments:@[message]];
            } else {
                message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)terror.code];
                [self.error callWithArguments:@[message]];
            }
        }];
    }
}

-(void)dealloc{
    NSLog(@"友盟分享插件销毁");
}

@end

