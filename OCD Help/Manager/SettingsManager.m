//
//  SettingsManager.m
//  OCD Help
//
//  Created by RuniTDev on 9/27/22.
//

#import "SettingsManager.h"

#define keyIsAgreedTerms @"isAgreedTerms"

@implementation SettingsManager

+ (SettingsManager *)shared
{
    static SettingsManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

- (BOOL)isAgreedTerms {
#if DEBUG
    return false;
#else
    return [[NSUserDefaults standardUserDefaults] boolForKey:keyIsAgreedTerms];
#endif
}

- (void)setIsAgreedTerms:(BOOL)value {
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:keyIsAgreedTerms];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)resetExerciseDataAtPosition:(NSInteger)position {
    NSString *key = [NSString stringWithFormat:@"savedstringlb%ld", position + 1];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    
    for (NSInteger i = 1; i <= 12; i++) {
        key = [NSString stringWithFormat:@"habitStatus_%ld_%ld", position + 1, i];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
}

- (NSString *)exerciseTitleAtPosition:(NSInteger)position {
    NSString *key = [NSString stringWithFormat:@"savedstringlb%ld", position + 1];
    return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}

- (void)setExerciseTitle:(NSString *)title atPostion:(NSInteger)position {
    NSString *key = [NSString stringWithFormat:@"savedstringlb%ld", position + 1];
    [[NSUserDefaults standardUserDefaults] setObject:title forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (HabitStatus)exerciseHabitStatus:(NSInteger)exercisePosition habitPosition:(NSInteger)habitPosition {
    NSString *key = [NSString stringWithFormat:@"habitStatus_%ld_%ld", exercisePosition + 1, habitPosition + 1];
    NSInteger habitStatus = [[NSUserDefaults standardUserDefaults] integerForKey:key];
    switch (habitStatus) {
        case 1:
            return HabitStatusYes;
        case 2:
            return HabitStatusNo;
        default:
            return HabitStatusNone;
    }
}

- (void)setExerciseHabitStatus:(NSInteger)exercisePosition habitPosition:(NSInteger)habitPosition habitStatus:(HabitStatus)habitStatus {
    NSString *key = [NSString stringWithFormat:@"habitStatus_%ld_%ld", exercisePosition + 1, habitPosition + 1];
    [[NSUserDefaults standardUserDefaults] setInteger:habitStatus forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
