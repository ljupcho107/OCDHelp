//
//  BookCell.h
//  OCD Help
//
//  Created by RuniTDev on 9/26/22.
//

#import <UIKit/UIKit.h>
#import "Book.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookCell : UICollectionViewCell

@property (nonatomic) Book *book;

@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet UIView *buyBadgeView;
@property (weak, nonatomic) IBOutlet UILabel *buyBadgeLabel;
@property (weak, nonatomic) IBOutlet UIView *audioBadgeView;

@end

NS_ASSUME_NONNULL_END
