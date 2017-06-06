//
//  XXShowWebViewController.m
//  01-在屏幕中显示指定的网页
//
//  Created by shine on 2017/6/6.
//  Copyright © 2017年 shine. All rights reserved.
//  在屏幕中显示指定的网页

#import "XXTouchControlViewController.h"

@interface XXTouchControlViewController ()<UIWebViewDelegate>

//webView
@property (nonatomic, strong) UIWebView *webView;

//指示器
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator ;

@end

@implementation XXTouchControlViewController

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

    [self loadHTMLFile:@"top.html"];

    
}

- (void)loadHTMLFile:(NSString *)path {
    
    // 第一种方法,这种方法，html里面的链接可以连接过去
    /*
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *filePath  = [resourcePath stringByAppendingPathComponent:path];
    //     NSString *filePath = [[NSBundle mainBundle] pathForResource:@"top.html" ofType:nil];
    NSString *htmlstring =[[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    [self.webView loadHTMLString:htmlstring  baseURL:[NSURL fileURLWithPath: [[NSBundle mainBundle] bundlePath]]];
     */
     
    //第二种方法，这种方法，html里面的链接链接不过去,实现shouldStartLoadWithRequest方法
    
    NSArray *components = [path pathComponents];
    NSString *resourceName = [components lastObject];
    NSString *absolutePath = [[NSBundle mainBundle] pathForResource:resourceName ofType:nil];
    if (absolutePath) {
        NSData *data = [NSData dataWithContentsOfFile:absolutePath];
        [self.webView loadData:data MIMEType:@"text/html" textEncodingName:@"uft-8" baseURL:nil];
    }else {
        NSLog(@"%@ 没找到",resourceName);
    }
     
     
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //触摸链接后，进入href属性为URL的下一个画面
    if (UIWebViewNavigationTypeLinkClicked == navigationType) {
        NSString *url = [[request URL] path];
        [self loadHTMLFile:url];
        return NO;
    }else if (UIWebViewNavigationTypeFormSubmitted == navigationType) {
        NSString *url = [[request URL] path];
        NSArray *components = [url pathComponents];
        NSString *resultString = [webView stringByEvaluatingJavaScriptFromString:[components lastObject]];
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"title" message:resultString preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:nil];
        return NO;
    }
    
    return YES;
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
