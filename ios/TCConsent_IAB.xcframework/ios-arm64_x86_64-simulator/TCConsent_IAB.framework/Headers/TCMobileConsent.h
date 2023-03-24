//
//  TCMobileConsent.h
//  TCPrivacy
//
//  Created by JeanJulien on 28/12/2017.
//  Copyright © 2017 TagCommander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TCCore/ETCConsentState.h>
#import <TCCore/TCSingleton.h>
#import <TCCore/TCMacros.h>
#import <TCCore/TCEventSender.h>
#import <TCCore/TCEventListener.h>
#if __has_include(<TCConsent_IAB/TCConsentConstants.h>)
#import <TCConsent_IAB/TCConsentConstants.h>
#import <TCConsent_IAB/TCPrivacyCallbacks.h>
#else
#import <TCConsent/TCConsentConstants.h>
#import <TCConsent/TCPrivacyCallbacks.h>
#endif


@interface TCMobileConsent : TCSingleton <ITCEventSenderDelegate, ITCEventListenerDelegate>

SINGLETON_CLASS_H(TCMobileConsent)

- (void) customPCMSetSiteID: (int) siteID andPrivacyID: (int) privacyID;
- (void) setSiteID: (int) siteID andPrivacyID: (int) privacyID;

- (void) setLanguage: (NSString *) languageCode;
- (NSString *) getConsentAsJson;
- (void) useAcString: (Boolean) enableAC;

- (void) acceptAllConsent;
- (void) refuseAllConsent;
- (void) acceptAllConsentFromPrivacyCenter;
- (void) refuseAllConsentFromPrivacyCenter;

/* Custom UI/PrivacyCenter Methodes*/
- (void) saveConsent: (NSDictionary *) consent;
- (void) saveConsent: (NSDictionary *) consent fromConsentSource: (enum ETCConsentSource) source withPrivacyAction: (enum ETCConsentAction) action;
- (void) saveConsentFromPopUp: (NSDictionary *) consent;

- (void) resetSavedConsent;
- (void) setConsentUser: (NSString *) userID;

- (void) viewConsent;
- (void) statEnterPCToVendorScreen;
- (void) statShowVendorScreen;
- (void) statViewPrivacyPoliciesFromBanner;
- (void) statViewPrivacyPoliciesFromPrivacyCenter;
- (void) statViewPrivacyCenter;
- (void) statViewBanner;

- (void) enableServerSide;
- (void) disableServerSide;
- (void) registerCallback: (id<TCPrivacyCallbacks>) listener;
+ (NSArray *) getSavedCategoriesAndVendors;
- (void) useCustomPublisherRestrictions;

@property (nonatomic, assign) Boolean enableIAB;
@property (nonatomic, assign) ETCConsentState privacyState;
@property (nonatomic, assign) int clientSiteID;
@property (nonatomic, assign) int privacyID;
@property (nonatomic, assign) float consentDuration;
@property (nonatomic, assign) Boolean consentExpired;
@property (nonatomic, assign) Boolean generatePublisherTC;
@property (nonatomic, assign) Boolean enableACString;
@property (nonatomic, retain) NSString *userID;
@property (nonatomic, retain) id<TCPrivacyCallbacks> callback;
@property (nonatomic, assign) int vendorListVersion;
@property (nonatomic, assign) Boolean switchDefaultState;
@property (nonatomic, retain) NSString *consentVersion;

@property (nonatomic, assign) int maxVendorID;
@property (nonatomic, assign) NSString *languageCode;

@property (nonatomic, retain) TCEventSender *senderDelegate;
@property (nonatomic, retain) TCEventListener *listenerDelegate;

@end
