//
//  BooksVC.m
//  OCD Help
//
//  Created by RuniTDev on 9/26/22.
//

#import "BooksVC.h"
#import "BookVC.h"
#import "BookCell.h"
#import "Book.h"
#import "UIAlertController+Blocks.h"
#import "RMStore.h"
#import "RMStoreKeychainPersistence.h"
#import "UIViewController+Extension.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface BooksVC () <UICollectionViewDelegate, UICollectionViewDataSource> {
    NSMutableArray *books;

    BOOL _productsRequestFinished;
    RMStoreKeychainPersistence *_persistence;
}

@end

@implementation BooksVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    books = [NSMutableArray new];
    [books addObject:[[Book alloc]
                      initWithProductID:@"0001"
                      thumbImageName:@"1-FalseMemoryOcdRecovery"
                      pdfFileName:@"1-FalseMemoryOcdRecovery"
                      pdfFileNameForIpad:@"1-FalseMemoryOcdRecovery@iPad"
                     ]];
    [books addObject:[[Book alloc]
                      initWithProductID:@"0002"
                      thumbImageName:@"2-HowToGetOverOcd"
                      pdfFileName:@"2-HowToGetOverOcd"
                      pdfFileNameForIpad:@"2-HowToGetOverOcd@iPad"
                     ]];
    [books addObject:[[Book alloc]
                      initWithProductID:@"3-ReligiousOcdRecovery0003"
                      thumbImageName:@"3-ReligiousOcdRecovery"
                      pdfFileName:@"3-ReligiousOcdRecovery"
                      pdfFileNameForIpad:@"3-ReligiousOcdRecovery@iPad"
                     ]];
    [books addObject:[[Book alloc]
                      initWithProductID:@"0004"
                      thumbImageName:@"4-OcdRecoveryUsingMindfulness"
                      pdfFileName:@"4-OcdRecoveryUsingMindfulness"
                      pdfFileNameForIpad:@"4-OcdRecoveryUsingMindfulness@iPad"
                     ]];
    [books addObject:[[Book alloc]
                      initWithProductID:@"0005"
                      thumbImageName:@"5-CheatingOcdRecovery"
                      pdfFileName:@"5-CheatingOcdRecovery"
                      pdfFileNameForIpad:@"5-CheatingOcdRecovery@iPad"
                     ]];
    [books addObject:[[Book alloc]
                      initWithProductID:@"0006"
                      thumbImageName:@"6-FaqAboutOcd"
                      pdfFileName:@"6-FaqAboutOcd"
                      pdfFileNameForIpad:@"6-FaqAboutOcd@iPad"
                     ]];
    [books addObject:[[Book alloc]
                      initWithProductID:@"0007"
                      thumbImageName:@"7-HelpYourChildGetOverOcd"
                      pdfFileName:@"7-HelpYourChildGetOverOcd"
                      pdfFileNameForIpad:@"7-HelpYourChildGetOverOcd@iPad"
                     ]];
    [books addObject:[[Book alloc]
                      initWithProductID:@"0008"
                      thumbImageName:@"8-NutritionLifeStyleAndOcdRecovery"
                      pdfFileName:@"8-NutritionLifeStyleAndOcdRecovery"
                      pdfFileNameForIpad:@"8-NutritionLifeStyleAndOcdRecovery@iPad"
                     ]];
    [books addObject:[[Book alloc]
                      initWithProductID:@"0009"
                      thumbImageName:@"9-ErpForOcdRecovery"
                      pdfFileName:@"9-ErpForOcdRecovery"
                      pdfFileNameForIpad:@"9-ErpForOcdRecovery@iPad"
                     ]];
    [books addObject:[[Book alloc]
                      initWithProductID:@"0010"
                      thumbImageName:@"10-HarmOcdRecovery"
                      pdfFileName:@"10-HarmOcdRecovery"
                      pdfFileNameForIpad:@"10-HarmOcdRecovery@iPad"
                     ]];
    [books addObject:[[Book alloc]
                      initWithProductID:@"0011"
                      thumbImageName:@"11-GettingOverOcd"
                      pdfFileName:@"11-GettingOverOcd"
                      pdfFileNameForIpad:@"11-GettingOverOcd@iPad"
                     ]];
    [books addObject:[[Book alloc]
                      initWithProductID:@"0012"
                      thumbImageName:@"12-OcdSelfHelpWorkbook"
                      pdfFileName:@"12-OcdSelfHelpWorkbook"
                      pdfFileNameForIpad:@"12-OcdSelfHelpWorkbook@iPad"
                     ]];
    [books addObject:[[Book alloc]
                      initWithProductID:@"0013"
                      thumbImageName:@"13-OcdRecoveryUsingCbt"
                      pdfFileName:@"13-OcdRecoveryUsingCbt"
                      pdfFileNameForIpad:@"13-OcdRecoveryUsingCbt@iPad"
                     ]];
    [books addObject:[[Book alloc]
                      initWithProductID:@"0014"
                      thumbImageName:@"14-RelationshipOcdRecoverySolution"
                      pdfFileName:@"14-RelationshipOcdRecoverySolution"
                      pdfFileNameForIpad:@"14-RelationshipOcdRecoverySolution@iPad"
                     ]];
    [books addObject:[[Book alloc]
                      initWithProductID:@"0015"
                      thumbImageName:@"15-OvercomingOcdCompulsions"
                      pdfFileName:@"15-OvercomingOcdCompulsions"
                      pdfFileNameForIpad:@"15-OvercomingOcdCompulsions"
                     ]];
    [books addObject:[[Book alloc]
                      initWithProductID:@"0016"
                      thumbImageName:@"16-PureOOcdRecovery"
                      pdfFileName:@"16-PureOOcdRecovery"
                      pdfFileNameForIpad:@"16-PureOOcdRecovery@iPad"
                     ]];
    [books addObject:[[Book alloc]
                      initWithProductID:@"001"
                      thumbImageName:@"5-CheatingOcdRecovery"
                      mp3FileName:@"1-CheatingOcdRecovery"
                     ]];
    [books addObject:[[Book alloc]
                      initWithProductID:@"002"
                      thumbImageName:@"1-FalseMemoryOcdRecovery"
                      mp3FileName:@"2-FalseMemoryOcdRecovery"
                     ]];
    [books addObject:[[Book alloc]
                      initWithProductID:@"003"
                      thumbImageName:@"3-FastOcdRecovery"
                      mp3FileName:@"3-FastOcdRecovery"
                     ]];
    [books addObject:[[Book alloc]
                      initWithProductID:@"004"
                      thumbImageName:@"2-HowToGetOverOcd"
                      mp3FileName:@"4-HowToGetOverOcd"
                     ]];
    [books addObject:[[Book alloc]
                      initWithProductID:@"005"
                      thumbImageName:@"7-HelpYourChildGetOverOcd"
                      mp3FileName:@"5-HelpYourChildGetOverOcd"
                     ]];
    [books addObject:[[Book alloc]
                      initWithProductID:@"006"
                      thumbImageName:@"8-NutritionLifeStyleAndOcdRecovery"
                      mp3FileName:@"6-NutritionLifeStyleAndOcdRecovery"
                     ]];
    [books addObject:[[Book alloc]
                      initWithProductID:@"007"
                      thumbImageName:@"16-PureOOcdRecovery"
                      mp3FileName:@"7-PureOOcdRecovery"
                     ]];
    [books addObject:[[Book alloc]
                      initWithProductID:@"008"
                      thumbImageName:@"14-RelationshipOcdRecoverySolution"
                      mp3FileName:@"8-RelationshipOcdRecoverySolution"
                     ]];
    [self loadProducts];
}

#pragma mark - Actions
- (IBAction)onRestorePurchaseClick:(id)sender {
    if (!_productsRequestFinished) {
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[RMStore defaultStore] restoreTransactionsOnSuccess:^(NSArray *transactions) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self->collectionView reloadData];
        });
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [UIAlertController showAlertInViewController:self
                                               withTitle:NSLocalizedString(@"Restore Transactions Failed", @"")
                                                 message:error.localizedDescription
                                       cancelButtonTitle:NSLocalizedString(@"OK", @"")
                                  destructiveButtonTitle:nil
                                       otherButtonTitles:nil
                                                tapBlock:nil];
        });
    }];
}

#pragma mark - UICollectionView Delegate Methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *) collectionView.collectionViewLayout;
    CGFloat width = (collectionView.frame.size.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right) / 4.f;
    return CGSizeMake(width, width * 171.f / 100.f);
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return books.count;
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    Book *book = [books objectAtIndex:indexPath.row];
    BookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.book = book;
    
    if ([_persistence isPurchasedProductOfIdentifier:book.productID]) {
        cell.buyBadgeView.hidden = true;
    } else {
        cell.buyBadgeView.hidden = false;
    }
    
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (!_productsRequestFinished) {
        return;
    }
    
    Book *book = [books objectAtIndex:indexPath.row];
    
    if ([_persistence isPurchasedProductOfIdentifier:book.productID]) {
        [self showBook:book];
    } else {
        [self purchaseProduct:book.productID success:^{
            [self showBook:book];
        }];
    }
}

#pragma mark - Private Methods
- (void)showBook:(Book *)book {
    if (book.mp3FileName != nil) {
        [self playAudioWithFilename:book.mp3FileName];
    } else {
        BookVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BookVC"];
        vc.title = @"";
        
        if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            vc.pdfFileName = book.pdfFileNameForIpad;
        } else {
            vc.pdfFileName = book.pdfFileName;
        }
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)loadProducts {
    RMStore *store = [RMStore defaultStore];
    _persistence = store.transactionPersistor;
    
    NSMutableArray *_products = [NSMutableArray new];
    for (Book *book in books) {
        [_products addObject:book.productID];
    }
    
    [store requestProducts:[NSSet setWithArray:_products] success:^(NSArray *products, NSArray *invalidProductIdentifiers) {
        self->_productsRequestFinished = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->collectionView reloadData];
        });
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIAlertController showAlertInViewController:self
                                               withTitle:NSLocalizedString(@"Products Request Failed", @"")
                                                 message:error.localizedDescription
                                       cancelButtonTitle:NSLocalizedString(@"OK", @"")
                                  destructiveButtonTitle:nil
                                       otherButtonTitles:nil
                                                tapBlock:nil];
        });
    }];
}

- (void)purchaseProduct:(NSString *)productID success:(void (^)(void))successBlock {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[RMStore defaultStore] addPayment:productID success:^(SKPaymentTransaction *transaction) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            [self->collectionView reloadData];
            
            successBlock();
        });
    } failure:^(SKPaymentTransaction *transaction, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [UIAlertController showAlertInViewController:self
                                               withTitle:NSLocalizedString(@"Payment Transaction Failed", @"")
                                                 message:error.localizedDescription
                                       cancelButtonTitle:NSLocalizedString(@"OK", @"")
                                  destructiveButtonTitle:nil
                                       otherButtonTitles:nil
                                                tapBlock:nil];
        });
    }];
}

@end
