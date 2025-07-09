
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:tccore_plugin/TCUser.dart';

enum ETCConsentSource {
  popUp, privacyCenter
}

enum ETCConsentAction {
  acceptAll, refuseAll, save
}

class TCConsent
{
  static const MethodChannel tcChannel = MethodChannel('tc_consent_flutter_plugin');
  static Function(Map? m)? consentUpdated;
  static Function? consentOutdated;
  static Function? consentCategoryChanged;
  static Function? significantChangesInPrivacy;
  static bool _blockIOSPrivacyCenterDropOut = false;
  static bool _saveIOSConsentOnPrivacyCenterDropDown = true;

  Future<void> setSiteIDPrivacyID(int siteID, int privacyID) async
  {
    tcChannel.setMethodCallHandler(privacyCallbackHandler);
    Map schemes = await tcChannel.invokeMethod('setSiteIDPrivacyID', {'siteID': siteID, 'privacyID': privacyID});
    _refreshTCUser(schemes);
  }

  Future<void> acceptAllConsent() async
  {
    await tcChannel.invokeMethod('acceptAllConsent');
  }

  Future<void> refuseAllConsent() async
  {
    await tcChannel.invokeMethod('refuseAllConsent');
  }

  Future<void> showPrivacyCenter() async
  {
    await tcChannel.invokeMethod('showPrivacyCenter');
  }

  Future<void> useACString(bool useAcString) async
  {
    await tcChannel.invokeMethod('useAcString', {'useAcString' : useAcString});
  }

  Future<void> initWithCustomPCM(int siteID, int privacyID) async
  {
    Map schemes = await tcChannel.invokeMethod('initWithCustomPCM', {'siteID' : siteID, 'privacyID' : privacyID});
    _refreshTCUser(schemes);
  }

  Future<void> setConsentDuration(double months) async
  {
    await tcChannel.invokeMethod('setConsentDuration', {'months' : months});
  }

  Future<void> useCustomPublisherRestrictions() async
  {
    await tcChannel.invokeMethod('useCustomPublisherRestrictions');
  }

  Future<void> saveConsentFromPopUp(Map consent) async
  {
    await tcChannel.invokeMethod('saveConsentFromPopUp', {'consent' : consent});
  }

  Future<void> saveConsent(Map consent) async
  {
    await tcChannel.invokeMethod('saveConsent', {'consent' : consent});
  }

  Future<void> saveConsentFromConsentSourceWithPrivacyAction(Map consent, ETCConsentSource source, ETCConsentAction action ) async
  {
    await tcChannel.invokeMethod('saveConsentFromConsentSourceWithPrivacyAction', {'consent' : consent, 'source' : source.toString(), 'action' : action.toString()});
  }

  Future<void> statEnterPCToVendorScreen() async
  {
    await tcChannel.invokeMethod('statEnterPCToVendorScreen');
  }

  Future<void> statShowVendorScreen() async
  {
    await tcChannel.invokeMethod('statShowVendorScreen');
  }

  Future<void> statViewPrivacyPoliciesFromPrivacyCenter() async
  {
    await tcChannel.invokeMethod('statViewPrivacyPoliciesFromPrivacyCenter');
  }

  Future<void> statViewPrivacyCenter() async
  {
    await tcChannel.invokeMethod('statViewPrivacyCenter');
  }

  Future<void> statViewBanner() async
  {
    await tcChannel.invokeMethod('statViewBanner');
  }

  Future<String> getConsentAsJson() async
  {
    return await tcChannel.invokeMethod('getConsentAsJson');
  }

  Future<void> resetSavedConsent() async
  {
    Map schemes = await tcChannel.invokeMethod('resetSavedConsent');
    _refreshTCUser(schemes);
  }

  Future<void> setLanguage(String languageCode) async
  {
    await tcChannel.invokeMethod('setLanguage', {'languageCode' : languageCode});
  }

  Future<void> statViewPrivacyPoliciesFromBanner() async
  {
    await tcChannel.invokeMethod('statViewPrivacyPoliciesFromBanner');
  }

  Future<void> privacyCallbackHandler(MethodCall methodCall) async
  {
    switch (methodCall.method)
    {
      case "consentUpdated" :
        _refreshTCUser(methodCall.arguments);
        consentUpdated?.call(methodCall.arguments['consent']);
        break;
      case "consentOutdated" :
        consentOutdated?.call();
        break;
      case "consentCategoryChanged" :
        consentCategoryChanged?.call();
        break;
      case "significantChangesInPrivacy" :
        significantChangesInPrivacy?.call();
        break;
      default:
        return;
    }
  }

  void _refreshTCUser(Map schemes)
  {
    if (defaultTargetPlatform  == TargetPlatform.android)
    {
      TCUser.fromJson(jsonDecode(schemes["user"]));
    }
    else if (defaultTargetPlatform  == TargetPlatform.iOS)
    {
      TCUser.fromJson(schemes["user"]);
    }
  }

  set blockIOSPrivacyCenterDropOut(bool value) {
    if (defaultTargetPlatform  == TargetPlatform.iOS)
    {
      _blockIOSPrivacyCenterDropOut = value;
      tcChannel.invokeMethod("blockIOSPrivacyCenterDropOut", {"value" : _blockIOSPrivacyCenterDropOut});
    }
  }

  bool get blockIOSPrivacyCenterDropOut => _blockIOSPrivacyCenterDropOut;

  set saveIOSConsentOnPrivacyCenterDropDown(bool value) {
    if (defaultTargetPlatform  == TargetPlatform.iOS)
    {
      _saveIOSConsentOnPrivacyCenterDropDown = value;
      tcChannel.invokeMethod("saveIOSConsentOnPrivacyCenterDropDown", {"value" : _saveIOSConsentOnPrivacyCenterDropDown});
    }
  }

  bool get saveIOSConsentOnPrivacyCenterDropDown => _saveIOSConsentOnPrivacyCenterDropDown;

  /// Should be called if user wants to disable the Android
  /// back button when showing Privacy Center
  void deactivateAndroidBackButton() {
    if(defaultTargetPlatform == TargetPlatform.android){
      tcChannel.invokeMethod('deactivateAndroidBackButton');
    }
  }
}