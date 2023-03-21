//
//  QuotesVC.m
//  OCD Help
//
//  Created by RuniTDev on 9/25/22.
//

#import "QuotesVC.h"

#define quoteImageNames @[@"quote1", @"quote2", @"quote3", @"quote4", @"quote5", @"quote6", @"quote7", @"quote8", @"quote9"]

@interface QuotesVC ()

@end

@implementation QuotesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    currentQuotePosition = 0;
    [self displayCurrentQuoteImage];
}

#pragma mark - Actions
- (IBAction)onPrevButtonClick:(UIButton *)button {
    if (currentQuotePosition == 0) {
        currentQuotePosition = quoteImageNames.count - 1;
    } else {
        currentQuotePosition--;
    }
    
    [self displayCurrentQuoteImage];
}

- (IBAction)onNextButtonClick:(UIButton *)button {
    if (currentQuotePosition == quoteImageNames.count - 1) {
        currentQuotePosition = 0;
    } else {
        currentQuotePosition++;
    }
    
    [self displayCurrentQuoteImage];
}

#pragma mark - Private Methods
- (void)displayCurrentQuoteImage {
    quoteImageView.image = [UIImage imageNamed:[quoteImageNames objectAtIndex:currentQuotePosition]];
}

@end
