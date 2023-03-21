//
//  UIViewController+Extension.m
//  OCD Help
//
//  Created by RuniTDev on 9/29/22.
//

#import "UIViewController+Extension.h"
#import "WebVC.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface UIViewController (Extension)

@end

@implementation UIViewController (Extension)

- (void)showWebViewWithTitle:(NSString *)title url:(NSString *)url {
    WebVC *webVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WebVC"];
    webVC.urlString = url;
    webVC.title = title;
    
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)playAudioWithFilename:(NSString *)filename {
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:filename ofType:@"mp3"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    AVPlayer *player = [[AVPlayer alloc] initWithURL:soundFileURL];
    AVPlayerViewController *controller = [[AVPlayerViewController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
    controller.player = player;
    [player play];
}

@end
