//
//  DailyExercisesVC.m
//  OCD Help
//
//  Created by RuniTDev on 10/16/22.
//

#import "DailyExercisesVC.h"
#import "UIViewController+Extension.h"
#import "AppDelegate.h"
#import "SettingsManager.h"
#import "ExerciseTextInputCell.h"
#import "ExerciseButtonCell.h"
#import "UIAlertController+Blocks.h"

@interface DailyExercisesVC () <UICollectionViewDelegate, UICollectionViewDataSource, ExerciseTextInputCellDelegate> {
    
}

@end

@implementation DailyExercisesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Actions
- (IBAction)onEmergencyOcdChatClick:(id)sender {
    [self showWebViewWithTitle:@"Emergency OCD Chat" url:OCD_CHAT_URL];
}

#pragma mark - UICollectionView Delegate Methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
 
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *) collectionView.collectionViewLayout;
    if (indexPath.row == 0) {
        CGFloat width = collectionView.frame.size.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right;
        return CGSizeMake(width, 34);
    } else {
        CGFloat width = (collectionView.frame.size.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right) / 12;
        return CGSizeMake(width, width);
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 8;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 13;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ExerciseTextInputCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ExerciseTextInputCell" forIndexPath:indexPath];
        cell.textField.placeholder = [NSString stringWithFormat:@"ERP Exercise %ld", indexPath.section + 1];
        cell.textField.text = [[SettingsManager shared] exerciseTitleAtPosition:indexPath.section];
        cell.delegate = self;
        return cell;
    } else {
        ExerciseButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ExerciseButtonCell" forIndexPath:indexPath];
        
        HabitStatus habitStatus = [[SettingsManager shared] exerciseHabitStatus:indexPath.section habitPosition:indexPath.row - 1];
        switch (habitStatus) {
            case HabitStatusYes:
                cell.imageView.image = [UIImage imageNamed:@"checkmark"];
                break;
            case HabitStatusNo:
                cell.imageView.image = [UIImage imageNamed:@"cancel"];
                break;
            case HabitStatusNone:
                cell.imageView.image = [UIImage imageNamed:@"unknown"];
                break;
        }
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [UIAlertController showAlertInViewController:self
                                       withTitle:@"ERP CHECK"
                                         message:@"Did you do your ERP exercise successfully? (Remember that the most important part of ERP is response prevention after exposure.)"
                               cancelButtonTitle:nil
                          destructiveButtonTitle:@"Cancel"
                               otherButtonTitles:@[@"Yes", @"No"]
                                        tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
        if (buttonIndex == 2) {
            [[SettingsManager shared] setExerciseHabitStatus:indexPath.section habitPosition:indexPath.row - 1 habitStatus:HabitStatusYes];
            [collectionView reloadItemsAtIndexPaths:@[indexPath]];
        } else if (buttonIndex == 3) {
            [[SettingsManager shared] setExerciseHabitStatus:indexPath.section habitPosition:indexPath.row - 1 habitStatus:HabitStatusNo];
            [collectionView reloadItemsAtIndexPaths:@[indexPath]];
        }
    }];
}

#pragma mark - ExerciseTextCell Delegate Methods
- (void)textChanged:(ExerciseTextInputCell *)cell {
    NSIndexPath *indexPath = [collectionView indexPathForCell:cell];
    [[SettingsManager shared] setExerciseTitle:cell.textField.text atPostion:indexPath.section];
}

- (void)removeButtonClicked:(ExerciseTextInputCell *)cell {
    NSIndexPath *indexPath = [collectionView indexPathForCell:cell];
    NSString *message = [NSString stringWithFormat:@"Are you sure you want to reset for ERP Exercise %ld?", indexPath.section + 1];
    [UIAlertController showAlertInViewController:self
                                       withTitle:@"Confirm"
                                         message:message
                               cancelButtonTitle:nil
                          destructiveButtonTitle:@"No"
                               otherButtonTitles:@[@"Yes"]
                                        tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
        if (buttonIndex == 2) {
            [[SettingsManager shared] resetExerciseDataAtPosition:indexPath.section];
            [self->collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
        }
    }];
}

@end
