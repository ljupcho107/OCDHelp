//
//  ProgressVC.h
//  OCD Help
//
//  Created by RuniTDev on 10/11/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProgressVC : UIViewController {
    __weak IBOutlet UISegmentedControl *segmentedControl;
    __weak IBOutlet UICollectionView *collectionView;
}

@end

NS_ASSUME_NONNULL_END
