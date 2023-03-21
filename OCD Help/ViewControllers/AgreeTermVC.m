//
//  AgreeTermVC.m
//  OCD Help
//
//  Created by RuniTDev on 9/26/22.
//

#import "AgreeTermVC.h"
#import "SettingsManager.h"

@interface AgreeTermVC ()

@end

@implementation AgreeTermVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Actions
- (IBAction)onAgreeButtonClick:(id)sender {
    [[SettingsManager shared] setIsAgreedTerms:YES];
    
    [self dismissViewControllerAnimated:true completion:^{
        if ([self.delegate respondsToSelector:@selector(onAgreeTermDismissed)]) {
            [self.delegate onAgreeTermDismissed];
        }
    }];
}

- (IBAction)onDisagreeButtonClick:(id)sender {
    exit(0);
}

@end
