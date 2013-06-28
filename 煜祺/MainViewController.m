//
//  MainViewController.m
//  煜祺
//
//  Created by H-YXH on 6/21/13.
//  Copyright (c) 2013 H-YXH. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize iAdBannerViewOutlet = _iAdBannerViewOutlet;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self initAdView];
    
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
}

- (void)initAdView
{
    [self.iAdBannerViewOutlet setDelegate:self];
    [self.iAdBannerViewOutlet setUserInteractionEnabled:NO];
//    self.iAdBannerViewOutlet.frame = CGRectOffset(self.iAdBannerViewOutlet.frame, 0, -50);
}

- (void)bannerViewAnimation {
    
    //动画设定
    [UIView beginAnimations:@"BannerViewAnimation" context:NULL];
    
    //以userInteractionEnabled状态排判断bannerView是否在画面内
    if (self.iAdBannerViewOutlet.userInteractionEnabled) {
        self.iAdBannerViewOutlet.frame = CGRectOffset(self.iAdBannerViewOutlet.frame, 0, 50);
    }
    else {
        self.iAdBannerViewOutlet.frame = CGRectOffset(self.iAdBannerViewOutlet.frame, 0, -50);
    }
    
    //开始动画
    [UIView commitAnimations];
    
    //将userInteractionEnabled做反向设定
    self.iAdBannerViewOutlet.userInteractionEnabled = !self.iAdBannerViewOutlet.userInteractionEnabled;
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
//    if (self.iAdBannerViewOutlet.userInteractionEnabled) return;
//    
//    self.iAdBannerViewOutlet.userInteractionEnabled = YES;
//    [UIView beginAnimations:@"BannerViewAnimation" context:NULL];
//    self.iAdBannerViewOutlet.frame = CGRectOffset(self.iAdBannerViewOutlet.frame, 0, -50);
//    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showInfo:(id)sender
{    
    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)iADControllerAction:(id)sender
{
    [self bannerViewAnimation];
}

- (IBAction)sinaweiboLoginAction:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    NSLog(@"%@", [keyWindow subviews]);
    
    SinaWeibo *sinaweibo = [self sinaweibo];
//    [sinaweibo logOut];
    [sinaweibo logIn];
}

- (SinaWeibo *)sinaweibo
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
}

- (void)storeAuthData
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)openContentViewController
{
    ContentViewController* view = [[ContentViewController alloc]init];
    [self presentViewController:view animated:YES completion:nil];
}

#pragma mark sina weibo delegate methods

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    [self storeAuthData];
    [self openContentViewController];
}
@end
