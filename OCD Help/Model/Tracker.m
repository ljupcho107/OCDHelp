//
//  Tracker.m
//  OCD Help
//
//  Created by RuniTDev on 9/30/22.
//

#import "Tracker.h"

@implementation Tracker

+ (NSString *)stringForMinutes:(double)minutes {
    NSNumberFormatter *fmt = [NSNumberFormatter new];
    [fmt setPositiveFormat:@"0.##"];
    [fmt setMaximumFractionDigits:2];
    [fmt setAlwaysShowsDecimalSeparator:NO];
    return [fmt stringFromNumber:[NSNumber numberWithDouble:minutes]];
}

+ (UIColor *)colorForAnxietyLevel:(NSInteger)anxietyLevel {
    switch (anxietyLevel) {
        case 0:
            return [UIColor whiteColor];
        case 1:
            return [UIColor colorWithRed:0.9426 green:1.0000 blue:0.5309 alpha:1.0000];
        case 2:
            return [UIColor colorWithRed:0.9819 green:0.8758 blue:0.5346 alpha:1.0000];
        case 3:
            return [UIColor colorWithRed:0.9210 green:0.7625 blue:0.2968 alpha:1.0000];
        case 4:
            return [UIColor colorWithRed:0.9625 green:0.7470 blue:0.1631 alpha:1.0000];
        case 5:
            return [UIColor colorWithRed:0.9557 green:0.5828 blue:0.3658 alpha:1.0000];
        case 6:
            return [UIColor colorWithRed:0.9379 green:0.3892 blue:0.1160 alpha:1.0000];
        case 7:
            return [UIColor colorWithRed:0.9822 green:0.2988 blue:0.0410 alpha:1.0000];
        case 8:
            return [UIColor colorWithRed:0.8302 green:0.1116 blue:0.1577 alpha:1.0000];
        case 9:
            return [UIColor colorWithRed:0.8711 green:0.1114 blue:0.1628 alpha:1.0000];
        case 10:
            return [UIColor colorWithRed:0.8750 green:0.0000 blue:0.0074 alpha:1.0000];
        default:
            return [UIColor whiteColor];
    }
}

+ (NSString *)textForAnxietyLevel:(NSInteger)anxietyLevel {
    switch (anxietyLevel) {
        case 0:
            return @"0 No Anxiety";
        case 1:
            return @"1 Almost No Anxiety";
        case 2:
            return @"2 Very Low Anxiety";
        case 3:
            return @"3 Low Anxiety";
        case 4:
            return @"4 Noticable Anxiety";
        case 5:
            return @"5 Bothersome Anxiety";
        case 6:
            return @"6 Medium Anxiety";
        case 7:
            return @"7 Moderate Anxiety";
        case 8:
            return @"8 Moderate-High Anxiety";
        case 9:
            return @"9 High Anxiety";
        case 10:
            return @"10 Very High Anxiety";
            
        default:
            return nil;
    }
}

+ (UIColor *)colorForStressLevel:(NSInteger)stressLevel {
    switch (stressLevel) {
        case 0:
            return [UIColor whiteColor];
        case 1:
            return [UIColor colorWithRed:0.9426 green:1.0000 blue:0.5309 alpha:1.0000];
        case 2:
            return [UIColor colorWithRed:0.9819 green:0.8758 blue:0.5346 alpha:1.0000];
        case 3:
            return [UIColor colorWithRed:0.9210 green:0.7625 blue:0.2968 alpha:1.0000];
        case 4:
            return [UIColor colorWithRed:0.9625 green:0.7470 blue:0.1631 alpha:1.0000];
        case 5:
            return [UIColor colorWithRed:0.9557 green:0.5828 blue:0.3658 alpha:1.0000];
        case 6:
            return [UIColor colorWithRed:0.9379 green:0.3892 blue:0.1160 alpha:1.0000];
        case 7:
            return [UIColor colorWithRed:0.9822 green:0.2988 blue:0.0410 alpha:1.0000];
        case 8:
            return [UIColor colorWithRed:0.8302 green:0.1116 blue:0.1577 alpha:1.0000];
        case 9:
            return [UIColor colorWithRed:0.8711 green:0.1114 blue:0.1628 alpha:1.0000];
        case 10:
            return [UIColor colorWithRed:0.8750 green:0.0000 blue:0.0074 alpha:1.0000];
        default:
            return [UIColor whiteColor];
    }
}

+ (NSString *)textForStressLevel:(NSInteger)stressLevel {
    switch (stressLevel) {
        case 0:
            return @"0 No Stress";
        case 1:
            return @"1 Almost No Stress";
        case 2:
            return @"2 Very Low Stress";
        case 3:
            return @"3 Low Stress";
        case 4:
            return @"4 Noticable Stress";
        case 5:
            return @"5 Bothersome Stress";
        case 6:
            return @"6 Medium Stress";
        case 7:
            return @"7 Moderate Stress";
        case 8:
            return @"8 Moderate-High Stress";
        case 9:
            return @"9 High Stress";
        case 10:
            return @"10 Very High Stress";
            
        default:
            return nil;
    }
}


- (NSInteger)averageAnxietyLevel {
    return round((self.anxietyLevelForWTo9 + self.anxietyLevelFor9To12 + self.anxietyLevelFor12To15 + self.anxietyLevelFor15To18 + self.anxietyLevelFor18To21 + self.anxietyLevelFor21ToM) / 6.f);
}

- (UIColor *)anxietyColorForWTo9 {
    return [Tracker colorForAnxietyLevel:self.anxietyLevelForWTo9];
}

- (UIColor *)anxietyColorFor9To12 {
    return [Tracker colorForAnxietyLevel:self.anxietyLevelFor9To12];
}

- (UIColor *)anxietyColorFor12To15 {
    return [Tracker colorForAnxietyLevel:self.anxietyLevelFor12To15];
}

- (UIColor *)anxietyColorFor15To18 {
    return [Tracker colorForAnxietyLevel:self.anxietyLevelFor15To18];
}

- (UIColor *)anxietyColorFor18To21 {
    return [Tracker colorForAnxietyLevel:self.anxietyLevelFor18To21];
}

- (UIColor *)anxietyColorFor21ToM {
    return [Tracker colorForAnxietyLevel:self.anxietyLevelFor21ToM];
}

- (NSString *)anxietyLevelTextForWTo9 {
    return [Tracker textForAnxietyLevel:self.anxietyLevelForWTo9];
}

- (NSString *)anxietyLevelTextFor9To12 {
    return [Tracker textForAnxietyLevel:self.anxietyLevelFor9To12];
}

- (NSString *)anxietyLevelTextFor12To15 {
    return [Tracker textForAnxietyLevel:self.anxietyLevelFor12To15];
}

- (NSString *)anxietyLevelTextFor15To18 {
    return [Tracker textForAnxietyLevel:self.anxietyLevelFor15To18];
}

- (NSString *)anxietyLevelTextFor18To21 {
    return [Tracker textForAnxietyLevel:self.anxietyLevelFor18To21];
}

- (NSString *)anxietyLevelTextFor21ToM {
    return [Tracker textForAnxietyLevel:self.anxietyLevelFor21ToM];
}

- (NSInteger)averageStressLevel {
    return round((self.stressLevelForWTo9 + self.stressLevelFor9To12 + self.stressLevelFor12To15 + self.stressLevelFor15To18 + self.stressLevelFor18To21 + self.stressLevelFor21ToM) / 6.f);
}

- (UIColor *)stressColorForWTo9 {
    return [Tracker colorForStressLevel:self.stressLevelForWTo9];
}

- (UIColor *)stressColorFor9To12 {
    return [Tracker colorForStressLevel:self.stressLevelFor9To12];
}

- (UIColor *)stressColorFor12To15 {
    return [Tracker colorForStressLevel:self.stressLevelFor12To15];
}

- (UIColor *)stressColorFor15To18 {
    return [Tracker colorForStressLevel:self.stressLevelFor15To18];
}

- (UIColor *)stressColorFor18To21 {
    return [Tracker colorForStressLevel:self.stressLevelFor18To21];
}

- (UIColor *)stressColorFor21ToM {
    return [Tracker colorForStressLevel:self.stressLevelFor21ToM];
}

- (NSString *)stressLevelTextForWTo9 {
    return [Tracker textForStressLevel:self.stressLevelForWTo9];
}

- (NSString *)stressLevelTextFor9To12 {
    return [Tracker textForStressLevel:self.stressLevelFor9To12];
}

- (NSString *)stressLevelTextFor12To15 {
    return [Tracker textForStressLevel:self.stressLevelFor12To15];
}

- (NSString *)stressLevelTextFor15To18 {
    return [Tracker textForStressLevel:self.stressLevelFor15To18];
}

- (NSString *)stressLevelTextFor18To21 {
    return [Tracker textForStressLevel:self.stressLevelFor18To21];
}

- (NSString *)stressLevelTextFor21ToM {
    return [Tracker textForStressLevel:self.stressLevelFor21ToM];
}

- (double)totalRuminanceMinutes {
    return self.ruminationMinsForWTo9 + self.ruminationMinsFor9To12 + self.ruminationMinsFor12To15 + self.ruminationMinsFor15To18 + self.ruminationMinsFor18To21 + self.ruminationMinsFor21ToM;
}

- (double)totalCompulsionsMinutes {
    return self.compulsionsMinsForWTo9 + self.compulsionsMinsFor9To12 + self.compulsionsMinsFor12To15 + self.compulsionsMinsFor15To18 + self.compulsionsMinsFor18To21 + self.compulsionsMinsFor21ToM;
}

- (double)totalAvoidancesMinutes {
    return self.avoidancesMinsForWTo9 + self.avoidancesMinsFor9To12 + self.avoidancesMinsFor12To15 + self.avoidancesMinsFor15To18 + self.avoidancesMinsFor18To21 + self.avoidancesMinsFor21ToM;
}

@end
