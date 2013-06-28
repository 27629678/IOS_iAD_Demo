//
//  AppDelegate.h
//  煜祺
//
//  Created by H-YXH on 6/21/13.
//  Copyright (c) 2013 H-YXH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"


#define kAppKey             @"2878776055"
#define kAppSecret          @"4965d9e40c2cd537e30804ef2b155473"
#define kAppRedirectURI     @"http://61.163.com"

#ifndef kAppKey
#error
#endif

#ifndef kAppSecret
#error
#endif

#ifndef kAppRedirectURI
#error
#endif

@class SinaWeibo;
@class MainViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,SinaWeiboDelegate,SinaWeiboRequestDelegate>
{
    SinaWeibo *sinaweibo;
}

@property (readonly, nonatomic) SinaWeibo *sinaweibo;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MainViewController *mainViewController;

@end
