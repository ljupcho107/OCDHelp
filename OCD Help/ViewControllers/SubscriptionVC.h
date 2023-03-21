//
//  SubscriptionVC.h
//  OCD Help
//
//  Created by RuniTDev on 9/26/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SubscriptionVCDelegate <NSObject>
- (void)onSubscriptionDismissed;
@end

@interface SubscriptionVC : UIViewController

@property (nonatomic, weak, nullable) id <SubscriptionVCDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
