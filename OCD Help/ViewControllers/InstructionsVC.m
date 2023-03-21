//
//  InstructionsVC.m
//  OCD Help
//
//  Created by RuniTDev on 9/26/22.
//

#import "InstructionsVC.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface InstructionsVC ()

@end

@implementation InstructionsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Actions
- (IBAction)onVideoButtonClick:(id)sender {
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"instructions2" ofType:@"mp4"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    AVPlayer *player = [[AVPlayer alloc] initWithURL:soundFileURL];
    AVPlayerViewController *controller = [[AVPlayerViewController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
    controller.player = player;
    [player play];    
}

- (IBAction)onUnderstandButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
