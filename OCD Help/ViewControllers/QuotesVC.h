//
//  QuotesVC.h
//  OCD Help
//
//  Created by RuniTDev on 9/25/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuotesVC : UIViewController {
    __weak IBOutlet UIImageView *quoteImageView;
    NSInteger currentQuotePosition;
}

@end

NS_ASSUME_NONNULL_END
