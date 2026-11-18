#import <Flutter/Flutter.h>
#import <TCCore/TCUser.h>
#import <TCCore/TCLogger.h>
#import <TCConsent/TCPrivacyCallbacks.h>

@interface TCConsentPlugin : NSObject<FlutterPlugin, TCPrivacyCallbacks>

@end
