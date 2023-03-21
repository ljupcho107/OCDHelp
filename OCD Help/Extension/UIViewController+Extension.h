//
//  UIViewController+Extension.h
//  OCD Help
//
//  Created by RuniTDev on 9/29/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Extension)

- (void)showWebViewWithTitle:(NSString *)title url:(NSString *)url;
- (void)playAudioWithFilename:(NSString *)filename;

@end

NS_ASSUME_NONNULL_END
