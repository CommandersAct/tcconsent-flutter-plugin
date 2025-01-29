package com.tagcommander.tc_consent_plugin;

import android.content.Context;
import android.content.Intent;

import androidx.annotation.NonNull;

import com.tagcommander.lib.consent.ETCConsentAction;
import com.tagcommander.lib.consent.ETCConsentSource;
import com.tagcommander.lib.consent.TCConsent;
import com.tagcommander.lib.consent.TCConsentAPI;
import com.tagcommander.lib.consent.TCPrivacyCallbacks;
import com.tagcommander.lib.consent.TCPrivacyCenter;
import com.tagcommander.lib.core.TCUser;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** TCConsentPlugin */
public class TCConsentPlugin implements FlutterPlugin, MethodCallHandler, TCPrivacyCallbacks {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Context context;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding)
  {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "tc_consent_flutter_plugin");
    channel.setMethodCallHandler(this);
    context = flutterPluginBinding.getApplicationContext();
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    @SuppressWarnings("unchecked")
    HashMap<String, Object> schemes =  new HashMap<>();

    switch (call.method)
    {
      case "setSiteIDPrivacyID":
        Integer siteID = call.argument("siteID");
        Integer privacyID = call.argument("privacyID");
        initTCConsent(siteID, privacyID, context);
        schemes.put("user", getTCUserJson());
        result.success(schemes);
        break;
      case "refuseAllConsent":
        TCConsent.getInstance().refuseAllConsent();
        result.success(null);
        break;
      case "acceptAllConsent":
        TCConsent.getInstance().acceptAllConsent();
        result.success(null);
        break;
      case "showPrivacyCenter":
        Intent PCM = new Intent(context, TCPrivacyCenter.class);
        PCM.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        context.startActivity(PCM);
        result.success(null);
        break;
      case "useAcString":
        Boolean shouldUseAcString = call.argument("useAcString");
        TCConsent.getInstance().useAcString(shouldUseAcString);
        result.success(null);
        break;
      case "initWithCustomPCM":
        Integer siteId = call.argument("siteID");
        Integer privacyId = call.argument("privacyID");
        TCConsent.getInstance().initWithCustomPCM(siteId, privacyId, context);
        schemes.put("user", getTCUserJson());
        result.success(schemes);
        break;
      case "setConsentDuration":
        Double consentDuration = call.argument("months");
        TCConsent.getInstance().setConsentDuration(consentDuration.floatValue());
        result.success(null);
        break;
      case "useCustomPublisherRestrictions":
        TCConsent.getInstance().useCustomPublisherRestrictions();
        result.success(null);
        break;
      case "saveConsentFromPopUp":
        Map<String, String> popUpConsent = call.argument("consent");
        TCConsent.getInstance().saveConsentFromPopUp(popUpConsent);
        result.success(null);
        break;
      case "saveConsent":
        Map<String, String> consent = call.argument("consent");
        TCConsent.getInstance().saveConsent(consent);
        result.success(null);
        break;
      case "saveConsentFromConsentSourceWithPrivacyAction":
        ETCConsentSource source = call.argument("source").equals("ETCConsentSource.popUp") ? ETCConsentSource.Popup : ETCConsentSource.PrivacyCenter;
        String actionValue = call.argument("action");
        ETCConsentAction action = actionValue.equals("ETCConsentAction.acceptAll") ? ETCConsentAction.AcceptAll : (actionValue.equals("ETCConsentAction.refuseAll") ? ETCConsentAction.RefuseAll : ETCConsentAction.Save);
        Map<String, String> saveConsent = call.argument("consent");
        TCConsent.getInstance().saveConsentFromConsentSourceWithPrivacyAction(saveConsent, source, action);
        result.success(null);
        break;
      case "statEnterPCToVendorScreen":
        TCConsent.getInstance().statEnterPCToVendorScreen();
        result.success(null);
        break;
      case "statShowVendorScreen":
        TCConsent.getInstance().statShowVendorScreen();
        result.success(null);
        break;
      case "statViewPrivacyPoliciesFromPrivacyCenter":
        TCConsent.getInstance().statViewPrivacyPoliciesFromPrivacyCenter();
        result.success(null);
        break;
      case "statViewPrivacyCenter":
        TCConsent.getInstance().statViewPrivacyCenter();
        result.success(null);
        break;
      case "statViewBanner":
        TCConsent.getInstance().statViewBanner();
        result.success(null);
        break;
      case "statViewPrivacyPoliciesFromBanner":
        TCConsent.getInstance().statViewPrivacyPoliciesFromBanner();
        result.success(null);
        break;
      case "getConsentAsJson":
        result.success(TCConsent.getInstance().getConsentAsJson());
        break;
      case "resetSavedConsent":
        TCConsent.getInstance().resetSavedConsent();
        schemes.put("user", getTCUserJson());
        result.success(schemes);
        break;
      case "setLanguage":
        String languageCode = call.argument("languageCode");
        TCConsent.getInstance().setLanguage(languageCode);
        result.success(null);
        break;
      case "isConsentAlreadyGiven":
        result.success(TCConsentAPI.isConsentAlreadyGiven(context));
        break;
      case "getAllAcceptedConsent":
        result.success(TCConsentAPI.getAllAcceptedConsent(context));
        break;
      case "getLastTimeConsentWasSaved":
        result.success(TCConsentAPI.getLastTimeConsentWasSaved(context));
        break;
      case "isCategoryAccepted":
        Integer category_id = call.argument("id");
        result.success(TCConsentAPI.isCategoryAccepted(category_id, context));
        break;
      case "isVendorAccepted":
        Integer vendor_id = call.argument("id");
        result.success(TCConsentAPI.isVendorAccepted(vendor_id, context));
        break;
      case "isIABPurposeAccepted":
        Integer iab_purpose_id = call.argument("id");
        result.success(TCConsentAPI.isIABPurposeAccepted(iab_purpose_id, context));
        break;
      case "isIABVendorAccepted":
        Integer iab_vendor_id = call.argument("id");
        result.success(TCConsentAPI.isIABVendorAccepted(iab_vendor_id, context));
        break;
      case "isIABSpecialFeatureAccepted":
        Integer iab_spec_feature_id = call.argument("id");
        result.success(TCConsentAPI.isIABSpecialFeatureAccepted(iab_spec_feature_id, context));
        break;
      case "getAcceptedCategories":
        result.success(TCConsentAPI.getAcceptedCategories(context));
        break;
//      case "getAcceptedGoogleVendors":
//        result.success(TCConsentAPI.getAcceptedGoogleVendors(context));
//        break;
      case "shouldDisplayPrivacyCenter":
        result.success(TCConsentAPI.shouldDisplayPrivacyCenter(context));
        break;
        case "deactivateAndroidBackButton":
          result.success(TCConsent.getInstance().deactivateBackButton = true);
          break;
      default:
        result.notImplemented();
    }
  }

  private String getTCUserJson()
  {
    try
    {
      TCUser user = TCUser.getInstance();
      JSONObject json = TCUser.getInstance().getJsonObject();
      json.put("consentID", user.consentID);
      json.put("consent_vendors", new JSONObject(user.getConsentVendors()));
      json.put("consent_categories", new JSONObject(user.getConsentCategories()));
      json.put("external_consent", new JSONObject(user.getExternalConsent()));
      return json.toString();
    } catch (JSONException e)
    {
      e.printStackTrace();
    }
    return "";
  }

  private void initTCConsent(int siteID, int privacyId, Context context)
  {
    TCConsent.getInstance().registerCallback(this);
    TCConsent.getInstance().setSiteIDPrivacyIDAppContext(siteID, privacyId, context);
  }

  @Override
  public void consentUpdated(Map<String, String> consent)
  {
    HashMap<String, Object> map = new HashMap<>();
    map.put("consent", consent);
    map.put("user", getTCUserJson());

    channel.invokeMethod("consentUpdated", map);
  }

  @Override
  public void consentOutdated() {
    channel.invokeMethod("consentOutdated", null);
  }

  @Override
  public void consentCategoryChanged()
  {
    channel.invokeMethod("consentCategoryChanged", null);
  }

  @Override
  public void significantChangesInPrivacy()
  {
    channel.invokeMethod("significantChangesInPrivacy", null);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
