#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import <Flutter/Flutter.h>
@import FirebaseCore;
@import FirebaseAnalytics;


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions: (NSDictionary *) launchOptions
{
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    [FIRApp configure];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void) firebaseConsentChanged: (NSDictionary<NSString *,NSNumber *> *)firebaseConsent
{
        
    NSNumber *analyticsStorageValue = firebaseConsent[@"analytics_storage"];
    if (analyticsStorageValue != nil) {
        FIRConsentStatus status = [analyticsStorageValue boolValue] ? FIRConsentStatusGranted : FIRConsentStatusDenied;
        [FIRAnalytics setConsent:@{ FIRConsentTypeAnalyticsStorage: status }];
    }

    NSNumber *adStorageValue = firebaseConsent[@"ad_storage"];
    if (adStorageValue != nil) {
        FIRConsentStatus status = [adStorageValue boolValue] ? FIRConsentStatusGranted : FIRConsentStatusDenied;
        [FIRAnalytics setConsent:@{ FIRConsentTypeAdStorage: status }];
    }

    NSNumber *adUserDataValue = firebaseConsent[@"ad_user_data"];
    if (adUserDataValue != nil) {
        FIRConsentStatus status = [adUserDataValue boolValue] ? FIRConsentStatusGranted : FIRConsentStatusDenied;
        [FIRAnalytics setConsent:@{ FIRConsentTypeAdUserData: status }];
    }

    NSNumber *adPersonalizationValue = firebaseConsent[@"ad_personalization"];
    if (adPersonalizationValue != nil) {
        FIRConsentStatus status = [adPersonalizationValue boolValue] ? FIRConsentStatusGranted : FIRConsentStatusDenied;
        [FIRAnalytics setConsent:@{ FIRConsentTypeAdPersonalization: status }];
    }
}


@end
