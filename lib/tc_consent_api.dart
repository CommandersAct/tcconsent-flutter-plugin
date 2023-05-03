
import 'package:tc_consent_plugin/tc_consent.dart';

class TCConsentAPI
{

  /// Checks if kTCPrivacyConsent is empty.
  ///
  /// @param appContext the application context.
  /// @return true if the consent was already given, false otherwise.
  static Future<bool> isConsentAlreadyGiven() async
  {
    return await TCConsent.tcChannel.invokeMethod('isConsentAlreadyGiven');
  }

  /// Return the epochformatted timestamp of the last time the consent was saved.
  ///
  /// @param appContext the application context.
  /// @return epochformatted timestamp or 0.
  static Future<int> getLastTimeConsentWasSaved() async
  {
    return await TCConsent.tcChannel.invokeMethod('getLastTimeConsentWasSaved');
  }

  /// Check if a Category has been accepted.
  ///
  /// @param ID         the category ID.
  /// @param appContext the application context.
  /// @return true or false.
  static Future<bool> isCategoryAccepted(int ID) async
  {
    return await TCConsent.tcChannel.invokeMethod('isCategoryAccepted', {"id" : ID});
  }

  /// Check if a vendor has been accepted.
  ///
  /// @param ID         the vendor ID.
  /// @param appContext the application context.
  /// @return true or false.
  static Future<bool> isVendorAccepted(int ID) async
  {
    return await TCConsent.tcChannel.invokeMethod('isVendorAccepted', {"id" : ID});
  }

  /// Check if a purpose has been accepted.
  ///
  /// @param ID         the purpose ID.
  /// @param appContext the application context.
  /// @return true or false.
  static Future<bool> isIABPurposeAccepted(int ID) async
  {
    return await TCConsent.tcChannel.invokeMethod('isIABPurposeAccepted', {"id" : ID});
  }

  /// Check if a vendor has been accepted.
  ///
  /// @param ID         the vendor ID.
  /// @param appContext the application context.
  /// @return true or false.
  static Future<bool> isIABVendorAccepted(int ID) async
  {
    return await TCConsent.tcChannel.invokeMethod('isIABVendorAccepted', {"id" : ID});
  }

  /// Check if a special feature has been accepted.
  ///
  /// @param ID         the vendor ID.
  /// @param appContext the application context.
  /// @return true or false.
  static Future<bool> isIABSpecialFeatureAccepted(int ID) async
  {
    return await TCConsent.tcChannel.invokeMethod('isIABSpecialFeatureAccepted', {"id" : ID});
  }

  /// Get the list of all accepted categories.
  ///
  /// @param appContext the application context.
  /// @return a List of PRIVACY_CAT_IDs.
  static Future<List<dynamic>> getAcceptedCategories() async
  {
    return await TCConsent.tcChannel.invokeMethod('getAcceptedCategories');
  }

  // static Future<List<dynamic>> getAcceptedGoogleVendors() async
  // {
  //   return await TCConsent.tcChannel.invokeMethod('getAcceptedGoogleVendors');
  // }

  /// Get the list of everything that was accepted.
  ///
  /// @param appContext the application context.
  /// @return a List of PRIVACY_VEN_IDs and PRIVACY_CAT_IDs.
  static Future<List<dynamic>> getAllAcceptedConsent() async
  {
    return await TCConsent.tcChannel.invokeMethod('getAllAcceptedConsent');
  }

  /// Checks if we should display privacy center for any reason.
  /// @param context the application context.
  /// @return True or False.
  static Future<bool> shouldDisplayPrivacyCenter() async
  {
    return await TCConsent.tcChannel.invokeMethod('shouldDisplayPrivacyCenter');
  }
}