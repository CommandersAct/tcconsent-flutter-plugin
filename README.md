# CommandersAct's TCConsent flutter plugin

A beta version of Commanders Act's TCConsent mobile lib

## Getting Started

This is a beta release, which means that the software is still in development and may contain bugs, errors, or other issues that could affect its performance or reliability. We recommend that you use this software for testing and evaluation purposes only, and not in a production environment or for critical workloads.


While we have made every effort to ensure the quality and stability of this beta release, we cannot guarantee that it will work perfectly in every situation. If you encounter any issues or have any feedback, please report them to us so that we can improve the software for future releases.

It is important to have a look on both [Android](https://github.com/CommandersAct/AndroidV5/tree/master/TCConsent) and [IOS](https://github.com/CommandersAct/iosv5/tree/master/TCConsent) documentation to understand the basic functionning of the library. 

## Installation : 

We'll be releasing this plugin on pub.dev once we finish our beta phase. as for now, you'll need to have a git plugin dependency. 

On your pubspec.yaml, set : 

```
dependencies:

  tc_consent_plugin:
    git:
      url: https://github.com/CommandersAct/tc-consent-plugin.git
      ref: master
```

if you're using IAB, you'll need to use `TCConsent_IAB` variant available on `with_iab` branch.

```
dependencies:

  tc_consent_plugin:
    git:
      url: https://github.com/CommandersAct/tc-consent-plugin.git
      ref: with_iab
```

### [iOS only] manually linking TCCore :
Since Flutter doesn't currently fully support SPM dependency, you'll need to manually link our TCCore.xcframework to both your `tc_consent_plugin` target (and any other tc_* plugin target that you are using) & your `Runner` target on xcode. 

More info here :   

[xcframework Linking](https://github.com/CommandersAct/TCMobileDemo-flutter/blob/master/xcframework_linking.md)

## Configuration files :

Depending on your use case, you may need to include the following json files into your app : 

- **if you are using our Privacy Center**: 

   Make sure you've put your version of the `privacy.json`

- **if you are using IAB**: 
   
   you'll need an offline version of `vendor-list.json`, `purposes-*.json` (if you are using a translation) & `google-atp-list.json` if you wanna use google ACString (please check native documentation for more info).
   

jsons files path : 

- **iOS** : ```app/ios/Runner/*.json```  

  make sure that they're included in your Runner main bundle.

- **Android** : ```app/android/app/src/main/assets/*.json```.

### Usage : 

Simillar to Android and iOS SDKs, you'll need to create a TCConsent() instance and then initialise it by calling `setSiteIDPrivacyID` method.

Please have a look on `lib/tc_consent.dart` & `example/lib/main.dart` for more details. 

```
  TCConsent consent = TCConsent();
  consent.setSiteIDPrivacyID(SITE_ID, PRIVACY_ID);
```

### Privacy Callbacks : 

Privacy callbacks are available as parameters in your TCConsent instance. 

```
class TCConsent
{
....
  static Function(Map? m)? consentUpdated;
  static Function? consentOutdated;
  static Function? consentCategoryChanged;
  static Function? significantChangesInPrivacy;

....
```

# Demo app :

A demo app is available [Here](https://github.com/CommandersAct/TCMobileDemo-flutter)
