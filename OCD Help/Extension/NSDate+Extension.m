//
//  NSDate+Extension.m
//  OCD Help
//
//  Created by RuniTDev on 9/30/22.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

+ (NSDate *)dateFromString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    return [dateFormatter dateFromString:dateString];
}

- (NSString *)dateStringValue {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    return [dateFormatter stringFromDate:self];
}

- (NSString *)monthAndDayStringValue {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"MMM d";
    return [dateFormatter stringFromDate:self];
}

- (NSString *)yearString {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy";
    return [dateFormatter stringFromDate:self];
}

- (NSString *)dayString {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"d";
    return [dateFormatter stringFromDate:self];
}

- (NSString *)firstLetterOfMonth {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"MMM";
    return [[dateFormatter stringFromDate:self] substringToIndex:1];
}

- (NSDate *)dateByAddingDays:(NSInteger)days {
    return [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitDay value:days toDate:self options:0];
}

- (NSDate *)dateByAddingMonths:(NSInteger)months {
    return [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitMonth value:months toDate:self options:0];
}

- (NSDate *)firstDateOfMonth {
    NSCalendar *calendar = NSCalendar.currentCalendar;
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    [components setValue:1 forComponent:NSCalendarUnitDay];
    return [calendar dateFromComponents:components];
}

- (NSInteger)numberOfDaysOfMonth {
    NSCalendar *calendar = NSCalendar.currentCalendar;
    NSRange dayRange = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return dayRange.length;
}

@end
