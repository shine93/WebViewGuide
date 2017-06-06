//
//  XXLoadHTMLCodeViewController.m
//  01-在屏幕中显示指定的网页
//
//  Created by shine on 2017/6/6.
//  Copyright © 2017年 shine. All rights reserved.
//

#import "XXLoadHTMLCodeViewController.h"

@interface XXLoadHTMLCodeViewController ()

//webView
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation XXLoadHTMLCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}


- (void)setupUI {
    UIWebView *webView = [[UIWebView alloc] init];
    self.webView = webView;
    webView.frame = self.view.bounds;
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    webView.dataDetectorTypes = UIDataDetectorTypeAll;
    [self.view addSubview:webView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSString *html = @"<b>手机号码</b><br>000-00000-0000<hr><b>主页</b><br>http://www.apple.com/";
    
    [self.webView loadHTMLString:html baseURL:nil];
}


@end
