//
//  BookVC.h
//  OCD Help
//
//  Created by RuniTDev on 9/26/22.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookVC : UIViewController

@property (weak, nonatomic) IBOutlet WKWebView *webView;

@property NSString* pdfFileName;

@end

NS_ASSUME_NONNULL_END
