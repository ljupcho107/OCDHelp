//
//  SettingsManager.h
//  OCD Help
//
//  Created by RuniTDev on 9/27/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum
{
    HabitStatusNone = 0,
    HabitStatusYes = 1,
    HabitStatusNo = 2
} HabitStatus;

@interface SettingsManager : NSObject

+ (SettingsManager*)shared;

- (BOOL)isAgreedTerms;
- (void)setIsAgreedTerms:(BOOL)value;
- (void)resetExerciseDataAtPosition:(NSInteger)position;
- (NSString *)exerciseTitleAtPosition:(NSInteger)position;
- (void)setExerciseTitle:(NSString *)title atPostion:(NSInteger)position;
- (HabitStatus)exerciseHabitStatus:(NSInteger)exercisePosition habitPosition:(NSInteger)habitPosition;
- (void)setExerciseHabitStatus:(NSInteger)exercisePosition habitPosition:(NSInteger)habitPosition habitStatus:(HabitStatus)habitStatus;

@end

NS_ASSUME_NONNULL_END
