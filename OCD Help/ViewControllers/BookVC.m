//
//  BookVC.m
//  OCD Help
//
//  Created by RuniTDev on 9/26/22.
//

#import "BookVC.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface BookVC () <WKNavigationDelegate>

@end

@implementation BookVC

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
    NSString *path = [[NSBundle mainBundle] pathForResource:self.pdfFileName ofType:@"pdf"];
    NSURL *url = [NSURL fileURLWithPath:path];
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
