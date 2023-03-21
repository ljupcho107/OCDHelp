//
//  Book.h
//  OCD Help
//
//  Created by RuniTDev on 9/25/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Book : NSObject

@property NSString *productID;
@property NSString *thumbImageName;
@property NSString *pdfFileName;
@property NSString *pdfFileNameForIpad;
@property NSString *mp3FileName;

- (id)initWithProductID:(NSString *)productID thumbImageName:(NSString *)thumbImageName pdfFileName:(NSString *)pdfFileName pdfFileNameForIpad:(NSString *)pdfFileNameForIpad;

- (id)initWithProductID:(NSString *)productID thumbImageName:(NSString *)thumbImageName mp3FileName:(NSString *)mp3FileName;

@end

NS_ASSUME_NONNULL_END
