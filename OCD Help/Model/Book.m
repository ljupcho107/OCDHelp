//
//  Book.m
//  OCD Help
//
//  Created by RuniTDev on 9/25/22.
//

#import "Book.h"

@implementation Book

- (id)initWithProductID:(NSString *)productID thumbImageName:(NSString *)thumbImageName pdfFileName:(NSString *)pdfFileName pdfFileNameForIpad:(NSString *)pdfFileNameForIpad {
    self = [super init];
    self.productID = productID;
    self.thumbImageName = thumbImageName;
    self.pdfFileName = pdfFileName;
    self.pdfFileNameForIpad = pdfFileNameForIpad;
    return self;
}

- (id)initWithProductID:(NSString *)productID thumbImageName:(NSString *)thumbImageName mp3FileName:(NSString *)mp3FileName {
    self = [super init];
    self.productID = productID;
    self.thumbImageName = thumbImageName;
    self.mp3FileName = mp3FileName;
    return self;
}

@end
