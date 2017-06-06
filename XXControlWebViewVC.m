//
//  XXControlWebViewVC.m
//  01-在屏幕中显示指定的网页
//
//  Created by shine on 2017/6/6.
//  Copyright © 2017年 shine. All rights reserved.
//

#import "XXControlWebViewVC.h"

@interface XXControlWebViewVC () <UIWebViewDelegate>

//webView
@property (nonatomic, strong) UIWebView *webView;

//暂停按钮
@property (nonatomic, strong) UIBarButtonItem *stopBtn;

//返回按钮
@property (nonatomic, strong) UIBarButtonItem *backBtn;

//下一页按钮
@property (nonatomic, strong) UIBarButtonItem *forwardBtn;

@end

@implementation XXControlWebViewVC

#pragma mark - view的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.apple.com"]];
    
    [self.webView loadRequest:request];
    
    [self updateControlState];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //画面关闭的时候状态条的活动指示器设置为off
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark - 内部控制方法
- (void)setupUI {
    
    //1.设置webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    self.webView = webView;
    [self.view addSubview:webView];
    
    //2.在工具条加入按钮
    
    //重载
    UIBarButtonItem *reloadBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadDidPush)];
    
    //停止
    UIBarButtonItem *stopBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopDidPush)];
    
    //返回前一页
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backDidPush)];
    
    //进入下一页
    UIBarButtonItem *forwardBtn = [[UIBarButtonItem alloc] initWithTitle:@"向前" style:UIBarButtonItemStylePlain target:self action:@selector(forwardDidPush)];

    
    NSArray *buttons = [NSArray arrayWithObjects:reloadBtn,stopBtn,backBtn,forwardBtn, nil];
    
    //3.设置toolBar
    [self.navigationController.toolbar setBarStyle:UIBarStyleBlack];
    [self setToolbarItems:buttons animated:YES];
    [self.navigationController setToolbarHidden:NO animated:YES];
}

- (void)reloadDidPush {
    [self.webView reload];
}

- (void)stopDidPush {
    if (self.webView.loading) {
        [self.webView stopLoading];
    }
}

- (void)backDidPush {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }
    
}

- (void)forwardDidPush {
    if (self.webView.canGoForward) {
        [self.webView goForward];
    }
}

//统一更新活动指示以及按钮状态
- (void)updateControlState {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = self.webView.loading;
    
    self.stopBtn.enabled = self.webView.loading;
    self.backBtn.enabled = self.webView.canGoBack;
    self.forwardBtn.enabled = self.webView.canGoForward;
    
}
#pragma mark - webView的代理
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self updateControlState];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self updateControlState];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self updateControlState];
}
@end
