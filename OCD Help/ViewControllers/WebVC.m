//
//  WebVC.m
//  OCD Help
//
//  Created by RuniTDev on 9/25/22.
//

#import "WebVC.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface WebVC () <WKNavigationDelegate>

@end

@implementation WebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self loadUrl];
}

#pragma mark - Private Methods
- (void)setupUI {
    [self.webView setNavigationDelegate:self];
}

- (void)loadUrl {
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

#pragma mark - WebView Navigation Delegate Methods
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
