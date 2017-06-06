//
//  XXShowWebViewController.m
//  01-在屏幕中显示指定的网页
//
//  Created by shine on 2017/6/6.
//  Copyright © 2017年 shine. All rights reserved.
//  在屏幕中显示指定的网页

#import "XXLoadResViewController.h"

@interface XXLoadResViewController ()<UIWebViewDelegate>

//webView
@property (nonatomic, strong) UIWebView *webView;

//指示器
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator ;

@end

@implementation XXLoadResViewController

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
    //让webView能缩放
    [webView setScalesPageToFit:YES];
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
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
    
    //1.让web页面显示pdf
    /*
    NSString *path = [[NSBundle mainBundle] pathForResource:@"01-详情页(界面搭建)" ofType:@"pdf"];
    if (path) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        [self.webView loadData:data MIMEType:@"application/pdf" textEncodingName:nil baseURL:nil];
    }else {
        NSLog(@"文件没找到");
    }
    */
    
    //2.让web页面显示jpg
    /*
    NSString *path = [[NSBundle mainBundle] pathForResource:@"得分页面" ofType:@"jpeg"];
    if (path) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        [self.webView loadData:data MIMEType:@"image/jpeg" textEncodingName:nil baseURL:nil];
    }else {
        NSLog(@"文件没找到");
    }
    */
    
    //1.让web页面显示doc
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"doc"];
    if (path) {
//        NSData *data = [NSData dataWithContentsOfFile:path];
//        [self.webView loadData:data MIMEType:@"application/pdf" textEncodingName:nil baseURL:nil];
        NSURL *url = [NSURL fileURLWithPath:path];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }else {
        NSLog(@"文件没找到");
    }
    
    

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
