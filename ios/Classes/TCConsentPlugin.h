#import <Flutter/Flutter.h>
#import <TCCore/TCUser.h>
#if __has_include(<TCConsent_IAB/TCPrivacyCallbacks.h>)
#import <TCConsent_IAB/TCPrivacyCallbacks.h>
#else
#import <TCConsent/TCPrivacyCallbacks.h>
#endif

@interface TCConsentPlugin : NSObject<FlutterPlugin, TCPrivacyCallbacks>

@end
