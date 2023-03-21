//
//  SubscriptionVC.m
//  OCD Help
//
//  Created by RuniTDev on 9/26/22.
//

#import "SubscriptionVC.h"
#import "RMStore.h"
#import "RMStoreKeychainPersistence.h"
#import "AppDelegate.h"
#import "UIAlertController+Blocks.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface SubscriptionVC () {
    BOOL _productsRequestFinished;
    RMStoreKeychainPersistence *_persistence;
}

@property (weak, nonatomic) IBOutlet UIButton *subscribeButton;
@property (weak, nonatomic) IBOutlet UILabel *pricingLabel;

@end

@implementation SubscriptionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadProducts];
}

#pragma mark - Actions
- (IBAction)onRestorePurchaseButtonClick:(id)sender {
    if (!_productsRequestFinished) {
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[RMStore defaultStore] restoreTransactionsOnSuccess:^(NSArray *transactions) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self displaySubscriptionInfo];
            [self checkSubscription];
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

- (IBAction)onSubscribeButtonClick:(id)sender {
    if (!_productsRequestFinished) {
        return;
    }
    
#if DEBUG
    [self dismissSubscriptionView];
#else
    if ([_persistence isPurchasedProductOfIdentifier:SUBSCRIPTION_PRODUCT_ID]) {
        [self dismissSubscriptionView];
    } else {
        [self purchaseProduct:SUBSCRIPTION_PRODUCT_ID success:^{
            [self dismissSubscriptionView];
        }];
    }
#endif
}

#pragma mark - Private Methods
- (void)loadProducts {
    RMStore *store = [RMStore defaultStore];
    _persistence = store.transactionPersistor;
    
    NSArray *_products = @[SUBSCRIPTION_PRODUCT_ID];
    
    [store requestProducts:[NSSet setWithArray:_products] success:^(NSArray *products, NSArray *invalidProductIdentifiers) {
        self->_productsRequestFinished = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self displaySubscriptionInfo];
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
            
            [self displaySubscriptionInfo];
            
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

- (void)displaySubscriptionInfo {
    RMStore *store = [RMStore defaultStore];
    SKProduct *product = [store productForIdentifier:SUBSCRIPTION_PRODUCT_ID];
    if (product != nil) {
        NSNumberFormatter * nf = [NSNumberFormatter new];
        nf.locale = product.priceLocale;
        [nf setNumberStyle:NSNumberFormatterCurrencyStyle];
        self.pricingLabel.text = [NSString stringWithFormat:@"Only %@ monthly",[nf stringFromNumber:product.price]];
    }
}

- (void)checkSubscription {
    if ([_persistence isPurchasedProductOfIdentifier:SUBSCRIPTION_PRODUCT_ID]) {
        [self dismissSubscriptionView];
    }
}

- (void)dismissSubscriptionView {
    [self dismissViewControllerAnimated:false completion:^{
        if ([self.delegate respondsToSelector:@selector(onSubscriptionDismissed)]) {
            [self.delegate onSubscriptionDismissed];
        }
    }];
}

@end
