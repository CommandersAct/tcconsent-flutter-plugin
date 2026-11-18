## 1.6.0

- [iOS] Native SDK now pulled with Swift Package Manager from [iOSV5-spm](https://github.com/CommandersAct/iOSV5-spm) (5.6.0). CocoaPods is no longer supported: the podspec has been removed.
- [iOS] Minimum iOS version is now 15.0.
- Minimum Flutter version is now 3.44.0.
- Requires tccore_plugin 1.4.0.

## 1.5.7

- Fixed Privacy Center not showing on apps using UIScene lifecycle, required by latest Flutter versions.
- Updated android dependencies.

## 1.5.6

- Update Android libraries :
    ~ Binaries dependencies leak fix. 

## 1.5.5

- Update tccore_plugin dart dependency. 

## 1.5.4

- Update Android libraries
    ~ Enhance hits metadata, adding right Http content-type headers. 
    ~ /!\ Requires TCIAB 5.1.0+
	+ TCF IAB v2.3 support.

- Update iOS libraries
    ~ Enhance hits metadata, adding right Http content-type headers. 
	~ vendors count fix for categories.
	+ Supporting IAB TCF v2.3.

## 1.2.3

* adding TCConsentAPI class

## 1.2.2

* preventing the dismissal of the privacy center modal

## 1.2.1

* Dependency on TCCore switched to cocoapod.

## 1.2.0

* Dependency on TCCore switched to cocoapod.


## 0.1.1

* TCUser is moved inside a new trasitive TCCore dependency
* new IAB variant

## 1.0.0

* Initial TCConsent flutter plugin release