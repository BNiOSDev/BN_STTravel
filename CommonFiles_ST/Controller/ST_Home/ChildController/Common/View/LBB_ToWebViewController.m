//
//  LBB_ToWebViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/21.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ToWebViewController.h"

#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
@interface LBB_ToWebViewController ()<UIWebViewDelegate, NJKWebViewProgressDelegate>{
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}

@property(nonatomic,retain)UIWebView* web;

@end

@implementation LBB_ToWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void)loadCustomNavigationButton{
    [super loadCustomNavigationButton];
    if (self.webTitle) {
        self.title = self.webTitle;
    }
}

-(void)buildControls{
    
    WS(ws);
    self.web = [UIWebView new];
    [self.view addSubview:self.web];
    [self.web mas_makeConstraints:^(MASConstraintMaker* make){
        
        make.centerX.width.top.equalTo(self.view);
        make.bottom.equalTo(ws.view);
    }];
    
    [self.web setScalesPageToFit:YES];
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    self.web.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    _progressView = [[NJKWebViewProgressView alloc] init];
    [self.view addSubview:_progressView];
    [_progressView mas_makeConstraints:^(MASConstraintMaker* make){
        
        make.width.equalTo(ws.view);
        make.height.mas_equalTo(2);
        make.top.equalTo(self.web);
    }];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    if (self.isLoadHtml) {
        [self loadHTML];
    }
    else{
        NSURL* url = self.url;
        NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
        [self.web loadRequest:request];
    }
}


#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
    if (!self.webTitle) {
        NSString *title = [self.web stringByEvaluatingJavaScriptFromString:@"document.title"];
        
        if (title.length)
            self.title = title;
    }
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [_progressView setProgress:1.0 animated:YES];
    
}

-(void)loadHTML{
    
    [self.web loadHTMLString:self.htmlString?self.htmlString:@"" baseURL:nil];
}

@end
