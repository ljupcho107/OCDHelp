//
//  TrackersManager.h
//  OCD Help
//
//  Created by RuniTDev on 9/30/22.
//

#import <Foundation/Foundation.h>
#import "Tracker.h"

NS_ASSUME_NONNULL_BEGIN

@interface TrackersManager : NSObject

+ (TrackersManager*)shared;

- (RLMResults *)allTrackersForRumination;
- (RLMResults *)allTrackersForCompulsions;
- (RLMResults *)allTrackersForAvoidances;

- (Tracker *)trackerForDate:(NSDate *)date;
- (Tracker *)newTracker:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
