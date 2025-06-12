//
//  TCFirebaseDelegate.h
//
//  Created by Abdelhakim SAID on 11/06/2025.
//

#import <Foundation/Foundation.h>

@protocol TCFirebaseDelegate <NSObject>

@required
- (void) firebaseConsentChanged: (NSDictionary<NSString *,NSNumber *> *) firebaseConsent;
@end
