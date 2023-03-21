//
//  AnxietyLevelCell.h
//  OCD Help
//
//  Created by RuniTDev on 10/10/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnxietyLevelCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;

@end

NS_ASSUME_NONNULL_END
