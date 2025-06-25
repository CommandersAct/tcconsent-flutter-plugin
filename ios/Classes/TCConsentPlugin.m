#import "TCConsentPlugin.h"
#if __has_include(<TCConsent_IAB/TCPrivacyCallbacks.h>)
#import <TCConsent_IAB/TCPrivacyCallbacks.h>
#import <TCConsent_IAB/TCConsentAPI.h>
#import <TCConsent_IAB/TCConsentConstants.h>
#import <TCConsent_IAB/TCPrivacyCenterViewController.h>
#import <TCConsent_IAB/TCMobileConsent.h>
#else
#import <TCConsent/TCPrivacyCallbacks.h>
#import <TCConsent/TCConsentAPI.h>
#import <TCConsent/TCConsentConstants.h>
#import <TCConsent/TCPrivacyCenterViewController.h>
#import <TCConsent/TCMobileConsent.h>
#endif

@interface TCConsentPlugin ()

@property (nonatomic, retain) FlutterMethodChannel* channel;
@property (nonatomic, assign) BOOL blockIOSPrivacyCenterDropOut;

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
      result(@{@"user" : [self getTCUserDictionary]});
  }
  else if ([@"showPrivacyCenter" isEqualToString:call.method])
  {
      TCPrivacyCenterViewController *PCM = [[TCPrivacyCenterViewController alloc] init];
      UIViewController *viewController = ((UIApplication *)[UIApplication sharedApplication]).delegate.window.rootViewController;

      if (@available(iOS 13.0, *))
      {
          [PCM setModalInPresentation: self.blockIOSPrivacyCenterDropOut];
      }
      else
      {
          [[TCLogger sharedInstance] logMessage: @"iOS 13 or higher API not available ! can't block modal Privacy Center." withLevel: TCLogLevel_Error];
      }
      
      [viewController presentViewController: PCM animated: YES completion: nil];
      result(nil);
  }
  else if ([@"acceptAllConsent" isEqualToString:call.method])
  {
      [[TCMobileConsent sharedInstance] acceptAllConsent];
      result(nil);
  }
  else if ([@"refuseAllConsent" isEqualToString:call.method])
  {
      [[TCMobileConsent sharedInstance] refuseAllConsent];
      result(nil);
  }
  else if ([@"useAcString" isEqualToString:call.method])
  {
      NSNumber *val = [call.arguments objectForKey: @"useAcString"];
      [[TCMobileConsent sharedInstance] useAcString: [val boolValue]];
      result(nil);
  }
  else if ([@"initWithCustomPCM" isEqualToString:call.method])
  {
      int siteID = [[call.arguments objectForKey: @"siteID"] intValue];
      int privacyID = [[call.arguments objectForKey: @"privacyID"] intValue];
      [[TCMobileConsent sharedInstance] customPCMSetSiteID: siteID andPrivacyID: privacyID];
      [[TCMobileConsent sharedInstance] registerCallback: self];
      result(@{@"user" : [self getTCUserDictionary]});
  }
  else if ([@"setConsentDuration" isEqualToString:call.method])
  {
      NSNumber *val = [call.arguments objectForKey: @"months"];
      [[TCMobileConsent sharedInstance] setConsentDuration: [val floatValue]];
      result(nil);
  }
  else if ([@"useCustomPublisherRestrictions" isEqualToString:call.method])
  {
      [[TCMobileConsent sharedInstance] useCustomPublisherRestrictions];
      result(nil);
  }
  else if ([@"saveConsentFromPopUp" isEqualToString:call.method])
  {
      NSDictionary *val = [call.arguments objectForKey: @"consent"];
      [[TCMobileConsent sharedInstance] saveConsentFromPopUp: val];
      result(nil);
  }
  else if ([@"saveConsent" isEqualToString:call.method])
  {
      NSDictionary *val = [call.arguments objectForKey: @"consent"];
      [[TCMobileConsent sharedInstance] saveConsent: val];
      result(nil);
  }
  else if ([@"saveConsentFromConsentSourceWithPrivacyAction" isEqualToString:call.method])
  {
      ETCConsentSource source = [[call.arguments objectForKey: @"source"] isEqualToString: @"ETCConsentSource.popUp"] ? Popup : PrivacyCenter;
      NSString *actionValue = [call.arguments objectForKey: @"action"];
      ETCConsentAction action = [actionValue isEqualToString: @"ETCConsentAction.acceptAll"] ? AcceptAll : ([actionValue isEqualToString: @"ETCConsentAction.refuseAll"] ? RefuseAll : Save);
      NSDictionary *consent = [call.arguments objectForKey: @"consent"];
      [[TCMobileConsent sharedInstance] saveConsent: consent fromConsentSource: source withPrivacyAction: action];
      result(@{@"user" : [self getTCUserDictionary]});
  }
  else if ([@"statEnterPCToVendorScreen" isEqualToString:call.method])
  {
      [[TCMobileConsent sharedInstance] statEnterPCToVendorScreen];
      result(nil);
  }
  else if ([@"statShowVendorScreen" isEqualToString:call.method])
  {
      [[TCMobileConsent sharedInstance] statShowVendorScreen];
      result(nil);
  }
  else if ([@"statViewPrivacyPoliciesFromPrivacyCenter" isEqualToString:call.method])
  {
      [[TCMobileConsent sharedInstance] statViewPrivacyPoliciesFromPrivacyCenter];
      result(nil);
  }
  else if ([@"statViewPrivacyCenter" isEqualToString:call.method])
  {
      [[TCMobileConsent sharedInstance] statViewPrivacyCenter];
      result(nil);
  }
  else if ([@"statViewBanner" isEqualToString:call.method])
  {
      [[TCMobileConsent sharedInstance] statViewBanner];
      result(nil);
  }
  else if ([@"statViewPrivacyPoliciesFromBanner" isEqualToString:call.method])
  {
      [[TCMobileConsent sharedInstance] statViewPrivacyPoliciesFromBanner];
      result(nil);
  }
  else if ([@"statViewPrivacyPoliciesFromBanner" isEqualToString:call.method])
  {
      [[TCMobileConsent sharedInstance] statViewPrivacyPoliciesFromBanner];
      result(nil);
  }
  else if ([@"getConsentAsJson" isEqualToString:call.method])
  {
      result([[TCMobileConsent sharedInstance] getConsentAsJson]);
  }
  else if ([@"resetSavedConsent" isEqualToString:call.method])
  {
      [[TCMobileConsent sharedInstance] resetSavedConsent];
      result(@{@"user" : [self getTCUserDictionary]});
  }
  else if ([@"setLanguage" isEqualToString:call.method])
  {
      NSString *languageCode = [call.arguments objectForKey: @"languageCode"];
      [[TCMobileConsent sharedInstance] setLanguage: languageCode];
      result(nil);
  }
  else if ([@"blockIOSPrivacyCenterDropOut" isEqualToString:call.method])
  {
      BOOL value = [[call.arguments objectForKey: @"value"] boolValue];
      self.blockIOSPrivacyCenterDropOut = value;
      result(nil);
  }
  else if ([@"isConsentAlreadyGiven" isEqualToString:call.method])
  {
      result([NSNumber numberWithBool: [TCConsentAPI isConsentAlreadyGiven]]);
  }
  else if ([@"getAllAcceptedConsent" isEqualToString:call.method])
  {
      result([TCConsentAPI getAllAcceptedConsent]);
  }
  else if ([@"getLastTimeConsentWasSaved" isEqualToString:call.method])
  {
      result([NSNumber numberWithLong: [TCConsentAPI getLastTimeConsentWasSaved]]);
  }
  else if ([@"isCategoryAccepted" isEqualToString:call.method])
  {
      int ID = [[call.arguments objectForKey: @"id"] intValue];
      result([NSNumber numberWithBool: [TCConsentAPI isCategoryAccepted: ID]]);
  }
  else if ([@"isVendorAccepted" isEqualToString:call.method])
  {
      int ID = [[call.arguments objectForKey: @"id"] intValue];
      result([NSNumber numberWithBool: [TCConsentAPI isVendorAccepted: ID]]);
  }
  else if ([@"isIABVendorAccepted" isEqualToString:call.method])
  {
      int ID = [[call.arguments objectForKey: @"id"] intValue];
      result([NSNumber numberWithBool: [TCConsentAPI isIABVendorAccepted: ID]]);
  }
  else if ([@"isIABPurposeAccepted" isEqualToString:call.method])
  {
      int ID = [[call.arguments objectForKey: @"id"] intValue];
      result([NSNumber numberWithBool: [TCConsentAPI isIABPurposeAccepted: ID]]);
  }
  else if ([@"isIABSpecialFeatureAccepted" isEqualToString:call.method])
  {
      int ID = [[call.arguments objectForKey: @"id"] intValue];
      result([NSNumber numberWithBool: [TCConsentAPI isIABSpecialFeatureAccepted: ID]]);
  }
  else if ([@"getAcceptedCategories" isEqualToString:call.method])
  {
      result([TCConsentAPI getAcceptedCategories]);
  }
  else if ([@"shouldDisplayPrivacyCenter" isEqualToString:call.method])
  {
      result([NSNumber numberWithBool: [TCConsentAPI shouldDisplayPrivacyCenter]]);
  }
  else
  {
    result(FlutterMethodNotImplemented);
  }
}

- (NSDictionary *) getTCUserDictionary
{
    TCUser *user = [TCUser sharedInstance];
    NSMutableDictionary *dict = [[user getJsonObject] mutableCopy];
    [dict setValue: user.consentID forKey:@"consentID"];
    [dict setValue: user.consent_vendors forKey:@"consent_vendors"];
    [dict setValue: user.consent_categories forKey:@"consent_categories"];
    [dict setValue: user.external_consent forKey:@"external_consent"];
    
    return dict;
}

- (void) consentUpdated: (NSDictionary *) consent
{
    [self.channel invokeMethod: @"consentUpdated" arguments: @{@"consent" : consent, @"user" : [self getTCUserDictionary]}];
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

- (void) firebaseConsentChanged: (NSDictionary<NSString *,NSNumber *> *) firebaseConsent
{
    id appDelegate = [UIApplication sharedApplication].delegate;
    
    if ([appDelegate respondsToSelector:@selector(firebaseConsentChanged:)])
    {
        [appDelegate performSelector:@selector(firebaseConsentChanged:) withObject: firebaseConsent];
        
        NSLog(@"firebaseConsentChanged: called on AppDelegate.");
    }
    else
    {
        NSLog(@"AppDelegate does not respond to firebaseConsentChanged:");
    }
}

@end
