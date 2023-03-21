//
//  OcdTestVC.m
//  OCD Help
//
//  Created by RuniTDev on 9/25/22.
//

#import "OcdTestVC.h"

@interface OcdTestVC () {
    int selectedAnswersCount;
}

@end

@implementation OcdTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - Private Methods
- (void)setupUI {

}

#pragma mark - Actions
- (IBAction)onQuestionButtonClick:(UIButton *)button {
    selectedAnswersCount++;
    [button setAlpha:0];
}

- (IBAction)onResetButtonClick:(id)sender;{
    selectedAnswersCount = 0;
    
    resultLabel.text = @"";
    
    for (UIButton * btn in questionButtons) {
        [btn setAlpha:1];
    }
}

- (IBAction)onResultButtonClick:(id)sender {
    if (selectedAnswersCount < 3) {
        resultLabel.text = @"THIS IS NOT AN OCD THOUGHT";
    } else {
        resultLabel.text = @"THIS IS AN OCD THOUGHT";
    }
}

@end
