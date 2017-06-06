//
//  XXTableViewController.m
//  01-在屏幕中显示指定的网页
//
//  Created by shine on 2017/6/6.
//  Copyright © 2017年 shine. All rights reserved.
//

#import "XXTableViewController.h"

@interface XXTableViewController ()

//控制talbeVIew要显示的个数
@property (nonatomic, strong) NSArray *titleArray;

//控制要跳转的控制器
@property (nonatomic, strong) NSArray *controllerNameArray;

@end

@implementation XXTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Web";
    
    self.titleArray = @[@"在屏幕中显示指定的网页",@"控制屏幕中的网页",@"在网页中加载PDF，Word和JPEG图片",@"在网页中加载HTML代码",@"在网页中实现触摸处理"];
    
    self.controllerNameArray = @[@"XXShowWebViewController",@"XXControlWebViewVC",@"XXLoadResViewController",@"XXLoadHTMLCodeViewController",@"XXTouchControlViewController"];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.titleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuseID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UIViewController *detailVC = [NSClassFromString(self.controllerNameArray[indexPath.row]) new];
    
    detailVC.title = self.titleArray[indexPath.row];
    
    [self.navigationController pushViewController:detailVC animated:YES];
}


@end
