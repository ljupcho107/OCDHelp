//
//  TrackerVC.m
//  OCD Help
//
//  Created by RuniTDev on 9/29/22.
//

#import "TrackerVC.h"
#import "UIAlertController+Blocks.h"
#import "UIViewController+Extension.h"
#import "Tracker.h"
#import "TrackersManager.h"
#import "NSDate+Extension.h"
#import "AppDelegate.h"
#import <Realm/Realm.h>

@interface TrackerVC () <UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource> {
    Tracker *trackerForToday;
    Tracker *trackerForYesterday;
}


@end

@implementation TrackerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSDate *today = [NSDate new];
    NSDate *yesterday = [today dateByAddingDays:-1];
    
    trackerForToday = [[TrackersManager shared] trackerForDate:today];
    if (!trackerForToday) {
        trackerForToday = [[TrackersManager shared] newTracker:today];
    }
    
    trackerForYesterday = [[TrackersManager shared] trackerForDate:yesterday];
    if (!trackerForYesterday) {
        trackerForYesterday = [[TrackersManager shared] newTracker:yesterday];
    }
    
    [self displayTrackerInfo];
}

#pragma mark - Actions
- (IBAction)onEmergencyOcdChatClick:(id)sender {
    [self showWebViewWithTitle:@"Emergency OCD Chat" url:OCD_CHAT_URL];
}

- (IBAction)onTutorialAudioClick:(id)sender {
    [self playAudioWithFilename:@"whytracktime"];
}

- (IBAction)onStatisticsClick:(id)sender {
    
}

- (IBAction)onDateSegmentedControlValueChanged:(id)sender {
    [self displayTrackerInfo];
}

#pragma mark - UITextView Delegate Methods
- (void)textViewDidEndEditing:(UITextView *)textView {
    RLMRealm *realm = RLMRealm.defaultRealm;
    [realm beginWriteTransaction];
    
    if (dateSegmentedControl.selectedSegmentIndex == 0) {
        if (textView == notesTextView) {
            trackerForYesterday.notes = textView.text;
        }
    } else {
        if (textView == notesTextView) {
            trackerForToday.notes = textView.text;
        }
    }
    
    [realm commitWriteTransaction];
}

#pragma mark - UITextField Delegate Methods
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == anxietyLevelForWTo9TextField ||
        textField == anxietyLevelFor9To12TextField ||
        textField == anxietyLevelFor12To15TextField ||
        textField == anxietyLevelFor15To18TextField ||
        textField == anxietyLevelFor18To21TextField ||
        textField == anxietyLevelFor21ToMTextField ||
        textField == stressLevelForWTo9TextField ||
        textField == stressLevelFor9To12TextField ||
        textField == stressLevelFor12To15TextField ||
        textField == stressLevelFor15To18TextField ||
        textField == stressLevelFor18To21TextField ||
        textField == stressLevelFor21ToMTextField)
    {
        return;
    }
    
    double mins = [textField.text doubleValue];
    
    if (textField == ruminationForWTo9TextField ||
        textField == ruminationFor9To12TextField ||
        textField == ruminationFor12To15TextField ||
        textField == ruminationFor15To18TextField ||
        textField == ruminationFor18To21TextField ||
        textField == ruminationFor21ToMTextField)
    {
        double maxMins = [self maxMinutesForTextField:textField];
        if (mins > maxMins) {
            [self showMaximumAllowedMinutes:maxMins forText:textField];
            return;
        }
    }
    
    RLMRealm *realm = RLMRealm.defaultRealm;
    [realm beginWriteTransaction];
    
    if (dateSegmentedControl.selectedSegmentIndex == 0) {
        if (textField == ruminationForWTo9TextField) {
            trackerForYesterday.ruminationMinsForWTo9 = mins;
        } else if (textField == ruminationFor9To12TextField) {
            trackerForYesterday.ruminationMinsFor9To12 = mins;
        } else if (textField == ruminationFor12To15TextField) {
            trackerForYesterday.ruminationMinsFor12To15 = mins;
        } else if (textField == ruminationFor15To18TextField) {
            trackerForYesterday.ruminationMinsFor15To18 = mins;
        } else if (textField == ruminationFor18To21TextField) {
            trackerForYesterday.ruminationMinsFor18To21 = mins;
        } else if (textField == ruminationFor21ToMTextField) {
            trackerForYesterday.ruminationMinsFor21ToM = mins;
        }
        else if (textField == compulsionsForWTo9TextField) {
            trackerForYesterday.compulsionsMinsForWTo9 = mins;
        } else if (textField == compulsionsFor9To12TextField) {
            trackerForYesterday.compulsionsMinsFor9To12 = mins;
        } else if (textField == compulsionsFor12To15TextField) {
            trackerForYesterday.compulsionsMinsFor12To15 = mins;
        } else if (textField == compulsionsFor15To18TextField) {
            trackerForYesterday.compulsionsMinsFor15To18 = mins;
        } else if (textField == compulsionsFor18To21TextField) {
            trackerForYesterday.compulsionsMinsFor18To21 = mins;
        } else if (textField == compulsionsFor21ToMTextField) {
            trackerForYesterday.compulsionsMinsFor21ToM = mins;
        }
        else if (textField == avoidancesForWTo9TextField) {
            trackerForYesterday.avoidancesMinsForWTo9 = mins;
        } else if (textField == avoidancesFor9To12TextField) {
            trackerForYesterday.avoidancesMinsFor9To12 = mins;
        } else if (textField == avoidancesFor12To15TextField) {
            trackerForYesterday.avoidancesMinsFor12To15 = mins;
        } else if (textField == avoidancesFor15To18TextField) {
            trackerForYesterday.avoidancesMinsFor15To18 = mins;
        } else if (textField == avoidancesFor18To21TextField) {
            trackerForYesterday.avoidancesMinsFor18To21 = mins;
        } else if (textField == avoidancesFor21ToMTextField) {
            trackerForYesterday.avoidancesMinsFor21ToM = mins;
        }
    } else {
        if (textField == ruminationForWTo9TextField) {
            trackerForToday.ruminationMinsForWTo9 = mins;
        } else if (textField == ruminationFor9To12TextField) {
            trackerForToday.ruminationMinsFor9To12 = mins;
        } else if (textField == ruminationFor12To15TextField) {
            trackerForToday.ruminationMinsFor12To15 = mins;
        } else if (textField == ruminationFor15To18TextField) {
            trackerForToday.ruminationMinsFor15To18 = mins;
        } else if (textField == ruminationFor18To21TextField) {
            trackerForToday.ruminationMinsFor18To21 = mins;
        } else if (textField == ruminationFor21ToMTextField) {
            trackerForToday.ruminationMinsFor21ToM = mins;
        }
        else if (textField == compulsionsForWTo9TextField) {
            trackerForToday.compulsionsMinsForWTo9 = mins;
        } else if (textField == compulsionsFor9To12TextField) {
            trackerForToday.compulsionsMinsFor9To12 = mins;
        } else if (textField == compulsionsFor12To15TextField) {
            trackerForToday.compulsionsMinsFor12To15 = mins;
        } else if (textField == compulsionsFor15To18TextField) {
            trackerForToday.compulsionsMinsFor15To18 = mins;
        } else if (textField == compulsionsFor18To21TextField) {
            trackerForToday.compulsionsMinsFor18To21 = mins;
        } else if (textField == compulsionsFor21ToMTextField) {
            trackerForToday.compulsionsMinsFor21ToM = mins;
        }
        else if (textField == avoidancesForWTo9TextField) {
            trackerForToday.avoidancesMinsForWTo9 = mins;
        } else if (textField == avoidancesFor9To12TextField) {
            trackerForToday.avoidancesMinsFor9To12 = mins;
        } else if (textField == avoidancesFor12To15TextField) {
            trackerForToday.avoidancesMinsFor12To15 = mins;
        } else if (textField == avoidancesFor15To18TextField) {
            trackerForToday.avoidancesMinsFor15To18 = mins;
        } else if (textField == avoidancesFor18To21TextField) {
            trackerForToday.avoidancesMinsFor18To21 = mins;
        } else if (textField == avoidancesFor21ToMTextField) {
            trackerForToday.avoidancesMinsFor21ToM = mins;
        }
    }
    
    [realm commitWriteTransaction];
    
    [self displayTrackerInfo];
}

#pragma mark - UIPickerView Delegate Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 11;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSInteger level = row;

    if (pickerView.tag > 10) {
        return [Tracker textForStressLevel:level];
    } else {
        return [Tracker textForAnxietyLevel:level];
    }
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {

    NSInteger level = row;
    
    if (pickerView.tag > 10) {
        NSString *title = [Tracker textForStressLevel:level];
        UIColor *color = [Tracker colorForStressLevel:level];
        return [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSString *title = [Tracker textForAnxietyLevel:level];
        UIColor *color = [Tracker colorForAnxietyLevel:level];
        return [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName: color}];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    RLMRealm *realm = RLMRealm.defaultRealm;
    [realm beginWriteTransaction];
    
    if (dateSegmentedControl.selectedSegmentIndex == 0) {
        if (pickerView.tag == 1) {
            trackerForYesterday.anxietyLevelForWTo9 = row;
        } else if (pickerView.tag == 2) {
            trackerForYesterday.anxietyLevelFor9To12 = row;
        } else if (pickerView.tag == 3) {
            trackerForYesterday.anxietyLevelFor12To15 = row;
        } else if (pickerView.tag == 4) {
            trackerForYesterday.anxietyLevelFor15To18 = row;
        } else if (pickerView.tag == 5) {
            trackerForYesterday.anxietyLevelFor18To21 = row;
        } else if (pickerView.tag == 6) {
            trackerForYesterday.anxietyLevelFor21ToM = row;
        } else if (pickerView.tag == 11) {
            trackerForYesterday.stressLevelForWTo9 = row;
        } else if (pickerView.tag == 12) {
            trackerForYesterday.stressLevelFor9To12 = row;
        } else if (pickerView.tag == 13) {
            trackerForYesterday.stressLevelFor12To15 = row;
        } else if (pickerView.tag == 14) {
            trackerForYesterday.stressLevelFor15To18 = row;
        } else if (pickerView.tag == 15) {
            trackerForYesterday.stressLevelFor18To21 = row;
        } else if (pickerView.tag == 16) {
            trackerForYesterday.stressLevelFor21ToM = row;
        }
    } else {
        if (pickerView.tag == 1) {
            trackerForToday.anxietyLevelForWTo9 = row;
        } else if (pickerView.tag == 2) {
            trackerForToday.anxietyLevelFor9To12 = row;
        } else if (pickerView.tag == 3) {
            trackerForToday.anxietyLevelFor12To15 = row;
        } else if (pickerView.tag == 4) {
            trackerForToday.anxietyLevelFor15To18 = row;
        } else if (pickerView.tag == 5) {
            trackerForToday.anxietyLevelFor18To21 = row;
        } else if (pickerView.tag == 6) {
            trackerForToday.anxietyLevelFor21ToM = row;
        } else if (pickerView.tag == 11) {
            trackerForToday.stressLevelForWTo9 = row;
        } else if (pickerView.tag == 12) {
            trackerForToday.stressLevelFor9To12 = row;
        } else if (pickerView.tag == 13) {
            trackerForToday.stressLevelFor12To15 = row;
        } else if (pickerView.tag == 14) {
            trackerForToday.stressLevelFor15To18 = row;
        } else if (pickerView.tag == 15) {
            trackerForToday.stressLevelFor18To21 = row;
        } else if (pickerView.tag == 16) {
            trackerForToday.stressLevelFor21ToM = row;
        }
    }
    
    [realm commitWriteTransaction];
    
    [self displayTrackerInfo];
}

#pragma mark - Private Methods
- (void)setupUI {
    UIPickerView *anxietyLevelPickerView = [[UIPickerView alloc] init];
    anxietyLevelPickerView.dataSource = self;
    anxietyLevelPickerView.delegate = self;
    anxietyLevelPickerView.tag = 1;
    anxietyLevelForWTo9TextField.inputView = anxietyLevelPickerView;
    
    anxietyLevelPickerView = [[UIPickerView alloc] init];
    anxietyLevelPickerView.dataSource = self;
    anxietyLevelPickerView.delegate = self;
    anxietyLevelPickerView.tag = 2;
    anxietyLevelFor9To12TextField.inputView = anxietyLevelPickerView;
    
    anxietyLevelPickerView = [[UIPickerView alloc] init];
    anxietyLevelPickerView.dataSource = self;
    anxietyLevelPickerView.delegate = self;
    anxietyLevelPickerView.tag = 3;
    anxietyLevelFor12To15TextField.inputView = anxietyLevelPickerView;
    
    anxietyLevelPickerView = [[UIPickerView alloc] init];
    anxietyLevelPickerView.dataSource = self;
    anxietyLevelPickerView.delegate = self;
    anxietyLevelPickerView.tag = 4;
    anxietyLevelFor15To18TextField.inputView = anxietyLevelPickerView;
    
    anxietyLevelPickerView = [[UIPickerView alloc] init];
    anxietyLevelPickerView.dataSource = self;
    anxietyLevelPickerView.delegate = self;
    anxietyLevelPickerView.tag = 5;
    anxietyLevelFor18To21TextField.inputView = anxietyLevelPickerView;
    
    anxietyLevelPickerView = [[UIPickerView alloc] init];
    anxietyLevelPickerView.dataSource = self;
    anxietyLevelPickerView.delegate = self;
    anxietyLevelPickerView.tag = 6;
    anxietyLevelFor21ToMTextField.inputView = anxietyLevelPickerView;
    
    UIPickerView *stressLevelPickerView = [[UIPickerView alloc] init];
    stressLevelPickerView.dataSource = self;
    stressLevelPickerView.delegate = self;
    stressLevelPickerView.tag = 11;
    stressLevelForWTo9TextField.inputView = stressLevelPickerView;
    
    stressLevelPickerView = [[UIPickerView alloc] init];
    stressLevelPickerView.dataSource = self;
    stressLevelPickerView.delegate = self;
    stressLevelPickerView.tag = 12;
    stressLevelFor9To12TextField.inputView = stressLevelPickerView;
    
    stressLevelPickerView = [[UIPickerView alloc] init];
    stressLevelPickerView.dataSource = self;
    stressLevelPickerView.delegate = self;
    stressLevelPickerView.tag = 13;
    stressLevelFor12To15TextField.inputView = stressLevelPickerView;
    
    stressLevelPickerView = [[UIPickerView alloc] init];
    stressLevelPickerView.dataSource = self;
    stressLevelPickerView.delegate = self;
    stressLevelPickerView.tag = 14;
    stressLevelFor15To18TextField.inputView = stressLevelPickerView;
    
    stressLevelPickerView = [[UIPickerView alloc] init];
    stressLevelPickerView.dataSource = self;
    stressLevelPickerView.delegate = self;
    stressLevelPickerView.tag = 15;
    stressLevelFor18To21TextField.inputView = stressLevelPickerView;
    
    stressLevelPickerView = [[UIPickerView alloc] init];
    stressLevelPickerView.dataSource = self;
    stressLevelPickerView.delegate = self;
    stressLevelPickerView.tag = 16;
    stressLevelFor21ToMTextField.inputView = stressLevelPickerView;
}

- (double)maxMinutesForTextField:(UITextField *)textField {
    double maxMins = 180;
    if (textField == ruminationForWTo9TextField) {
        maxMins = 540;
    }
    
    return maxMins;
}

- (void)displayTrackerInfo {
    NSString *ruminanceGoal = [Tracker stringForMinutes:[trackerForYesterday totalRuminanceMinutes] * 0.95];
    NSString *compulsionsGoal = [Tracker stringForMinutes:[trackerForYesterday totalCompulsionsMinutes] * 0.95];
    NSString *avoidancesGoal = [Tracker stringForMinutes:[trackerForYesterday totalAvoidancesMinutes] * 0.95];
    ruminanceGoalLabel.text = [NSString stringWithFormat:@"RUMINANCE: %@ MIN(S)", ruminanceGoal];
    compulsionsGoalLabel.text = [NSString stringWithFormat:@"COMPULSIONS: %@", compulsionsGoal];
    avoidancesGoalLabel.text = [NSString stringWithFormat:@"AVOIDANCES: %@", avoidancesGoal];
    
    if (dateSegmentedControl.selectedSegmentIndex == 0) {
        NSString *ruminanceTotal = [Tracker stringForMinutes:[trackerForYesterday totalRuminanceMinutes]];
        NSString *compulsionsTotal = [Tracker stringForMinutes:[trackerForYesterday totalCompulsionsMinutes]];
        NSString *avoidancesTotal = [Tracker stringForMinutes:[trackerForYesterday totalAvoidancesMinutes]];
        ruminanceTotalLabel.text = [NSString stringWithFormat:@"RUMINANCE: %@ MIN(S)", ruminanceTotal];
        compulsionsTotalLabel.text = [NSString stringWithFormat:@"COMPULSIONS: %@", compulsionsTotal];
        avoidancesTotalLabel.text = [NSString stringWithFormat:@"AVOIDANCES: %@", avoidancesTotal];
        
        // ruminations
        if (trackerForYesterday.ruminationMinsForWTo9 > 0) {
            ruminationForWTo9TextField.text = [Tracker stringForMinutes:trackerForYesterday.ruminationMinsForWTo9];
        } else {
            ruminationForWTo9TextField.text = @"";
        }
        
        if (trackerForYesterday.ruminationMinsFor9To12 > 0) {
            ruminationFor9To12TextField.text = [Tracker stringForMinutes:trackerForYesterday.ruminationMinsFor9To12];
        } else {
            ruminationFor9To12TextField.text = @"";
        }
        
        if (trackerForYesterday.ruminationMinsFor12To15 > 0) {
            ruminationFor12To15TextField.text = [Tracker stringForMinutes:trackerForYesterday.ruminationMinsFor12To15];
        } else {
            ruminationFor12To15TextField.text = @"";
        }
        
        if (trackerForYesterday.ruminationMinsFor15To18 > 0) {
            ruminationFor15To18TextField.text = [Tracker stringForMinutes:trackerForYesterday.ruminationMinsFor15To18];
        } else {
            ruminationFor15To18TextField.text = @"";
        }
        
        if (trackerForYesterday.ruminationMinsFor18To21 > 0) {
            ruminationFor18To21TextField.text = [Tracker stringForMinutes:trackerForYesterday.ruminationMinsFor18To21];
        } else {
            ruminationFor18To21TextField.text = @"";
        }
        
        if (trackerForYesterday.ruminationMinsFor21ToM > 0) {
            ruminationFor21ToMTextField.text = [Tracker stringForMinutes:trackerForYesterday.ruminationMinsFor21ToM];
        } else {
            ruminationFor21ToMTextField.text = @"";
        }
        
        // compulsions
        if (trackerForYesterday.compulsionsMinsForWTo9 > 0) {
            compulsionsForWTo9TextField.text = [Tracker stringForMinutes:trackerForYesterday.compulsionsMinsForWTo9];
        } else {
            compulsionsForWTo9TextField.text = @"";
        }
        
        if (trackerForYesterday.compulsionsMinsFor9To12 > 0) {
            compulsionsFor9To12TextField.text = [Tracker stringForMinutes:trackerForYesterday.compulsionsMinsFor9To12];
        } else {
            compulsionsFor9To12TextField.text = @"";
        }
        
        if (trackerForYesterday.compulsionsMinsFor12To15 > 0) {
            compulsionsFor12To15TextField.text = [Tracker stringForMinutes:trackerForYesterday.compulsionsMinsFor12To15];
        } else {
            compulsionsFor12To15TextField.text = @"";
        }
        
        if (trackerForYesterday.compulsionsMinsFor15To18 > 0) {
            compulsionsFor15To18TextField.text = [Tracker stringForMinutes:trackerForYesterday.compulsionsMinsFor15To18];
        } else {
            compulsionsFor15To18TextField.text = @"";
        }
        
        if (trackerForYesterday.compulsionsMinsFor18To21 > 0) {
            compulsionsFor18To21TextField.text = [Tracker stringForMinutes:trackerForYesterday.compulsionsMinsFor18To21];
        } else {
            compulsionsFor18To21TextField.text = @"";
        }
        
        if (trackerForYesterday.compulsionsMinsFor21ToM > 0) {
            compulsionsFor21ToMTextField.text = [Tracker stringForMinutes:trackerForYesterday.compulsionsMinsFor21ToM];
        } else {
            compulsionsFor21ToMTextField.text = @"";
        }
        
        //avoidances
        if (trackerForYesterday.avoidancesMinsForWTo9 > 0) {
            avoidancesForWTo9TextField.text = [Tracker stringForMinutes:trackerForYesterday.avoidancesMinsForWTo9];
        } else {
            avoidancesForWTo9TextField.text = @"";
        }
        
        if (trackerForYesterday.avoidancesMinsFor9To12 > 0) {
            avoidancesFor9To12TextField.text = [Tracker stringForMinutes:trackerForYesterday.avoidancesMinsFor9To12];
        } else {
            avoidancesFor9To12TextField.text = @"";
        }
        
        if (trackerForYesterday.avoidancesMinsFor12To15 > 0) {
            avoidancesFor12To15TextField.text = [Tracker stringForMinutes:trackerForYesterday.avoidancesMinsFor12To15];
        } else {
            avoidancesFor12To15TextField.text = @"";
        }
        
        if (trackerForYesterday.avoidancesMinsFor15To18 > 0) {
            avoidancesFor15To18TextField.text = [Tracker stringForMinutes:trackerForYesterday.avoidancesMinsFor15To18];
        } else {
            avoidancesFor15To18TextField.text = @"";
        }
        
        if (trackerForYesterday.avoidancesMinsFor18To21 > 0) {
            avoidancesFor18To21TextField.text = [Tracker stringForMinutes:trackerForYesterday.avoidancesMinsFor18To21];
        } else {
            avoidancesFor18To21TextField.text = @"";
        }
        
        if (trackerForYesterday.avoidancesMinsFor21ToM > 0) {
            avoidancesFor21ToMTextField.text = [Tracker stringForMinutes:trackerForYesterday.avoidancesMinsFor21ToM];
        } else {
            avoidancesFor21ToMTextField.text = @"";
        }
        
        // anxiety level
        if (trackerForYesterday.anxietyLevelForWTo9 >= 0) {
            anxietyLevelForWTo9TextField.text = [NSString stringWithFormat:@"%ld", trackerForYesterday.anxietyLevelForWTo9];
        } else {
            anxietyLevelForWTo9TextField.text = @"";
        }
        [anxietyLevelForWTo9TextField setBackgroundColor:[trackerForYesterday anxietyColorForWTo9]];
        
        if (trackerForYesterday.anxietyLevelFor9To12 >= 0) {
            anxietyLevelFor9To12TextField.text = [NSString stringWithFormat:@"%ld", trackerForYesterday.anxietyLevelFor9To12];
        } else {
            anxietyLevelFor9To12TextField.text = @"";
        }
        [anxietyLevelFor9To12TextField setBackgroundColor:[trackerForYesterday anxietyColorFor9To12]];
        
        if (trackerForYesterday.anxietyLevelFor12To15 >= 0) {
            anxietyLevelFor12To15TextField.text = [NSString stringWithFormat:@"%ld", trackerForYesterday.anxietyLevelFor12To15];
        } else {
            anxietyLevelFor12To15TextField.text = @"";
        }
        [anxietyLevelFor12To15TextField setBackgroundColor:[trackerForYesterday anxietyColorFor12To15]];
        
        if (trackerForYesterday.anxietyLevelFor15To18 >= 0) {
            anxietyLevelFor15To18TextField.text = [NSString stringWithFormat:@"%ld", trackerForYesterday.anxietyLevelFor15To18];
        } else {
            anxietyLevelFor15To18TextField.text = @"";
        }
        [anxietyLevelFor15To18TextField setBackgroundColor:[trackerForYesterday anxietyColorFor15To18]];
        
        if (trackerForYesterday.anxietyLevelFor18To21 >= 0) {
            anxietyLevelFor18To21TextField.text = [NSString stringWithFormat:@"%ld", trackerForYesterday.anxietyLevelFor18To21];
        } else {
            anxietyLevelFor18To21TextField.text = @"";
        }
        [anxietyLevelFor18To21TextField setBackgroundColor:[trackerForYesterday anxietyColorFor18To21]];
        
        if (trackerForYesterday.anxietyLevelFor21ToM >= 0) {
            anxietyLevelFor21ToMTextField.text = [NSString stringWithFormat:@"%ld", trackerForYesterday.anxietyLevelFor21ToM];
        } else {
            anxietyLevelFor21ToMTextField.text = @"";
        }
        [anxietyLevelFor21ToMTextField setBackgroundColor:[trackerForYesterday anxietyColorFor21ToM]];
        
        // stress level
        if (trackerForYesterday.stressLevelForWTo9 >= 0) {
            stressLevelForWTo9TextField.text = [NSString stringWithFormat:@"%ld", trackerForYesterday.stressLevelForWTo9];
        } else {
            stressLevelForWTo9TextField.text = @"";
        }
        [stressLevelForWTo9TextField setBackgroundColor:[trackerForYesterday stressColorForWTo9]];
        
        if (trackerForYesterday.stressLevelFor9To12 >= 0) {
            stressLevelFor9To12TextField.text = [NSString stringWithFormat:@"%ld", trackerForYesterday.stressLevelFor9To12];
        } else {
            stressLevelFor9To12TextField.text = @"";
        }
        [stressLevelFor9To12TextField setBackgroundColor:[trackerForYesterday stressColorFor9To12]];
        
        if (trackerForYesterday.stressLevelFor12To15 >= 0) {
            stressLevelFor12To15TextField.text = [NSString stringWithFormat:@"%ld", trackerForYesterday.stressLevelFor12To15];
        } else {
            stressLevelFor12To15TextField.text = @"";
        }
        [stressLevelFor12To15TextField setBackgroundColor:[trackerForYesterday stressColorFor12To15]];
        
        if (trackerForYesterday.stressLevelFor15To18 >= 0) {
            stressLevelFor15To18TextField.text = [NSString stringWithFormat:@"%ld", trackerForYesterday.stressLevelFor15To18];
        } else {
            stressLevelFor15To18TextField.text = @"";
        }
        [stressLevelFor15To18TextField setBackgroundColor:[trackerForYesterday stressColorFor15To18]];
        
        if (trackerForYesterday.stressLevelFor18To21 >= 0) {
            stressLevelFor18To21TextField.text = [NSString stringWithFormat:@"%ld", trackerForYesterday.stressLevelFor18To21];
        } else {
            stressLevelFor18To21TextField.text = @"";
        }
        [stressLevelFor18To21TextField setBackgroundColor:[trackerForYesterday stressColorFor18To21]];
        
        if (trackerForYesterday.stressLevelFor21ToM >= 0) {
            stressLevelFor21ToMTextField.text = [NSString stringWithFormat:@"%ld", trackerForYesterday.stressLevelFor21ToM];
        } else {
            stressLevelFor21ToMTextField.text = @"";
        }
        [stressLevelFor21ToMTextField setBackgroundColor:[trackerForYesterday stressColorFor21ToM]];
        
        // notes
        notesTextView.text = trackerForYesterday.notes;
    } else {
        NSString *ruminanceTotal = [Tracker stringForMinutes:[trackerForToday totalRuminanceMinutes]];
        NSString *compulsionsTotal = [Tracker stringForMinutes:[trackerForToday totalCompulsionsMinutes]];
        NSString *avoidancesTotal = [Tracker stringForMinutes:[trackerForToday totalAvoidancesMinutes]];
        ruminanceTotalLabel.text = [NSString stringWithFormat:@"RUMINANCE: %@ MIN(S)", ruminanceTotal];
        compulsionsTotalLabel.text = [NSString stringWithFormat:@"COMPULSIONS: %@", compulsionsTotal];
        avoidancesTotalLabel.text = [NSString stringWithFormat:@"AVOIDANCES: %@", avoidancesTotal];
        
        // ruminations
        if (trackerForToday.ruminationMinsForWTo9 > 0) {
            ruminationForWTo9TextField.text = [Tracker stringForMinutes:trackerForToday.ruminationMinsForWTo9];
        } else {
            ruminationForWTo9TextField.text = @"";
        }
        
        if (trackerForToday.ruminationMinsFor9To12 > 0) {
            ruminationFor9To12TextField.text = [Tracker stringForMinutes:trackerForToday.ruminationMinsFor9To12];
        } else {
            ruminationFor9To12TextField.text = @"";
        }
        
        if (trackerForToday.ruminationMinsFor12To15 > 0) {
            ruminationFor12To15TextField.text = [Tracker stringForMinutes:trackerForToday.ruminationMinsFor12To15];
        } else {
            ruminationFor12To15TextField.text = @"";
        }
        
        if (trackerForToday.ruminationMinsFor15To18 > 0) {
            ruminationFor15To18TextField.text = [Tracker stringForMinutes:trackerForToday.ruminationMinsFor15To18];
        } else {
            ruminationFor15To18TextField.text = @"";
        }
        
        if (trackerForToday.ruminationMinsFor18To21 > 0) {
            ruminationFor18To21TextField.text = [Tracker stringForMinutes:trackerForToday.ruminationMinsFor18To21];
        } else {
            ruminationFor18To21TextField.text = @"";
        }
        
        if (trackerForToday.ruminationMinsFor21ToM > 0) {
            ruminationFor21ToMTextField.text = [Tracker stringForMinutes:trackerForToday.ruminationMinsFor21ToM];
        } else {
            ruminationFor21ToMTextField.text = @"";
        }
        
        // compulsions
        if (trackerForToday.compulsionsMinsForWTo9 > 0) {
            compulsionsForWTo9TextField.text = [Tracker stringForMinutes:trackerForToday.compulsionsMinsForWTo9];
        } else {
            compulsionsForWTo9TextField.text = @"";
        }
        
        if (trackerForToday.compulsionsMinsFor9To12 > 0) {
            compulsionsFor9To12TextField.text = [Tracker stringForMinutes:trackerForToday.compulsionsMinsFor9To12];
        } else {
            compulsionsFor9To12TextField.text = @"";
        }
        
        if (trackerForToday.compulsionsMinsFor12To15 > 0) {
            compulsionsFor12To15TextField.text = [Tracker stringForMinutes:trackerForToday.compulsionsMinsFor12To15];
        } else {
            compulsionsFor12To15TextField.text = @"";
        }
        
        if (trackerForToday.compulsionsMinsFor15To18 > 0) {
            compulsionsFor15To18TextField.text = [Tracker stringForMinutes:trackerForToday.compulsionsMinsFor15To18];
        } else {
            compulsionsFor15To18TextField.text = @"";
        }
        
        if (trackerForToday.compulsionsMinsFor18To21 > 0) {
            compulsionsFor18To21TextField.text = [Tracker stringForMinutes:trackerForToday.compulsionsMinsFor18To21];
        } else {
            compulsionsFor18To21TextField.text = @"";
        }
        
        if (trackerForToday.compulsionsMinsFor21ToM > 0) {
            compulsionsFor21ToMTextField.text = [Tracker stringForMinutes:trackerForToday.compulsionsMinsFor21ToM];
        } else {
            compulsionsFor21ToMTextField.text = @"";
        }
        
        //avoidances
        if (trackerForToday.avoidancesMinsForWTo9 > 0) {
            avoidancesForWTo9TextField.text = [Tracker stringForMinutes:trackerForToday.avoidancesMinsForWTo9];
        } else {
            avoidancesForWTo9TextField.text = @"";
        }
        
        if (trackerForToday.avoidancesMinsFor9To12 > 0) {
            avoidancesFor9To12TextField.text = [Tracker stringForMinutes:trackerForToday.avoidancesMinsFor9To12];
        } else {
            avoidancesFor9To12TextField.text = @"";
        }
        
        if (trackerForToday.avoidancesMinsFor12To15 > 0) {
            avoidancesFor12To15TextField.text = [Tracker stringForMinutes:trackerForToday.avoidancesMinsFor12To15];
        } else {
            avoidancesFor12To15TextField.text = @"";
        }
        
        if (trackerForToday.avoidancesMinsFor15To18 > 0) {
            avoidancesFor15To18TextField.text = [Tracker stringForMinutes:trackerForToday.avoidancesMinsFor15To18];
        } else {
            avoidancesFor15To18TextField.text = @"";
        }
        
        if (trackerForToday.avoidancesMinsFor18To21 > 0) {
            avoidancesFor18To21TextField.text = [Tracker stringForMinutes:trackerForToday.avoidancesMinsFor18To21];
        } else {
            avoidancesFor18To21TextField.text = @"";
        }
        
        if (trackerForToday.avoidancesMinsFor21ToM > 0) {
            avoidancesFor21ToMTextField.text = [Tracker stringForMinutes:trackerForToday.avoidancesMinsFor21ToM];
        } else {
            avoidancesFor21ToMTextField.text = @"";
        }
        
        // anxiety level
        if (trackerForToday.anxietyLevelForWTo9 >= 0) {
            anxietyLevelForWTo9TextField.text = [NSString stringWithFormat:@"%ld", trackerForToday.anxietyLevelForWTo9];
        } else {
            anxietyLevelForWTo9TextField.text = @"";
        }
        [anxietyLevelForWTo9TextField setBackgroundColor:[trackerForToday anxietyColorForWTo9]];
        
        if (trackerForToday.anxietyLevelFor9To12 >= 0) {
            anxietyLevelFor9To12TextField.text = [NSString stringWithFormat:@"%ld", trackerForToday.anxietyLevelFor9To12];
        } else {
            anxietyLevelFor9To12TextField.text = @"";
        }
        [anxietyLevelFor9To12TextField setBackgroundColor:[trackerForToday anxietyColorFor9To12]];
        
        if (trackerForToday.anxietyLevelFor12To15 >= 0) {
            anxietyLevelFor12To15TextField.text = [NSString stringWithFormat:@"%ld", trackerForToday.anxietyLevelFor12To15];
        } else {
            anxietyLevelFor12To15TextField.text = @"";
        }
        [anxietyLevelFor12To15TextField setBackgroundColor:[trackerForToday anxietyColorFor12To15]];
        
        if (trackerForToday.anxietyLevelFor15To18 >= 0) {
            anxietyLevelFor15To18TextField.text = [NSString stringWithFormat:@"%ld", trackerForToday.anxietyLevelFor15To18];
        } else {
            anxietyLevelFor15To18TextField.text = @"";
        }
        [anxietyLevelFor15To18TextField setBackgroundColor:[trackerForToday anxietyColorFor15To18]];
        
        if (trackerForToday.anxietyLevelFor18To21 >= 0) {
            anxietyLevelFor18To21TextField.text = [NSString stringWithFormat:@"%ld", trackerForToday.anxietyLevelFor18To21];
        } else {
            anxietyLevelFor18To21TextField.text = @"";
        }
        [anxietyLevelFor18To21TextField setBackgroundColor:[trackerForToday anxietyColorFor18To21]];
        
        if (trackerForToday.anxietyLevelFor21ToM >= 0) {
            anxietyLevelFor21ToMTextField.text = [NSString stringWithFormat:@"%ld", trackerForToday.anxietyLevelFor21ToM];
        } else {
            anxietyLevelFor21ToMTextField.text = @"";
        }
        [anxietyLevelFor21ToMTextField setBackgroundColor:[trackerForToday anxietyColorFor21ToM]];
        
        // stress level
        if (trackerForToday.stressLevelForWTo9 >= 0) {
            stressLevelForWTo9TextField.text = [NSString stringWithFormat:@"%ld", trackerForToday.stressLevelForWTo9];
        } else {
            stressLevelForWTo9TextField.text = @"";
        }
        [stressLevelForWTo9TextField setBackgroundColor:[trackerForToday stressColorForWTo9]];
        
        if (trackerForToday.stressLevelFor9To12 >= 0) {
            stressLevelFor9To12TextField.text = [NSString stringWithFormat:@"%ld", trackerForToday.stressLevelFor9To12];
        } else {
            stressLevelFor9To12TextField.text = @"";
        }
        [stressLevelFor9To12TextField setBackgroundColor:[trackerForToday stressColorFor9To12]];
        
        if (trackerForToday.stressLevelFor12To15 >= 0) {
            stressLevelFor12To15TextField.text = [NSString stringWithFormat:@"%ld", trackerForToday.stressLevelFor12To15];
        } else {
            stressLevelFor12To15TextField.text = @"";
        }
        [stressLevelFor12To15TextField setBackgroundColor:[trackerForToday stressColorFor12To15]];
        
        if (trackerForToday.stressLevelFor15To18 >= 0) {
            stressLevelFor15To18TextField.text = [NSString stringWithFormat:@"%ld", trackerForToday.stressLevelFor15To18];
        } else {
            stressLevelFor15To18TextField.text = @"";
        }
        [stressLevelFor15To18TextField setBackgroundColor:[trackerForToday stressColorFor15To18]];
        
        if (trackerForToday.stressLevelFor18To21 >= 0) {
            stressLevelFor18To21TextField.text = [NSString stringWithFormat:@"%ld", trackerForToday.stressLevelFor18To21];
        } else {
            stressLevelFor18To21TextField.text = @"";
        }
        [stressLevelFor18To21TextField setBackgroundColor:[trackerForToday stressColorFor18To21]];
        
        if (trackerForToday.stressLevelFor21ToM >= 0) {
            stressLevelFor21ToMTextField.text = [NSString stringWithFormat:@"%ld", trackerForToday.stressLevelFor21ToM];
        } else {
            stressLevelFor21ToMTextField.text = @"";
        }
        [stressLevelFor21ToMTextField setBackgroundColor:[trackerForToday stressColorFor21ToM]];
        
        // notes
        notesTextView.text = trackerForToday.notes;
    }
}

- (void)showMaximumAllowedMinutes:(NSInteger)mins forText:(UITextField *)tf {
    NSString *message = [NSString stringWithFormat:@"We know you are ruminating alot, But maximum allowed minutes are %ld. We are saving this maximum value for now.", mins];
    [UIAlertController showAlertInViewController:self
                                       withTitle:@"Don't worry!"
                                         message:message
                               cancelButtonTitle:nil
                          destructiveButtonTitle:nil
                               otherButtonTitles:@[@"Set Maximum", @"Remove"]
                                        tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
        if (buttonIndex == 2) {
            tf.text = [NSString stringWithFormat:@"%ld", mins];
        } else {
            tf.text = @"";
        }
        
        [self textFieldDidEndEditing:tf];
    }];
}

@end
