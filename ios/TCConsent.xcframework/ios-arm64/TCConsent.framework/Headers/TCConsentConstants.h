//
//  TCPrivacyConstants.h
//  TCPrivacy
//
//  Created by JeanJulien on 28/12/2017.
//  Copyright © 2017 TagCommander. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef TagCommander_TCConsentConstants_h
#define TagCommander_TCConsentConstants_h

@interface TCConsentConstants : NSObject

extern NSString *const kTCConsentTime;
extern NSString *const kTCPrivacyConsent;

extern NSString *const kTCSavedCategories;
extern NSString *const kTCSavedVendors;
extern NSString *const kTCSavedFeatures;
extern NSString *const kTCSavedGoogleVendors;

extern unsigned long long const kTCConsentExpirationDuration;
extern unsigned long long const kTCConsentOneMonthDuration;


// Privacy Configuration
extern NSString *const kTCConfigurationCDNURLStringFormat;

extern NSString *const kTCVendorListOfflineKey;
extern NSString *const kTCVendorListURL;

// Privacy configuration constants
extern NSString *const kTCConfKey_Information;
extern NSString *const kTCConfKey_Components;
extern NSString *const kTCConfKey_Texts;
extern NSString *const kTCConfKey_Categories;
extern NSString *const kTCConfKey_Vendors;
extern NSString *const kTCConfKey_Customisation;
extern NSString *const kTCConfKey_Order;
extern NSString *const kTCConfKey_OrderCustom;
extern NSString *const kTCConfKey_OrderIAB;

// type_actions
extern NSString *const kTCTypeActionContinueBrowsing;
extern NSString *const kTCTypeActionViewPrivacyCenter;
extern NSString *const kTCTypeActionViewBanner;
extern NSString *const kTCTypeActionSavePrivacyCenter;
extern NSString *const kTCTypeActionViewVendorScreen;
extern NSString *const kTCActionClickPCToNotPC;
extern NSString *const kTCActionClickBannerToNotPC;
extern NSString *const kTCTypeActionAcceptBanner;

// consent sources

typedef NS_ENUM(NSInteger, ETCConsentSource)
{
    Popup,
    PrivacyCenter
};

// consent action type

typedef NS_ENUM(NSInteger, ETCConsentAction)
{
    AcceptAll,
    RefuseAll,
    Save
};

// file names
extern NSString *const kTCPublisherRestrictionConfiguration;
extern NSString *const kTCVendorListConfiguration;
extern NSString *const kTCGoogleAtpListConfiguration;
// Notifications keys
extern NSString *const kTCUserInfo_ResetSave;
extern NSString *const kTCShouldDisplayPrivacyCenter;
extern NSString *const kTCUserInfo_SignificantChanges;

extern int const kTCVendorOffset;
extern int const kTCPurposeOffset;
extern int const kTCSpePurposeOffset;
extern int const kTCFeatureOffset;
extern int const kTCSpeFeatureOffset;

// UI ids keys
extern NSString *const kTCDropDownCell;
extern NSString *const kTCVendorDisclosuresCell;
extern NSString *const kTCLabelTitle;
extern NSString *const kTCLabelText;
extern NSString *const kTCVendorCell;
extern NSString *const kTCGoogleVendorCell;
extern NSString *const kTCIABVendorCell;
extern NSString *const kTCCustomVendorCell;
extern NSString *const kTCLabelCell;

// UI styles keys
extern int const BOLD_LABEL_STYLE;
extern int const TEXT_LABEL_STYLE;
extern int const LINK_LABEL_STYLE;

// Consents values
extern NSString *const TC_CONSENT_ACCEPTED;
extern NSString *const TC_CONSENT_REFUSED;
extern NSString *const TC_CONSENT_MANDATORY;
extern NSString *const TC_CONSENT_MANDATORY_ACCEPT;

// Statistics
extern NSString *const TC_SITE_ID;
extern NSString *const TC_ID_PRIVACY;
extern NSString *const TC_PRIVACY_VERSION;
extern NSString *const TC_PRIVACY_BEACON;
extern NSString *const TC_PRIVACY_ACTION;
extern NSString *const TC_OPT_IN_CATEGORIES;
extern NSString *const TC_OPT_OUT_CATEGORIES;
extern NSString *const TC_OPT_IN_TO_ALL;
extern NSString *const TC_USER_TCPID;
extern NSString *const TC_OPT_OUT;
extern NSString *const TC_OPT_IN_VENDORS;
extern NSString *const TC_OPT_IN_TO_ALL_VENDORS;
extern NSString *const TC_TYPE_ACTION;
extern NSString *const TC_USER_AGENT;

@end
#endif
