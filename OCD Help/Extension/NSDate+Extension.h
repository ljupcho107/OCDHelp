//
//  NSDate+Extension.h
//  OCD Help
//
//  Created by RuniTDev on 9/30/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Extension)

+ (NSDate *)dateFromString:(NSString *)dateString;

- (NSString *)dateStringValue;
- (NSString *)monthAndDayStringValue;
- (NSString *)yearString;
- (NSString *)dayString;
- (NSString *)firstLetterOfMonth;
- (NSDate *)dateByAddingDays:(NSInteger)days;
- (NSDate *)dateByAddingMonths:(NSInteger)months;
- (NSDate *)firstDateOfMonth;
- (NSInteger)numberOfDaysOfMonth;

@end

NS_ASSUME_NONNULL_END
