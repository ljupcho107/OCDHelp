//
//  ExerciseTextInputCell.m
//  OCD Help
//
//  Created by RuniTDev on 10/17/22.
//

#import "ExerciseTextInputCell.h"

@interface ExerciseTextInputCell () <UITextFieldDelegate>

@end

@implementation ExerciseTextInputCell

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(textChanged:)]) {
        [self.delegate textChanged:self];
    }
}

- (IBAction)onRemoveButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(removeButtonClicked:)]) {
        [self.delegate removeButtonClicked:self];
    }
}

@end
