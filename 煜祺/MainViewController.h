//
//  MainViewController.h
//  煜祺
//
//  Created by H-YXH on 6/21/13.
//  Copyright (c) 2013 H-YXH. All rights reserved.
//

#import "FlipsideViewController.h"
#import "SinaWeibo.h"
#import <iAd/iAd.h>
#import "ContentViewController.h"
#import "AppDelegate.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate,ADBannerViewDelegate,SinaWeiboDelegate>

@property (retain, nonatomic) IBOutlet ADBannerView *iAdBannerViewOutlet;

- (IBAction)showInfo:(id)sender;
- (IBAction)iADControllerAction:(id)sender;

- (IBAction)sinaweiboLoginAction:(id)sender;
@end
