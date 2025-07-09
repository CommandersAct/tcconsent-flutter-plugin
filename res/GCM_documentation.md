# Google Consent Mode (GCM) × CommandersAct

A concise, **platform‑independent** guide for forwarding user consent from CommandersAct to Firebase Analytics via Google Consent Mode (GCM) in a Flutter app.

---

## 1. Overview

GCM lets you dynamically adapt Firebase Analytics (and Google Ads) behaviour to the user’s privacy choices. CommandersAct collects consent using its CMP SDK and exposes it through the **TCFirebase** bridge.  The steps below wire everything together so that:

1. **CommandersAct** receives the user’s IAB TCF choices.
2. Consent values are mapped to Firebase categories (ad storage, analytics storage, etc.).
3. Firebase SDK applies these settings **before** any data is sent to Google.


> ℹ️  Keep your Firebase and CommandersAct packages **up to date**. Replace version numbers shown here with the latest available.

---

## 2. Add *google\_consent\_mode* to `privacy.json`

Create *identical* JSON objects for both platforms:

```jsonc
// app/ios/Runner/privacy.json
// app/android/app/src/main/assets/privacy.json
{
  "google_consent_mode": {
    "use_consent_mode": true,         // Activate GCM forwarding
    "infer_ad_from_tcf": false,       // Don’t auto‑infer IAB categories
    "category_mapping": {
      "ad_storage": 1,                // Categories with 1 → ad_storage
      "ad_user_data": 2,              // Categories with 2 → ad_user_data
      "ad_personalization": 3,        // Categories with 3 → ad_personalization
      "analytics_storage": 4          // Categories with 4 → analytics_storage
    }
  }
}
```

*Change the numeric values* if your custom categories ID mapping differs.

---

## 3. iOS Integration

1. **Add Firebase** to the Runner target, check Firebase documentation for that : https://firebase.google.com/docs/ios/setup. 

2. **Import and conform** to `TCFirebaseConsentDelegate` in *AppDelegate.swift*:

   ```swift
   import UIKit
   import Flutter
   import FirebaseAnalytics
   import tc_consent_plugin

   @UIApplicationMain
   @objc class AppDelegate: FlutterAppDelegate, TCFirebaseConsentDelegate {
     override func application(
       _ application: UIApplication,
       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
     ) -> Bool {
       FirebaseApp.configure()
       return super.application(application, didFinishLaunchingWithOptions: launchOptions)
     }

     // MARK: - TCFirebaseConsentDelegate
     func firebaseConsentChanged(_ consent: [String : NSNumber]!) {
       if let value = consent["analytics_storage"]?.boolValue {
         Analytics.setConsent([.analyticsStorage : value ? .granted : .denied])
       }
       if let value = consent["ad_storage"]?.boolValue {
         Analytics.setConsent([.adStorage : value ? .granted : .denied])
       }
       if let value = consent["ad_user_data"]?.boolValue {
         Analytics.setConsent([.adUserData : value ? .granted : .denied])
       }
       if let value = consent["ad_personalization"]?.boolValue {
         Analytics.setConsent([.adPersonalization : value ? .granted : .denied])
       }
     }
   }
   ```

3. **Verify**: 

Setup Firebase on your app to verbose mode :  [Verify consent settings](https://developers.google.com/tag-platform/security/guides/app-consent?consentmode=advanced&platform=ios#verify_consent_settings).  

Launch the app, click on "Show Privacy Center" -> "accept all", watch the Xcode console. 

You should see:

   ```text
   analytics_storage=granted ...
   ```

---

## 4. Android Integration

1. **Add Firebase Analytics** and CommandersAct to *app/build.gradle*:

   ```gradle
   dependencies {
       implementation 'com.google.firebase:firebase-analytics:21.6.1'   // or newer
       implementation 'com.tagcommander.lib:FirebaseDestination:5.1.2'  // latest
   }
   apply plugin: 'com.google.gms.google-services'
   ```

   Ensure *google-services.json* is in *app/*.

2. **Initialize** in `MainActivity.kt`:

   ```kotlin
   class MainActivity : FlutterActivity() {
       override fun onCreate(savedInstanceState: Bundle?) {
           super.onCreate(savedInstanceState)
           TCFirebase.getInstance().initialize(applicationContext)
       }
   }
   ```

3. **Verify**: Use *adb logcat* or Android Studio’s Logcat with the filter `ConsentDebug`. Google’s [GCM Android verification steps](https://developers.google.com/tag-platform/security/guides/app-consent?consentmode=advanced&platform=android#verify_consent_settings) list expected messages.

---

© 2025 Commanders Act.
