//
//  ProgressVC.m
//  OCD Help
//
//  Created by RuniTDev on 10/11/22.
//

#import "ProgressVC.h"
#import "TrackersManager.h"
#import "AppDelegate.h"
#import "DayCell.h"
#import "Tracker.h"

#import "UIViewController+Extension.h"
#import "NSDate+Extension.h"
#import "UIAlertController+Blocks.h"

@interface ProgressVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSource> {
    RLMResults *allTrackersForRumination;
    RLMResults *allTrackersForCompulsions;
    RLMResults *allTrackersForAvoidances;
    CGSize collectionViewSize;
}

@end

@implementation ProgressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    allTrackersForRumination = [[TrackersManager shared] allTrackersForRumination];
    allTrackersForCompulsions = [[TrackersManager shared] allTrackersForCompulsions];
    allTrackersForAvoidances = [[TrackersManager shared] allTrackersForAvoidances];
    collectionViewSize = collectionView.frame.size;
    
    [self displayTrackersInfo];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (!CGSizeEqualToSize(collectionViewSize, collectionView.frame.size)) {
        [collectionView reloadData];
        collectionViewSize = collectionView.frame.size;
    }
}

#pragma mark - UICollectionView Delegate Methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 9;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 31;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat cellWidth = [self.view viewWithTag:100 + indexPath.section].frame.size.width;
    CGFloat cellHeight = [self.view viewWithTag:200 + indexPath.row].frame.size.height;
    
    return CGSizeMake(cellWidth, cellHeight);
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    DayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DayCell" forIndexPath:indexPath];
    cell.dayLabel.text = @"";
    cell.dayLabel.textColor = [UIColor systemRedColor];
    cell.backgroundColor = [UIColor whiteColor];
    
    if (segmentedControl.selectedSegmentIndex == 0) {
        if (indexPath.row >= allTrackersForRumination.count) {
            return cell;
        }
        
        Tracker *tracker = allTrackersForRumination[indexPath.row];
        
        NSInteger anxietyLevel = [tracker averageAnxietyLevel];
        NSInteger stressLevel = [tracker averageStressLevel];
        
        switch (indexPath.section) {
            case 0:
                if ([tracker totalRuminanceMinutes] > 0) {
                    cell.dayLabel.text = [Tracker stringForMinutes:[tracker totalRuminanceMinutes]];
                }
                break;
            case 1:
                if (tracker.ruminationMinsForWTo9 > 0) {
                    cell.dayLabel.text = [Tracker stringForMinutes:tracker.ruminationMinsForWTo9];
                }
                break;
            case 2:
                if (tracker.ruminationMinsFor9To12 > 0) {
                    cell.dayLabel.text = [Tracker stringForMinutes:tracker.ruminationMinsFor9To12];
                }
                break;
            case 3:
                if (tracker.ruminationMinsFor12To15 > 0) {
                    cell.dayLabel.text = [Tracker stringForMinutes:tracker.ruminationMinsFor12To15];
                }
                break;
            case 4:
                if (tracker.ruminationMinsFor15To18 > 0) {
                    cell.dayLabel.text = [Tracker stringForMinutes:tracker.ruminationMinsFor15To18];
                }
                break;
            case 5:
                if (tracker.ruminationMinsFor18To21 > 0) {
                    cell.dayLabel.text = [Tracker stringForMinutes:tracker.ruminationMinsFor18To21];
                }
                break;
            case 6:
                if (tracker.ruminationMinsFor21ToM > 0) {
                    cell.dayLabel.text = [Tracker stringForMinutes:tracker.ruminationMinsFor21ToM];
                }
                break;
            case 7:
                if (anxietyLevel >= 0) {
                    cell.backgroundColor = [Tracker colorForAnxietyLevel:anxietyLevel];
                    cell.dayLabel.text = [NSString stringWithFormat:@"%ld", anxietyLevel];
                    cell.dayLabel.textColor = [UIColor blackColor];
                }
                break;
            case 8:
                if (stressLevel >= 0) {
                    cell.backgroundColor = [Tracker colorForStressLevel:stressLevel];
                    cell.dayLabel.text = [NSString stringWithFormat:@"%ld", stressLevel];
                    cell.dayLabel.textColor = [UIColor blackColor];
                }
                break;
            default:
                break;
        }
    } else if (segmentedControl.selectedSegmentIndex == 1) {
        if (indexPath.row >= allTrackersForCompulsions.count) {
            return cell;
        }
        
        Tracker *tracker = allTrackersForCompulsions[indexPath.row];
        NSInteger anxietyLevel = [tracker averageAnxietyLevel];
        NSInteger stressLevel = [tracker averageStressLevel];
        
        switch (indexPath.section) {
            case 0:
                if ([tracker totalCompulsionsMinutes] > 0) {
                    cell.dayLabel.text = [Tracker stringForMinutes:[tracker totalCompulsionsMinutes]];
                }
                break;
            case 1:
                if (tracker.compulsionsMinsForWTo9 > 0) {
                    cell.dayLabel.text = [Tracker stringForMinutes:tracker.compulsionsMinsForWTo9];
                }
                break;
            case 2:
                if (tracker.compulsionsMinsFor9To12 > 0) {
                    cell.dayLabel.text = [Tracker stringForMinutes:tracker.compulsionsMinsFor9To12];
                }
                break;
            case 3:
                if (tracker.compulsionsMinsFor12To15 > 0) {
                    cell.dayLabel.text = [Tracker stringForMinutes:tracker.compulsionsMinsFor12To15];
                }
                break;
            case 4:
                if (tracker.compulsionsMinsFor15To18 > 0) {
                    cell.dayLabel.text = [Tracker stringForMinutes:tracker.compulsionsMinsFor15To18];
                }
                break;
            case 5:
                if (tracker.compulsionsMinsFor18To21 > 0) {
                    cell.dayLabel.text = [Tracker stringForMinutes:tracker.compulsionsMinsFor18To21];
                }
                break;
            case 6:
                if (tracker.compulsionsMinsFor21ToM > 0) {
                    cell.dayLabel.text = [Tracker stringForMinutes:tracker.compulsionsMinsFor21ToM];
                }
                break;
            case 7:
                if (anxietyLevel >= 0) {
                    cell.backgroundColor = [Tracker colorForAnxietyLevel:anxietyLevel];
                    cell.dayLabel.text = [NSString stringWithFormat:@"%ld", anxietyLevel];
                    cell.dayLabel.textColor = [UIColor blackColor];
                }
                break;
            case 8:
                if (stressLevel >= 0) {
                    cell.backgroundColor = [Tracker colorForStressLevel:stressLevel];
                    cell.dayLabel.text = [NSString stringWithFormat:@"%ld", stressLevel];
                    cell.dayLabel.textColor = [UIColor blackColor];
                }
                break;
            default:
                break;
        }
    } else if (segmentedControl.selectedSegmentIndex == 2) {
        if (indexPath.row >= allTrackersForAvoidances.count) {
            return cell;
        }
        
        Tracker *tracker = allTrackersForAvoidances[indexPath.row];
        NSInteger anxietyLevel = [tracker averageAnxietyLevel];
        NSInteger stressLevel = [tracker averageStressLevel];
        
        switch (indexPath.section) {
            case 0:
                if ([tracker totalAvoidancesMinutes] > 0) {
                    cell.dayLabel.text = [Tracker stringForMinutes:[tracker totalAvoidancesMinutes]];
                }
                break;
            case 1:
                if (tracker.avoidancesMinsForWTo9 > 0) {
                    cell.dayLabel.text = [Tracker stringForMinutes:tracker.avoidancesMinsForWTo9];
                }
                break;
            case 2:
                if (tracker.avoidancesMinsFor9To12 > 0) {
                    cell.dayLabel.text = [Tracker stringForMinutes:tracker.avoidancesMinsFor9To12];
                }
                break;
            case 3:
                if (tracker.avoidancesMinsFor12To15 > 0) {
                    cell.dayLabel.text = [Tracker stringForMinutes:tracker.avoidancesMinsFor12To15];
                }
                break;
            case 4:
                if (tracker.avoidancesMinsFor15To18 > 0) {
                    cell.dayLabel.text = [Tracker stringForMinutes:tracker.avoidancesMinsFor15To18];
                }
                break;
            case 5:
                if (tracker.avoidancesMinsFor18To21 > 0) {
                    cell.dayLabel.text = [Tracker stringForMinutes:tracker.avoidancesMinsFor18To21];
                }
                break;
            case 6:
                if (tracker.avoidancesMinsFor21ToM > 0) {
                    cell.dayLabel.text = [Tracker stringForMinutes:tracker.avoidancesMinsFor21ToM];
                }
                break;
            case 7:
                if (anxietyLevel >= 0) {
                    cell.backgroundColor = [Tracker colorForAnxietyLevel:anxietyLevel];
                    cell.dayLabel.text = [NSString stringWithFormat:@"%ld", anxietyLevel];
                    cell.dayLabel.textColor = [UIColor blackColor];
                }
                break;
            case 8:
                if (stressLevel >= 0) {
                    cell.backgroundColor = [Tracker colorForStressLevel:stressLevel];
                    cell.dayLabel.text = [NSString stringWithFormat:@"%ld", stressLevel];
                    cell.dayLabel.textColor = [UIColor blackColor];
                }
                break;
            default:
                break;
        }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < 7) {
        return;
    }
    
    RLMResults *allTrackers;
    if (segmentedControl.selectedSegmentIndex == 0) {
        allTrackers = allTrackersForRumination;
    } else if (segmentedControl.selectedSegmentIndex == 1) {
        allTrackers = allTrackersForCompulsions;
    } else {
        allTrackers = allTrackersForAvoidances;
    }
    
    if (indexPath.row >= allTrackers.count) {
        return;
    }
    
    Tracker *tracker = allTrackers[indexPath.row];
    
    if (tracker == nil || tracker.notes == nil || [tracker.notes isEqualToString:@""]) {
        [UIAlertController showAlertInViewController:self
                                           withTitle:tracker.dateString
                                             message:@""
                                   cancelButtonTitle:NSLocalizedString(@"OK", @"")
                              destructiveButtonTitle:nil
                                   otherButtonTitles:nil
                                            tapBlock:nil];
        return;
    }
    
    [UIAlertController showAlertInViewController:self
                                       withTitle:tracker.dateString
                                         message:tracker.notes
                               cancelButtonTitle:NSLocalizedString(@"OK", @"")
                          destructiveButtonTitle:nil
                               otherButtonTitles:nil
                                        tapBlock:nil];
}

#pragma mark - Actions
- (IBAction)onEmergencyOcdChatClick:(id)sender {
    [self showWebViewWithTitle:@"Emergency OCD Chat" url:OCD_CHAT_URL];
}

- (IBAction)onSegmentedControlValueChanged:(id)sender {
    [self displayTrackersInfo];
}

#pragma mark - Private Methods
- (void)displayTrackersInfo {
    [collectionView reloadData];
    
    RLMResults *allTrackers;
    if (segmentedControl.selectedSegmentIndex == 0) {
        allTrackers = allTrackersForRumination;
    } else if (segmentedControl.selectedSegmentIndex == 1) {
        allTrackers = allTrackersForCompulsions;
    } else {
        allTrackers = allTrackersForAvoidances;
    }
    
    for (NSInteger i = 0; i < 31; i++) {
        UIView *dateView = [self.view viewWithTag:200 + i];
        UILabel *dateLabel = (UILabel *)dateView.subviews.firstObject;
        dateLabel.text = @"";
        
        if (i >= allTrackers.count) {
            continue;
        }
        
        Tracker *tracker = allTrackers[i];
        NSDate *date = [NSDate dateFromString:tracker.dateString];
        dateLabel.text = [date monthAndDayStringValue];
        NSLog(@"%@", tracker);
    }
}

@end
