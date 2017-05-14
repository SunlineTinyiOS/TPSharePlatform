//
//  TPSharePlatformViewController.m
//  TPSharePlatform
//
//  Created by bygd2014@sina.com on 05/14/2017.
//  Copyright (c) 2017 bygd2014@sina.com. All rights reserved.
//

#import "TPSharePlatformViewController.h"
#import <TPSharePlatform/TPSharePlatform.h>


@interface TPSharePlatformViewController ()

@end

@implementation TPSharePlatformViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    TPSharePlatform *sharePlatform = [[TPSharePlatform alloc]init];
    [sharePlatform share];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

    
}

@end
