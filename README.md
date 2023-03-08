# CommandersAct's TCConsent flutter plugin

A beta version of Commanders Act's TCConsent mobile lib

## Getting Started

This is a beta release, which means that the software is still in development and may contain bugs, errors, or other issues that could affect its performance or reliability. We recommend that you use this software for testing and evaluation purposes only, and not in a production environment or for critical workloads.


While we have made every effort to ensure the quality and stability of this beta release, we cannot guarantee that it will work perfectly in every situation. If you encounter any issues or have any feedback, please report them to us so that we can improve the software for future releases.

It is important to have a look on both [Android](https://github.com/CommandersAct/AndroidV5/tree/master/TCConsent) and [IOS](https://github.com/CommandersAct/iosv5/tree/master/TCConsent) documentation to understand the basic functionning of the library. 


## Setup :

After adding the sdk to your project, and depending on your use case, you'll need to :

Set the needed jsons (depending on your use case) in the following paths :

- for iOS : ```app/ios/Runner/*.json```  (& make sure that they are included in your Runner main bundle).
- for Android : ```app/android/app/src/main/assets/*.json```.

Needed Jsons : 
- [if you are using our Privacy Center ] : Make sure you've put your version of the `privacy.json`

- [if you are using IAB] : Make sure to have to do the same for the `vendor-list.json`, `purposes-*.json` (if you are using a translation) & `google-atp-list.json` if you wanna use google ACString (more info in the official doc mentionned above).

## Usage : 

We'll be releasing this plugin on pub.dev once we finish our beta phase. as for now, you'll need to have a git plugin dependency. 

On your pubspec.yaml, set : 

```
dependencies:

  tc_consent_plugin:
    git:
      url: https://github.com/CommandersAct/tc-consent-plugin.git
      ref: master
```

Simillar to Android and iOS SDKs, you'll need to create a TCConsent() instance and then initialise it by calling `setSiteIDPrivacyID` method.

Please have a look on `lib/tc_consent.dart` for more details. 

# Demo app :

A demo app is available [Here](https://github.com/CommandersAct/TCMobileDemo-flutter)
