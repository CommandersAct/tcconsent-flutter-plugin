#import "TCConsentPlugin.h"
#if __has_include(<TCConsent_IAB/TCPrivacyCallbacks.h>)
#import <TCConsent_IAB/TCPrivacyCallbacks.h>
#import <TCConsent_IAB/TCConsentConstants.h>
#import <TCConsent_IAB/TCPrivacyCenterViewController.h>
#import <TCConsent_IAB/TCMobileConsent.h>
#else
#import <TCConsent/TCPrivacyCallbacks.h>
#import <TCConsent/TCConsentConstants.h>
#import <TCConsent/TCPrivacyCenterViewController.h>
#import <TCConsent/TCMobileConsent.h>
#endif

@interface TCConsentPlugin ()

@property (nonatomic, retain) FlutterMethodChannel* channel;

@end

@implementation TCConsentPlugin

+ (void) registerWithRegistrar: (NSObject<FlutterPluginRegistrar>*) registrar
{
    TCConsentPlugin* instance = [[TCConsentPlugin alloc] init];
    instance.channel = [FlutterMethodChannel methodChannelWithName: @"tc_consent_flutter_plugin"
                                                                binaryMessenger: [registrar messenger]];
    [registrar addMethodCallDelegate: instance channel: instance.channel];
}

- (void) handleMethodCall: (FlutterMethodCall*) call result: (FlutterResult) result
{
  if ([@"setSiteIDPrivacyID" isEqualToString:call.method])
  {
      int siteID = [[call.arguments objectForKey: @"siteID"] intValue];
      int privacyID = [[call.arguments objectForKey: @"privacyID"] intValue];
      [[TCMobileConsent sharedInstance] setSiteID: siteID andPrivacyID: privacyID];
      [[TCMobileConsent sharedInstance] registerCallback: self];
  }
  else if ([@"showPrivacyCenter" isEqualToString:call.method])
  {
      TCPrivacyCenterViewController *PCM = [[TCPrivacyCenterViewController alloc] init];
      UIViewController *viewController = ((UIApplication *)[UIApplication sharedApplication]).delegate.window.rootViewController;
      [viewController presentViewController: PCM animated: YES completion: nil];
  }
  else if ([@"acceptAllConsent" isEqualToString:call.method])
  {
      [[TCMobileConsent sharedInstance] acceptAllConsent];
  }
  else if ([@"refuseAllConsent" isEqualToString:call.method])
  {
      [[TCMobileConsent sharedInstance] refuseAllConsent];
  }
  else if ([@"useAcString" isEqualToString:call.method])
  {
      NSNumber *val = [call.arguments objectForKey: @"useAcString"];
      [[TCMobileConsent sharedInstance] useAcString: [val boolValue]];
  }
  else if ([@"initWithCustomPCM" isEqualToString:call.method])
  {
      int siteID = [[call.arguments objectForKey: @"siteID"] intValue];
      int privacyID = [[call.arguments objectForKey: @"privacyID"] intValue];
      [[TCMobileConsent sharedInstance] customPCMSetSiteID: siteID andPrivacyID: privacyID];
      [[TCMobileConsent sharedInstance] registerCallback: self];
  }
  else if ([@"setConsentDuration" isEqualToString:call.method])
  {
      NSNumber *val = [call.arguments objectForKey: @"months"];
      [[TCMobileConsent sharedInstance] setConsentDuration: [val floatValue]];
  }
  else if ([@"useCustomPublisherRestrictions" isEqualToString:call.method])
  {
      [[TCMobileConsent sharedInstance] useCustomPublisherRestrictions];
  }
  else if ([@"saveConsentFromPopUp" isEqualToString:call.method])
  {
      NSDictionary *val = [call.arguments objectForKey: @"consent"];
      [[TCMobileConsent sharedInstance] saveConsentFromPopUp: val];
  }
  else if ([@"saveConsent" isEqualToString:call.method])
  {
      NSDictionary *val = [call.arguments objectForKey: @"consent"];
      [[TCMobileConsent sharedInstance] saveConsent: val];
  }
  else if ([@"saveConsentFromConsentSourceWithPrivacyAction" isEqualToString:call.method])
  {
      ETCConsentSource source = [[call.arguments objectForKey: @"source"] isEqualToString: @"ETCConsentSource.popUp"] ? Popup : PrivacyCenter;
      NSString *actionValue = [call.arguments objectForKey: @"action"];
      ETCConsentAction action = [actionValue isEqualToString: @"ETCConsentAction.acceptAll"] ? AcceptAll : ([actionValue isEqualToString: @"ETCConsentAction.refuseAll"] ? RefuseAll : Save);
      NSDictionary *consent = [call.arguments objectForKey: @"consent"];
      [[TCMobileConsent sharedInstance] saveConsent: consent fromConsentSource: source withPrivacyAction: action];
  }
  else if ([@"statEnterPCToVendorScreen" isEqualToString:call.method])
  {
      [[TCMobileConsent sharedInstance] statEnterPCToVendorScreen];
  }
  else if ([@"statShowVendorScreen" isEqualToString:call.method])
  {
      [[TCMobileConsent sharedInstance] statShowVendorScreen];
  }
  else if ([@"statViewPrivacyPoliciesFromPrivacyCenter" isEqualToString:call.method])
  {
      [[TCMobileConsent sharedInstance] statViewPrivacyPoliciesFromPrivacyCenter];
  }
  else if ([@"statViewPrivacyCenter" isEqualToString:call.method])
  {
      [[TCMobileConsent sharedInstance] statViewPrivacyCenter];
  }
  else if ([@"statViewBanner" isEqualToString:call.method])
  {
      [[TCMobileConsent sharedInstance] statViewBanner];
  }
  else if ([@"statViewPrivacyPoliciesFromBanner" isEqualToString:call.method])
  {
      [[TCMobileConsent sharedInstance] statViewPrivacyPoliciesFromBanner];
  }
  else if ([@"statViewPrivacyPoliciesFromBanner" isEqualToString:call.method])
  {
      [[TCMobileConsent sharedInstance] statViewPrivacyPoliciesFromBanner];
  }
  else if ([@"getConsentAsJson" isEqualToString:call.method])
  {
      result([[TCMobileConsent sharedInstance] getConsentAsJson]);
  }
  else if ([@"resetSavedConsent" isEqualToString:call.method])
  {
      [[TCMobileConsent sharedInstance] resetSavedConsent];
  }
  else if ([@"setLanguage" isEqualToString:call.method])
  {
      NSString *languageCode = [call.arguments objectForKey: @"languageCode"];
      [[TCMobileConsent sharedInstance] setLanguage: languageCode];
  }
  else
  {
    result(FlutterMethodNotImplemented);
  }
}

- (void) consentUpdated: (NSDictionary *) consent
{
    [self.channel invokeMethod: @"consentUpdated" arguments: @{@"consent" : consent}];
}

/**
 * Called when the user consent hasn't changed in 13 months.
 */
- (void) consentOutdated
{
    [self.channel invokeMethod: @"consentOutdated" arguments: nil];
}

/**
 * When you make a change in the JSON, there is nothing special to do.
 * But when this change is adding or removing a category, or changing an ID, we should re-display the PCM.
 */
- (void) consentCategoryChanged
{
    [self.channel invokeMethod: @"consentCategoryChanged" arguments: nil];
}

/**
 * When the JSON has significant of important changes, this callback will be called
 */
- (void) significantChangesInPrivacy
{
    [self.channel invokeMethod: @"significantChangesInPrivacy" arguments: nil];
}

@end
