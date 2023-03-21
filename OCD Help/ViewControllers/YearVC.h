//
//  YearVC.h
//  OCD Help
//
//  Created by RuniTDev on 10/10/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YearVC : UIViewController {
    __weak IBOutlet UIView *shareView;
    __weak IBOutlet UICollectionView *yearCollectionView;
    __weak IBOutlet UICollectionView *anxietyLevelCollectionView;
    __strong IBOutletCollection(UILabel) NSArray *monthNameLabels;
}

@end

NS_ASSUME_NONNULL_END
