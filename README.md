# CommandersAct's TCConsent flutter plugin

Commanders Act's TCConsent mobile lib

## Getting Started

If you encounter any issues or have any feedback, please report them to us so that we can improve the software for future releases.

It is important to have a look on both [Android](https://github.com/CommandersAct/AndroidV5/tree/master/TCConsent) and [IOS](https://github.com/CommandersAct/iosv5/tree/master/TCConsent) documentation to understand the basic functionning of the library. 

## Installation : 

We'll be releasing this plugin on pub.dev later on, for now you'll need to have a git plugin dependency. 

On your pubspec.yaml, set : 

```
dependencies:

  tc_consent_plugin:
    git:
      url: https://github.com/CommandersAct/tc-consent-plugin.git
      ref: *.*.*
```

if you're using IAB, you'll need to use `TCConsent_IAB` variant available on `*.*.*-iab` releases.

```
dependencies:

  tc_consent_plugin:
    git:
      url: https://github.com/CommandersAct/tc-consent-plugin.git
      ref: *.*.*-iab
```

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
  TCDebug().setDebugLevel(TCLogLevel.TCLogLevel_Verbose);// optional but recommended to enable logs
  TCConsent consent = TCConsent();
  consent.setSiteIDPrivacyID(SITE_ID, PRIVACY_ID);
   consent.showPrivacyCenter(); // to show Privacy Center for example
```

You can block the modal view of the privacy center by setting the following property to true : 

```
  consent.blockIOSPrivacyCenterDropOut = true;
```

[Non - IAB] you can use the following property to disable auto-privacy saving when exiting the privacy center : 

```
  consent.saveIOSConsentOnPrivacyCenterDropDown = false;
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
Please set your privacy callbacks BEFORE calling `setSiteIDPrivacyID`. 

```
    consent.setSiteIDPrivacyID(siteID, privacyID);
    TCConsent.consentUpdated = (m) => {
      print('The value of the consent is: $m')
    };
```

### TCConsentAPI : 

We created several methods to check given consent. They are simple, but make it easier to work with consent information at any given time. You'll find those in the class TCConsentAPI, more info [HERE](https://github.com/CommandersAct/iOSV5/tree/master/TCConsent#consent-internal-api). 


### Forward Consent to Firebase (GCM) : 

The following documentation outlines the complete procedure for forwarding user consent collected via CommandersAct’s CMP to Firebase Analytics on both iOS and Android through Google Consent Mode.


It covers the required JSON configuration, SDK integration steps, category-mapping details, and verification methods.

[See the detailed guide](./res/GCM_documentation.md)

## Demo App : 

A full example of a flutter application that implements the bridge is available in the following repository : 

https://github.com/CommandersAct/TCMobileDemo-flutter.


# Support & Contact : 

Support : support@commandersact.com

http://www.commandersact.com

Commanders Act | 7b rue taylor - 75010 PARIS - France

![Commanders Act logo](res/ca_logo.png)
