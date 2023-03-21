//
//  WebVC.h
//  OCD Help
//
//  Created by RuniTDev on 9/25/22.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebVC : UIViewController

@property (weak, nonatomic) IBOutlet WKWebView *webView;

@property NSString* urlString;

@end

NS_ASSUME_NONNULL_END
