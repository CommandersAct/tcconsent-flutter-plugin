
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

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

  Future<void> setSiteIDPrivacyID(int siteID, int privacyID) async
  {
    tcChannel.setMethodCallHandler(privacyCallbackHandler);
    await tcChannel.invokeMethod('setSiteIDPrivacyID', {'siteID': siteID, 'privacyID': privacyID});
  }

  Future<void> acceptAllConsent() async {
    await tcChannel.invokeMethod('acceptAllConsent');
  }

  Future<void> refuseAllConsent() async {
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
    await tcChannel.invokeMethod('initWithCustomPCM', {'siteID' : siteID, 'privacyID' : privacyID});
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
    await tcChannel.invokeMethod('resetSavedConsent');
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
}
