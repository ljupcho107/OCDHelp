//
//  YearVC.m
//  OCD Help
//
//  Created by RuniTDev on 10/10/22.
//

#import "YearVC.h"
#import "UIViewController+Extension.h"
#import "AppDelegate.h"
#import "AnxietyLevelCell.h"
#import "DayCell.h"
#import "Tracker.h"
#import "TrackersManager.h"
#import "OCD_Help-Swift.h"

#import "UIAlertController+Blocks.h"
#import "NSDate+Extension.h"

#import <Photos/Photos.h>
#import <Messages/Messages.h>
#import <MessageUI/MessageUI.h>

@interface YearVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate> {
    NSDate *firstDate;
    RLMResults *allTrackers;
    CGSize yearCollectionViewSize;
}

@end

@implementation YearVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    allTrackers = [Tracker allObjects];
    firstDate = [[NSDate new] firstDateOfMonth];
    NSDate *oneYearAgo = [firstDate dateByAddingMonths:-11];
    
    Tracker *firstTracker = [[allTrackers sortedResultsUsingKeyPath:@"dateString" ascending:true] firstObject];
    if (firstTracker != nil) {
        NSDate *date = [[NSDate dateFromString:firstTracker.dateString] firstDateOfMonth];
        if ([date compare:oneYearAgo] == NSOrderedAscending) {
            firstDate = oneYearAgo;
        } else {
            firstDate = date;
        }
    }
    
    yearCollectionViewSize = yearCollectionView.frame.size;
    
    [self setupUI];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (!CGSizeEqualToSize(yearCollectionViewSize, yearCollectionView.frame.size)) {
        [yearCollectionView reloadData];
        yearCollectionViewSize = yearCollectionView.frame.size;
    }
}

#pragma mark - UICollectionView Delegate Methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (collectionView == yearCollectionView) {
        return 12;
    } else if (collectionView == anxietyLevelCollectionView) {
        return 1;
    }
    
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == yearCollectionView) {
        NSDate *monthDate = [firstDate dateByAddingMonths:section];
        return [monthDate numberOfDaysOfMonth];
    } else if (collectionView == anxietyLevelCollectionView) {
        return 11;
    }
    
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == yearCollectionView) {
        CGFloat cellWidth = [self.view viewWithTag:100 + indexPath.section].frame.size.width;
        CGFloat cellHeight = [self.view viewWithTag:200 + indexPath.row].frame.size.height;
        
        return CGSizeMake(cellWidth, cellHeight);
    } else {
        return CGSizeMake(40, 20);
    }
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (collectionView == yearCollectionView) {
        NSDate *date = [[firstDate dateByAddingMonths:indexPath.section] dateByAddingDays:indexPath.row];
        NSString *where = [NSString stringWithFormat:@"dateString = '%@'", [date dateStringValue]];
        Tracker *tracker = [[allTrackers objectsWhere:where] firstObject];
        
        DayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DayCell" forIndexPath:indexPath];
        
        cell.dayLabel.text = @"";
        cell.backgroundColor = [UIColor whiteColor];
        
        if (tracker) {
            NSInteger anxietyLevel = [tracker averageAnxietyLevel];

            if (anxietyLevel >= 0) {
                cell.backgroundColor = [Tracker colorForAnxietyLevel:anxietyLevel];
                cell.dayLabel.text = [NSString stringWithFormat:@"%ld", anxietyLevel];
            }
        }
        
        return cell;
    } else if (collectionView == anxietyLevelCollectionView) {
        AnxietyLevelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnxietyLevelCell" forIndexPath:indexPath];
        cell.colorView.backgroundColor = [Tracker colorForAnxietyLevel:indexPath.row];
        cell.levelLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
        
        return cell;
    }
    
    return [UICollectionViewCell new];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView != yearCollectionView) {
        return;
    }
    
    NSDate *date = [[firstDate dateByAddingMonths:indexPath.section] dateByAddingDays:indexPath.row];
    NSString *where = [NSString stringWithFormat:@"dateString = '%@'", [date dateStringValue]];
    Tracker *tracker = [[allTrackers objectsWhere:where] firstObject];
    
    if (tracker == nil || tracker.notes == nil || [tracker.notes isEqualToString:@""]) {
        [UIAlertController showAlertInViewController:self
                                           withTitle:[date dateStringValue]
                                             message:@""
                                   cancelButtonTitle:NSLocalizedString(@"OK", @"")
                              destructiveButtonTitle:nil
                                   otherButtonTitles:nil
                                            tapBlock:nil];
        return;
    }
    
    [UIAlertController showAlertInViewController:self
                                       withTitle:[date dateStringValue]
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

- (IBAction)onEmailShareClick:(id)sender {
    MFMailComposeViewController * composeVC = [MFMailComposeViewController new];
    if (![MFMailComposeViewController canSendMail]) {
        return;
    }
    
    NSString * img = [self getImageToShare];
    NSURL * url = [NSURL fileURLWithPath:img];
    [composeVC addAttachmentData:[NSData dataWithContentsOfURL:url] mimeType:@"image/png" fileName:@"image"];
    composeVC.delegate = self;
    composeVC.mailComposeDelegate = self;
    
    [self presentViewController:composeVC animated:YES completion:nil];
}

- (IBAction)onInstagramShareClick:(id)sender {
    InstagramPublisher * publisher = [InstagramPublisher new];
    
    UIView *subView = shareView;
    UIGraphicsBeginImageContextWithOptions(subView.bounds.size, YES, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [subView.layer renderInContext:context];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        [PHAssetChangeRequest creationRequestForAssetFromImage:snapshotImage];
    } completionHandler:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"Success");
            
            PHFetchOptions *fetchOptions = [PHFetchOptions new];
            fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
            PHAsset *asset = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:fetchOptions].firstObject;
            if (asset != nil) {
                // here you can use asset of your image
                if ([publisher shareViaAsset:asset]) {
                    return;
                }
            }
        }
        else {
            NSLog(@"write error : %@",error);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [publisher postImageWithImage:snapshotImage with:@"Caption this" view:self.view result:^(BOOL val) {
            }];
        });
    }];
}

- (IBAction)onFacebookShareClick:(id)sender {
    NSString * img = [self getImageToShare];
    NSURL * url = [NSURL fileURLWithPath:img];
    NSArray *activityItems = @[url];
    UIActivityViewController *activityViewControntroller = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    if ([UIDevice.currentDevice userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        activityViewControntroller.popoverPresentationController.sourceView = self.view;
        activityViewControntroller.popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/4, 0, 0);
    }
    
    [self presentViewController:activityViewControntroller animated:true completion:nil];
}

#pragma mark - Private Methods
- (void)setupUI {
    for (UILabel *monthNameLabel in monthNameLabels) {
        NSDate *date = [firstDate dateByAddingMonths:monthNameLabel.tag];
        monthNameLabel.text = [date firstLetterOfMonth];
    }
}

- (NSString *)getImageToShare {
    UIView *subView = shareView;
    UIGraphicsBeginImageContextWithOptions(subView.bounds.size, YES, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [subView.layer renderInContext:context];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"image.png"]; //Add the file name
    [UIImagePNGRepresentation(snapshotImage) writeToFile:filePath atomically:YES]; //Write the file
    
    return filePath;
}

#pragma mark - MFMailComposer Delegate Methods
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
