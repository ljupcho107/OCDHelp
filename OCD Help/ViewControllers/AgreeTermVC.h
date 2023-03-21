//
//  AgreeTermVC.h
//  OCD Help
//
//  Created by RuniTDev on 9/26/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AgreeTermVCDelegate <NSObject>
- (void)onAgreeTermDismissed;
@end

@interface AgreeTermVC : UIViewController

@property (nonatomic, weak, nullable) id <AgreeTermVCDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
