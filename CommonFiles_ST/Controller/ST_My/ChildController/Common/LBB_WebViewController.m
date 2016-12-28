//
//  LBB_WebViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/9.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_WebViewController.h"

@interface LBB_WebViewController ()<UIWebViewDelegate>

@property(weak,nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end

@implementation LBB_WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!self.webViewURL) {
         self.webViewURL = @"https://www.baidu.com/";
    }
    
    if (self.webViewURL) {
        NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.webViewURL]];
        [request addValue:@"true" forHTTPHeaderField:@"islbbApp"];
        [self.webView loadRequest:request];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.indicator startAnimating];
    self.indicator.hidden = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
    [self.indicator stopAnimating];
    self.indicator.hidden = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.indicator stopAnimating];
    self.indicator.hidden = YES;
}

@end
