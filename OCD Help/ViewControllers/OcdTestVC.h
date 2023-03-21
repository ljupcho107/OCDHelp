//
//  OcdTestVC.h
//  OCD Help
//
//  Created by RuniTDev on 9/25/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OcdTestVC : UIViewController {
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UILabel *resultLabel;
    __strong IBOutletCollection(UIButton) NSArray *questionButtons;
}

@end

NS_ASSUME_NONNULL_END
