//
//  TCFirebaseConsentDelegate.h
//  Pods
//
//  Created by Abdelhakim SAID on 25/06/2025.
//
#import <Foundation/Foundation.h>

@protocol TCFirebaseConsentDelegate <NSObject>

@required
- (void) firebaseConsentChanged: (NSDictionary<NSString *,NSNumber *> *) firebaseConsent;
@end
