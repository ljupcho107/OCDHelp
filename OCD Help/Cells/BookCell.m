//
//  BookCell.m
//  OCD Help
//
//  Created by RuniTDev on 9/26/22.
//

#import "BookCell.h"
@import SwifterSwift;

@implementation BookCell

- (void)layoutIfNeeded {
    [super layoutIfNeeded];
    
    self.buyBadgeView.layerCornerRadius = self.buyBadgeView.bounds.size.width / 2;
    self.buyBadgeLabel.font = [self.buyBadgeLabel.font fontWithSize:self.bounds.size.width / 11];
    self.audioBadgeView.layerCornerRadius = self.audioBadgeView.bounds.size.width / 2;
}

- (void)setBook:(Book *)book {
    _book = book;
    [self.thumbImageView setImage:[UIImage imageNamed:book.thumbImageName]];
    
    self.audioBadgeView.hidden = book.mp3FileName == nil;
}

@end
