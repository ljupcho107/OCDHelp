//
//  HomeVC.m
//  OCD Help
//
//  Created by RuniTDev on 9/25/22.
//

#import "HomeVC.h"
#import "OcdTestVC.h"
#import "QuotesVC.h"
#import "BooksVC.h"
#import "TrackerVC.h"
#import "YearVC.h"
#import "ProgressVC.h"
#import "DailyExercisesVC.h"
#import "SubscriptionVC.h"
#import "AgreeTermVC.h"
#import "InstructionsVC.h"
#import "RMStore.h"
#import "RMStoreKeychainPersistence.h"
#import "AppDelegate.h"
#import "UIAlertController+Blocks.h"
#import "SettingsManager.h"
#import "UIViewController+Extension.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "DatabaseMigrator.h"

@interface HomeVC () <SubscriptionVCDelegate, AgreeTermVCDelegate> {
    BOOL _productsRequestFinished;
    RMStoreKeychainPersistence *_persistence;
}

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self migrateDatabase];
    
#if DEBUG
    _productsRequestFinished = YES;
    [self showSubscriptionView];
#endif
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

#if DEBUG
#else
    [self loadProducts];
#endif
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    stackView.spacing = stackView.frame.size.height / 620.f * 8.f;
}

#pragma mark - Actions
- (IBAction)onForumClick:(id)sender {
    if (!_productsRequestFinished) {
        return;
    }
    
    [self showWebViewWithTitle:@"FORUM" url:@"https://youhaveocd.com/forum-for-app/"];
}

- (IBAction)onTermsAndPrivacyClick:(id)sender {
    if (!_productsRequestFinished) {
        return;
    }
    
    [self showWebViewWithTitle:@"TERMS & PRIVACY" url:@"https://youhaveocd.com/news/"];
}

- (IBAction)onOcdTestClick:(id)sender {
    if (!_productsRequestFinished) {
        return;
    }
    
    [self showOcdTest];
}

- (IBAction)onQuotesClick:(id)sender {
    if (!_productsRequestFinished) {
        return;
    }
    
    [self showQuotes];
}

- (IBAction)onBooksClick:(id)sender {
    if (!_productsRequestFinished) {
        return;
    }
    
    [self showBooks];
}

- (IBAction)onTrackerClick:(id)sender {
    if (!_productsRequestFinished) {
        return;
    }
    
    [self showTracker];
}

- (IBAction)onYearClick:(id)sender {
    if (!_productsRequestFinished) {
        return;
    }
    
    [self showYear];
}

- (IBAction)onProgressClick:(id)sender {
    if (!_productsRequestFinished) {
        return;
    }
    
    [self showProgress];
}

- (IBAction)onDailyExerciesClick:(id)sender {
    if (!_productsRequestFinished) {
        return;
    }
    
    [self showDailyExercises];
}

#pragma mark - SubscriptionVC Delegate Methods
- (void)onSubscriptionDismissed {
    if ([[SettingsManager shared] isAgreedTerms]) {
        [self showInstructionsVC];
    } else {
        [self showAgreeTermView];
    }
}

#pragma mark - AgreeTermVC Delegate Methods
- (void)onAgreeTermDismissed {
    [self showInstructionsVC];
}

#pragma mark - Private Methods
- (void)migrateDatabase {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [DatabaseMigrator migrate];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}

- (void)showSubscriptionView {
    SubscriptionVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SubscriptionVC"];
    vc.delegate = self;
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:vc animated:false completion:nil];
}

- (void)showAgreeTermView {
    AgreeTermVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AgreeTermVC"];
    vc.delegate = self;
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:true completion:nil];
}

- (void)showInstructionsVC {
    InstructionsVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"InstructionsVC"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
    vc.title = @"IMPORTANT INSTRUCTIONS";
    
    [self presentViewController:navigationController animated:true completion:nil];
}

- (void)showOcdTest {
    OcdTestVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"OcdTestVC"];
    vc.title = @"";
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showQuotes {
    QuotesVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"QuotesVC"];
    vc.title = @"QUOTES";
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showBooks {
    BooksVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BooksVC"];
    vc.title = @"BOOKS AN AUDIO BOOKS";
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showTracker {
    TrackerVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TrackerVC"];
    vc.title = @"OCD RECOVERY TRACKER";
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showYear {
    YearVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"YearVC"];
    vc.title = @"MY RECOVERY YEAR";
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showProgress {
    ProgressVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProgressVC"];
    vc.title = @"MY RECOVERY PROGRESS";
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showDailyExercises {
    DailyExercisesVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DailyExercisesVC"];
    vc.title = @"DAILY ERP EXERCISE";
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadProducts {
    RMStore *store = [RMStore defaultStore];
    _persistence = store.transactionPersistor;
    
    NSArray *_products = @[SUBSCRIPTION_PRODUCT_ID];
    
    [store requestProducts:[NSSet setWithArray:_products] success:^(NSArray *products, NSArray *invalidProductIdentifiers) {
        self->_productsRequestFinished = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self checkSubscription];
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

- (void)checkSubscription {
    if (![_persistence isPurchasedProductOfIdentifier:SUBSCRIPTION_PRODUCT_ID]) {
        [self showSubscriptionView];
    } else if (![[SettingsManager shared] isAgreedTerms]) {
        [self showAgreeTermView];
    }
}


@end
