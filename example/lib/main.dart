import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:tc_consent_plugin/tc_consent.dart';
import 'package:tc_consent_plugin/tc_consent_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var SITE_ID = 3311;
  var PRIVACY_ID = 72;
  var mockConsent = {"PRIVACY_CAT_10007": "1", "PRIVACY_CAT_31": "0", "PRIVACY_CAT_10014": "0", "PRIVACY_VEN_2": "0", "PRIVACY_CAT_10019": "0", "PRIVACY_VEN_1": "1"};
  var consent = TCConsent();

  @override
  void initState() {
    super.initState();
    initCallBacks();
    consent.setSiteIDPrivacyID(SITE_ID, PRIVACY_ID);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body:SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildTextButton('Disable save on drop out ', () => {consent.saveIOSConsentOnPrivacyCenterDropDown = false} ),
                buildTextButton('Accept All Consent', consent.acceptAllConsent ),
                buildTextButton('Refuse all consent', consent.refuseAllConsent ),
                buildTextButton('Block privacy Center ',() => {consent.blockIOSPrivacyCenterDropOut = true} ),
                buildTextButton('Show Privacy Center', consent.showPrivacyCenter ),
                buildTextButton('Deactivate Android Back Button on Privacy Center',() {
                  consent.deactivateAndroidBackButton();
                }),
                buildTextButton('Call use AC String',() {consent.useACString(true);} ),
                buildTextButton('Init with Custom Privacy Center',() {consent.initWithCustomPCM(SITE_ID, PRIVACY_ID);} ),
                buildTextButton('Use custom Publisher restrictions',() {consent.useCustomPublisherRestrictions();} ),
                buildTextButton('Set Consent Duration',() {consent.setConsentDuration(6);} ),
                buildTextButton('saveConsentFromPopUp',() {consent.saveConsentFromPopUp(mockConsent);}),
                buildTextButton('saveConsent',() {consent.saveConsent(mockConsent);}),
                buildTextButton('saveConsentFromConsentSourceWithPrivacyAction',() {consent.saveConsentFromConsentSourceWithPrivacyAction(mockConsent, ETCConsentSource.popUp, ETCConsentAction.refuseAll);}),
                buildTextButton('statEnterPCToVendorScreen',consent.statEnterPCToVendorScreen),
                buildTextButton('statShowVendorScreen',consent.statShowVendorScreen),
                buildTextButton('statViewPrivacyPoliciesFromPrivacyCenter',consent.statViewPrivacyPoliciesFromPrivacyCenter),
                buildTextButton('statViewPrivacyCenter',consent.statViewPrivacyCenter),
                buildTextButton('statViewBanner',consent.statViewBanner),
                buildTextButton('resetSavedConsent',consent.resetSavedConsent),
                buildTextButton('statViewPrivacyPoliciesFromBanner',consent.statViewPrivacyPoliciesFromBanner),
                buildTextButton('setLanguage',() {consent.setLanguage("fr");}),
                buildTextButton('getConsentAsJson',() async {
                  var savedConsent = await consent.getConsentAsJson();
                }),
                buildTextButton('shouldDisplayPrivacyCenter',() async {
                  var val = await TCConsentAPI.shouldDisplayPrivacyCenter();
                  print("shouldDisplayPrivacyCenter = ${val}");
                }),
                buildTextButton('getAllAcceptedConsent',() async {
                  var val = await TCConsentAPI.getAllAcceptedConsent();
                  print("getAllAcceptedConsent = ${val}");
                }),
                // buildTextButton('getAcceptedGoogleVendors',() async {
                //   var val = await TCConsentAPI.getAcceptedGoogleVendors();
                //   print("getAcceptedGoogleVendors = ${val}");
                // }),
                buildTextButton('getAcceptedCategories',() async {
                  var val = await TCConsentAPI.getAcceptedCategories();
                  print("getAcceptedCategories = ${val}");
                }),
                buildTextButton('isIABSpecialFeatureAccepted',() async {
                  var val = await TCConsentAPI.isIABSpecialFeatureAccepted(1);
                  print("isIABSpecialFeatureAccepted = ${val}");
                }),
                buildTextButton('isIABVendorAccepted',() async {
                  var val = await TCConsentAPI.isIABVendorAccepted(1);
                  print("isIABVendorAccepted = ${val}");
                }),
                buildTextButton('isIABPurposeAccepted',() async {
                  var val = await TCConsentAPI.isIABPurposeAccepted(1);
                  print("isIABPurposeAccepted = ${val}");
                }),
                buildTextButton('isVendorAccepted',() async {
                  var val = await TCConsentAPI.isVendorAccepted(1);
                  print("isVendorAccepted = ${val}");
                }),
                buildTextButton('isCategoryAccepted',() async {
                  var val = await TCConsentAPI.isCategoryAccepted(1);
                  print("isCategoryAccepted = ${val}");
                }),
                buildTextButton('getLastTimeConsentWasSaved',() async {
                  var val = await TCConsentAPI.getLastTimeConsentWasSaved();
                  print("getLastTimeConsentWasSaved = ${val}");
                }),

                buildTextButton('isConsentAlreadyGiven',() async {
                  var val = await TCConsentAPI.isConsentAlreadyGiven();
                  print("isConsentAlreadyGiven = ${val}");
                }),


              ],
            ),
          )
        )
        ,
      ),
    );
  }

  Container buildTextButton(String label, Function() f) {
    return     Container(
        margin: const EdgeInsets.only(top: 10.0, right: 34, left: 34),
        child : ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              minimumSize: const Size.fromHeight(50)),
    onPressed: () {f();},
    child: Text(
    label, style: TextStyle(fontSize: 24),
      textAlign: TextAlign.center,

    )));
  }

  void initCallBacks() {
    TCConsent.consentUpdated = (Map? x) => {
      print('Flutter app callback : Consent Updated ! with value : $x')
    };

    TCConsent.consentCategoryChanged = () => {
      print('Flutter app callback : consent Category Changed !')
    };

    TCConsent.consentOutdated = () => {
      print('Flutter app callback : consentOutdated')
    };

    TCConsent.significantChangesInPrivacy = () => {
      print('Flutter app callback : significantChangesInPrivacy')
    };
  }
}
