//
//  XXShowWebViewController.m
//  01-在屏幕中显示指定的网页
//
//  Created by shine on 2017/6/6.
//  Copyright © 2017年 shine. All rights reserved.
//  在屏幕中显示指定的网页

#import "XXShowWebViewController.h"

@interface XXShowWebViewController ()<UIWebViewDelegate>

//webView
@property (nonatomic, strong) UIWebView *webView;

//指示器
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator ;

@end

@implementation XXShowWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.设置UI
    [self setupUI];
    
}

- (void)setupUI {
    
    //1.设置webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    self.webView = webView;
    [self.view addSubview:webView];
    
    //2.在工具条中追加活动指示器
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] init];
//    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    self.activityIndicator = activityIndicator;
    activityIndicator.frame = CGRectMake(0, 0, 20, 20);
    
    UIBarButtonItem *indicator = [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
    UIBarButtonItem *adjustment = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSArray *buttons = [NSArray arrayWithObjects:adjustment,indicator,adjustment, nil];
    
    //3.设置toolBar
    [self.navigationController.toolbar setBarStyle:UIBarStyleBlack];
    [self setToolbarItems:buttons animated:YES];
    [self.navigationController setToolbarHidden:NO animated:YES];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //让web页面显示
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.apple.com"]];
    
    [self.webView loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityIndicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.activityIndicator stopAnimating];
}

@end
