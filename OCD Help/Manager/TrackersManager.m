//
//  TrackersManager.m
//  OCD Help
//
//  Created by RuniTDev on 9/30/22.
//

#import "TrackersManager.h"
#import "NSDate+Extension.h"

@implementation TrackersManager

+ (TrackersManager *)shared
{
    static TrackersManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

- (RLMResults *)allTrackersForRumination {
    NSString *whereAnxiety = @"anxietyLevelForWTo9 >= 0 OR anxietyLevelFor9To12 >= 0 OR anxietyLevelFor12To15 >= 0 OR anxietyLevelFor15To18 >= 0 OR anxietyLevelFor18To21 >= 0 OR anxietyLevelFor21ToM >= 0";
    NSString *whereStress = @"stressLevelForWTo9 >= 0 OR stressLevelFor9To12 >= 0 OR stressLevelFor12To15 >= 0 OR stressLevelFor15To18 >= 0 OR stressLevelFor18To21 >= 0 OR stressLevelFor21ToM >= 0";
    NSString *whereRumination = @"ruminationMinsForWTo9 > 0 OR ruminationMinsFor9To12 > 0 OR ruminationMinsFor12To15 > 0 OR ruminationMinsFor15To18 > 0 OR ruminationMinsFor18To21 > 0 OR ruminationMinsFor21ToM > 0";
    NSString *where = [NSString stringWithFormat:@"%@ OR %@ OR %@", whereRumination, whereAnxiety, whereStress];
    return [[Tracker objectsWhere:where] sortedResultsUsingKeyPath:@"dateString" ascending:false];
}

- (RLMResults *)allTrackersForCompulsions {
    NSString *whereAnxiety = @"anxietyLevelForWTo9 >= 0 OR anxietyLevelFor9To12 >= 0 OR anxietyLevelFor12To15 >= 0 OR anxietyLevelFor15To18 >= 0 OR anxietyLevelFor18To21 >= 0 OR anxietyLevelFor21ToM >= 0";
    NSString *whereStress = @"stressLevelForWTo9 >= 0 OR stressLevelFor9To12 >= 0 OR stressLevelFor12To15 >= 0 OR stressLevelFor15To18 >= 0 OR stressLevelFor18To21 >= 0 OR stressLevelFor21ToM >= 0";
    NSString *whereCompulsions = @"compulsionsMinsForWTo9 > 0 OR compulsionsMinsFor9To12 > 0 OR compulsionsMinsFor12To15 > 0 OR compulsionsMinsFor15To18 > 0 OR compulsionsMinsFor18To21 > 0 OR compulsionsMinsFor21ToM > 0";
    NSString *where = [NSString stringWithFormat:@"%@ OR %@ OR %@", whereCompulsions, whereAnxiety, whereStress];
    return [[Tracker objectsWhere:where] sortedResultsUsingKeyPath:@"dateString" ascending:false];
}

- (RLMResults *)allTrackersForAvoidances {
    NSString *whereAnxiety = @"anxietyLevelForWTo9 >= 0 OR anxietyLevelFor9To12 >= 0 OR anxietyLevelFor12To15 >= 0 OR anxietyLevelFor15To18 >= 0 OR anxietyLevelFor18To21 >= 0 OR anxietyLevelFor21ToM >= 0";
    NSString *whereStress = @"stressLevelForWTo9 >= 0 OR stressLevelFor9To12 >= 0 OR stressLevelFor12To15 >= 0 OR stressLevelFor15To18 >= 0 OR stressLevelFor18To21 >= 0 OR stressLevelFor21ToM >= 0";
    NSString *whereAvoidances = @"avoidancesMinsForWTo9 > 0 OR avoidancesMinsFor9To12 > 0 OR avoidancesMinsFor12To15 > 0 OR avoidancesMinsFor15To18 > 0 OR avoidancesMinsFor18To21 > 0 OR avoidancesMinsFor21ToM > 0";
    NSString *where = [NSString stringWithFormat:@"%@ OR %@ OR %@", whereAvoidances, whereAnxiety, whereStress];
    return [[Tracker objectsWhere:where] sortedResultsUsingKeyPath:@"dateString" ascending:false];
}

- (Tracker *)trackerForDate:(NSDate *)date {
    NSString *dateString = [date dateStringValue];
    NSString *where = [NSString stringWithFormat:@"dateString = '%@'", dateString];
    return [[Tracker objectsWhere:where] firstObject];
}

- (Tracker *)newTracker:(NSDate *)date {
    RLMRealm *realm = RLMRealm.defaultRealm;
    
    Tracker *tracker = [Tracker new];
    tracker.dateString = [date dateStringValue];
    tracker.anxietyLevelForWTo9 = -1;
    tracker.anxietyLevelFor9To12 = -1;
    tracker.anxietyLevelFor12To15 = -1;
    tracker.anxietyLevelFor15To18 = -1;
    tracker.anxietyLevelFor18To21 = -1;
    tracker.anxietyLevelFor21ToM = -1;
    tracker.stressLevelForWTo9 = -1;
    tracker.stressLevelFor9To12 = -1;
    tracker.stressLevelFor12To15 = -1;
    tracker.stressLevelFor15To18 = -1;
    tracker.stressLevelFor18To21 = -1;
    tracker.stressLevelFor21ToM = -1;
    
    [realm beginWriteTransaction];
    [realm addObject:tracker];
    [realm commitWriteTransaction];
    
    return tracker;
}

@end
