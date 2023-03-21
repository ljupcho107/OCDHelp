//
//  TrackerVC.h
//  OCD Help
//
//  Created by RuniTDev on 9/29/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TrackerVC : UIViewController {
    __weak IBOutlet UILabel *ruminanceGoalLabel;
    __weak IBOutlet UILabel *compulsionsGoalLabel;
    __weak IBOutlet UILabel *avoidancesGoalLabel;
    __weak IBOutlet UILabel *ruminanceTotalLabel;
    __weak IBOutlet UILabel *compulsionsTotalLabel;
    __weak IBOutlet UILabel *avoidancesTotalLabel;
    
    __weak IBOutlet UISegmentedControl *dateSegmentedControl;
    
    __weak IBOutlet UITextField *ruminationForWTo9TextField;
    __weak IBOutlet UITextField *ruminationFor9To12TextField;
    __weak IBOutlet UITextField *ruminationFor12To15TextField;
    __weak IBOutlet UITextField *ruminationFor15To18TextField;
    __weak IBOutlet UITextField *ruminationFor18To21TextField;
    __weak IBOutlet UITextField *ruminationFor21ToMTextField;
    
    __weak IBOutlet UITextField *compulsionsForWTo9TextField;
    __weak IBOutlet UITextField *compulsionsFor9To12TextField;
    __weak IBOutlet UITextField *compulsionsFor12To15TextField;
    __weak IBOutlet UITextField *compulsionsFor15To18TextField;
    __weak IBOutlet UITextField *compulsionsFor18To21TextField;
    __weak IBOutlet UITextField *compulsionsFor21ToMTextField;
    
    __weak IBOutlet UITextField *avoidancesForWTo9TextField;
    __weak IBOutlet UITextField *avoidancesFor9To12TextField;
    __weak IBOutlet UITextField *avoidancesFor12To15TextField;
    __weak IBOutlet UITextField *avoidancesFor15To18TextField;
    __weak IBOutlet UITextField *avoidancesFor18To21TextField;
    __weak IBOutlet UITextField *avoidancesFor21ToMTextField;
    
    __weak IBOutlet UITextField *anxietyLevelForWTo9TextField;
    __weak IBOutlet UITextField *anxietyLevelFor9To12TextField;
    __weak IBOutlet UITextField *anxietyLevelFor12To15TextField;
    __weak IBOutlet UITextField *anxietyLevelFor15To18TextField;
    __weak IBOutlet UITextField *anxietyLevelFor18To21TextField;
    __weak IBOutlet UITextField *anxietyLevelFor21ToMTextField;
    
    __weak IBOutlet UITextField *stressLevelForWTo9TextField;
    __weak IBOutlet UITextField *stressLevelFor9To12TextField;
    __weak IBOutlet UITextField *stressLevelFor12To15TextField;
    __weak IBOutlet UITextField *stressLevelFor15To18TextField;
    __weak IBOutlet UITextField *stressLevelFor18To21TextField;
    __weak IBOutlet UITextField *stressLevelFor21ToMTextField;
    
    __weak IBOutlet UITextView *notesTextView;
}

@end

NS_ASSUME_NONNULL_END
