//
//  DatabaseMigrator.m
//  OCD Help
//
//  Created by RuniTDev on 10/11/22.
//

#import "DatabaseMigrator.h"
#import "Tracker.h"
#import "TrackersManager.h"
#import "NSDate+Extension.h"

#define CURRENT_SCHEME_VERSION 2

@implementation DatabaseMigrator

+ (void)migrate {
    RLMRealmConfiguration *config = [RLMRealmConfiguration new];
    config.schemaVersion = CURRENT_SCHEME_VERSION;
    config.migrationBlock = ^(RLMMigration * _Nonnull migration, uint64_t oldSchemaVersion) {
        if (oldSchemaVersion < 2) {
            [migration enumerateObjects:[Tracker className]
                                  block:^(RLMObject * _Nullable oldObject, RLMObject * _Nullable newObject) {
                newObject[@"stressLevelForWTo9"] = @(-1);
                newObject[@"stressLevelFor9To12"] = @(-1);
                newObject[@"stressLevelFor12To15"] = @(-1);
                newObject[@"stressLevelFor15To18"] = @(-1);
                newObject[@"stressLevelFor18To21"] = @(-1);
                newObject[@"stressLevelFor21ToM"] = @(-1);
            }];
        }
    };
    [RLMRealmConfiguration setDefaultConfiguration:config];
    
    RLMRealm *realm = RLMRealm.defaultRealm;
    
    /* migrate rumination hours */
    
    NSDateFormatter * dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];

    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"TimeTracker"];
    if (dict) {
        [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSDictionary *objDict = (NSDictionary *)obj;
            if (objDict) {
                NSDate *date = [dateFormatter dateFromString:key];
                if (date != nil) {
                    double ruminanceForWTo9 = [[objDict objectForKey:@"WakeUpToNineAM"] doubleValue];
                    double ruminanceFor9To12 = [[objDict objectForKey:@"NineAMToTwelevePM"] doubleValue];
                    double ruminanceFor12To15 = [[objDict objectForKey:@"TwelevePMToThreePM"] doubleValue];
                    double ruminanceFor15To18 = [[objDict objectForKey:@"ThreePMToSixPM"] doubleValue];
                    double ruminanceFor18To21 = [[objDict objectForKey:@"SixPMToNinePM"] doubleValue];
                    double ruminanceFor21ToM = [[objDict objectForKey:@"NinePMToMorning"] doubleValue];
                    
                    Tracker *tracker = [[TrackersManager shared] trackerForDate:date];
                    if (tracker == nil) {
                        tracker = [[TrackersManager shared] newTracker:date];
                    }
                    
                    [realm beginWriteTransaction];
                    tracker.ruminationMinsForWTo9 = ruminanceForWTo9;
                    tracker.ruminationMinsFor9To12 = ruminanceFor9To12;
                    tracker.ruminationMinsFor12To15 = ruminanceFor12To15;
                    tracker.ruminationMinsFor15To18 = ruminanceFor15To18;
                    tracker.ruminationMinsFor18To21 = ruminanceFor18To21;
                    tracker.ruminationMinsFor21ToM = ruminanceFor21ToM;
                    [realm commitWriteTransaction];
                }
            }
            
        }];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TimeTracker"];
    }
    
    /* migrate anxiety level and notes */
    NSString *year = [[NSDate date] yearString];
    dict = [[NSUbiquitousKeyValueStore defaultStore] objectForKey:[NSString stringWithFormat:@"moodTracker%@", year]];
    
    if (dict) {
        [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSDictionary *objDict = (NSDictionary *)obj;
            if (objDict) {
                NSString *dateString = [objDict objectForKey:@"date"];
                NSDate *date = [NSDate dateFromString:dateString];
                
                if (date != nil) {
                    NSString *notes = [objDict objectForKey:@"moodDescription"];
                    NSInteger moodValue = [[objDict objectForKey:@"moodValue"] intValue];
                    
                    Tracker *tracker = [[TrackersManager shared] trackerForDate:date];
                    if (tracker == nil) {
                        tracker = [[TrackersManager shared] newTracker:date];
                    }
                    
                    [realm beginWriteTransaction];
                    tracker.notes = notes;
                    tracker.anxietyLevelForWTo9 = moodValue + 1;
                    tracker.anxietyLevelFor9To12 = moodValue + 1;
                    tracker.anxietyLevelFor12To15 = moodValue + 1;
                    tracker.anxietyLevelFor15To18 = moodValue + 1;
                    tracker.anxietyLevelFor18To21 = moodValue + 1;
                    tracker.anxietyLevelFor21ToM = moodValue + 1;
                    [realm commitWriteTransaction];
                }
            }
        }];
        
        [[NSUbiquitousKeyValueStore defaultStore] removeObjectForKey:[NSString stringWithFormat:@"moodTracker%@", year]];
    }
}

@end
