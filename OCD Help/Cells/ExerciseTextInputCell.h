//
//  ExerciseTextInputCell.h
//  OCD Help
//
//  Created by RuniTDev on 10/17/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ExerciseTextInputCellDelegate;

@interface ExerciseTextInputCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nullable, nonatomic, weak) id<ExerciseTextInputCellDelegate> delegate;

@end

@protocol ExerciseTextInputCellDelegate <NSObject>

- (void)textChanged:(ExerciseTextInputCell *)cell;
- (void)removeButtonClicked:(ExerciseTextInputCell *)cell;

@end

NS_ASSUME_NONNULL_END
