//
//  AppDelegate.m
//  OCD Help
//
//  Created by RuniTDev on 9/25/22.
//

#import "AppDelegate.h"
#import "RMStore.h"
#import "RMStoreAppReceiptVerifier.h"
#import "RMStoreKeychainPersistence.h"
#import <OneSignal/OneSignal.h>
@import IQKeyboardManagerSwift;

@interface AppDelegate () {
    id<RMStoreReceiptVerifier> _receiptVerifier;
    RMStoreKeychainPersistence *_persistence;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [IQKeyboardManager shared].enable = YES;
    [self configureStore];
    
    // Remove this method to stop OneSignal Debugging
    [OneSignal setLogLevel:ONE_S_LL_VERBOSE visualLevel:ONE_S_LL_NONE];
    
    // OneSignal initialization
    [OneSignal initWithLaunchOptions:launchOptions];
    [OneSignal setAppId:@"fb07fb8b-8ab1-4d80-b0fb-e37e56b2db51"];
    
    // promptForPushNotifications will show the native iOS notification permission prompt.
    // We recommend removing the following code and instead using an In-App Message to prompt for notification permission (See step 8)
    [OneSignal promptForPushNotificationsWithUserResponse:^(BOOL accepted) {
        NSLog(@"User accepted notifications: %d", accepted);
    }];
    
    NSString * name = [[UIDevice currentDevice] name];
    name = [name stringByReplacingOccurrencesOfString:@" " withString:@""];
    name = [name stringByReplacingOccurrencesOfString:@"iPhone" withString:@""];
    name = [name stringByReplacingOccurrencesOfString:@"iPad" withString:@""];
    name = [name stringByReplacingOccurrencesOfString:@"'" withString:@""];
    name = [name stringByReplacingOccurrencesOfString:@"’" withString:@""];
    NSString *email = [NSString stringWithFormat:@"%@@youhaveocd.com", name];
    [OneSignal setEmail:email];
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

#pragma mark - Private methods
- (void)configureStore
{
    _receiptVerifier = [[RMStoreAppReceiptVerifier alloc] init];
    [RMStore defaultStore].receiptVerifier = _receiptVerifier;
    
    _persistence = [[RMStoreKeychainPersistence alloc] init];
    [RMStore defaultStore].transactionPersistor = _persistence;
}

@end
