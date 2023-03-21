//
//  Tracker.h
//  OCD Help
//
//  Created by RuniTDev on 9/30/22.
//

#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN

@interface Tracker : RLMObject

@property NSString *dateString;

@property double ruminationMinsForWTo9;
@property double ruminationMinsFor9To12;
@property double ruminationMinsFor12To15;
@property double ruminationMinsFor15To18;
@property double ruminationMinsFor18To21;
@property double ruminationMinsFor21ToM;

@property double compulsionsMinsForWTo9;
@property double compulsionsMinsFor9To12;
@property double compulsionsMinsFor12To15;
@property double compulsionsMinsFor15To18;
@property double compulsionsMinsFor18To21;
@property double compulsionsMinsFor21ToM;

@property double avoidancesMinsForWTo9;
@property double avoidancesMinsFor9To12;
@property double avoidancesMinsFor12To15;
@property double avoidancesMinsFor15To18;
@property double avoidancesMinsFor18To21;
@property double avoidancesMinsFor21ToM;

@property NSInteger anxietyLevelForWTo9;
@property NSInteger anxietyLevelFor9To12;
@property NSInteger anxietyLevelFor12To15;
@property NSInteger anxietyLevelFor15To18;
@property NSInteger anxietyLevelFor18To21;
@property NSInteger anxietyLevelFor21ToM;

@property NSInteger stressLevelForWTo9;
@property NSInteger stressLevelFor9To12;
@property NSInteger stressLevelFor12To15;
@property NSInteger stressLevelFor15To18;
@property NSInteger stressLevelFor18To21;
@property NSInteger stressLevelFor21ToM;

@property NSString *notes;

+ (NSString *)stringForMinutes:(double)minutes;
+ (UIColor *)colorForAnxietyLevel:(NSInteger)anxietyLevel;
+ (NSString *)textForAnxietyLevel:(NSInteger)anxietyLevel;
+ (UIColor *)colorForStressLevel:(NSInteger)stressLevel;
+ (NSString *)textForStressLevel:(NSInteger)stressLevel;

- (NSInteger)averageAnxietyLevel;
- (NSInteger)averageStressLevel;

- (UIColor *)anxietyColorForWTo9;
- (UIColor *)anxietyColorFor9To12;
- (UIColor *)anxietyColorFor12To15;
- (UIColor *)anxietyColorFor15To18;
- (UIColor *)anxietyColorFor18To21;
- (UIColor *)anxietyColorFor21ToM;

- (UIColor *)stressColorForWTo9;
- (UIColor *)stressColorFor9To12;
- (UIColor *)stressColorFor12To15;
- (UIColor *)stressColorFor15To18;
- (UIColor *)stressColorFor18To21;
- (UIColor *)stressColorFor21ToM;

- (NSString *)anxietyLevelTextForWTo9;
- (NSString *)anxietyLevelTextFor9To12;
- (NSString *)anxietyLevelTextFor12To15;
- (NSString *)anxietyLevelTextFor15To18;
- (NSString *)anxietyLevelTextFor18To21;
- (NSString *)anxietyLevelTextFor21ToM;

- (NSString *)stressLevelTextForWTo9;
- (NSString *)stressLevelTextFor9To12;
- (NSString *)stressLevelTextFor12To15;
- (NSString *)stressLevelTextFor15To18;
- (NSString *)stressLevelTextFor18To21;
- (NSString *)stressLevelTextFor21ToM;

- (double)totalRuminanceMinutes;
- (double)totalCompulsionsMinutes;
- (double)totalAvoidancesMinutes;
@end

NS_ASSUME_NONNULL_END
