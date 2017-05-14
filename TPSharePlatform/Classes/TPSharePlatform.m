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
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:shareTitle descr:shareContent thumImage:[UIImage imageNamed:@"icon"]];
    //设置网页地址
    shareObject.webpageUrl =shareUrl;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //分享的平台
    NSUInteger UMSocialPlatformType;
    if([platformName isEqualToString:@"wxtimeline"]){
        UMSocialPlatformType = UMSocialPlatformType_WechatTimeLine;
    }
    else if([platformName isEqualToString:@"wxsession"]){
        UMSocialPlatformType = UMSocialPlatformType_WechatSession;
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
}

-(void)dealloc{
    NSLog(@"友盟分享插件销毁");
}

@end
