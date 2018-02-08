---
title: Installation Guide
weight: 10
pre: "<b>1. </b>"
---

* [Environment](#env)
* [Use of IDFA](#idfa)
* [Installation using CocoaPods](#cocoapods)
* [Installation utilizing carthage](#carthage)
* [AdSupport.framework usage settings](#adsupport)
* [Other build settings](#buildsettings)
* [Installation in the Swift project](#swiftpj)

This page describes the RFP iOS SDK installation procedure.

<a name="env"></a>
## Environment
* iOS8.0 or later
* Xcode8.3 or later

<a name="idfa"></a>
## Use of IDFA

This SDK uses IDFA for measuring advertising results.

See [FAQ](../faq/#info) for details on information acquired from terminal.

<a name="cocoapods"></a>
## Installation using CocoaPods

You can use the SDK by entering the information as follows in Podfile, and using `pod install`.

```
pod 'RFP-iOS-SDK'
```

<a name="carthage"></a>
## Installation using Carthage

Add the following to Cartfile and execute `carthage update`.

```
github "fout/RFP-iOS-SDK"
```

See [Carthage README.md](https://github.com/Carthage/Carthage/blob/master/README.md) for details on Carthage project settings.

<a name="adsupport"></a>
## AdSupport.framework user settings

Set AdSupport.Framework using the following procedure.

1. Select the project file

2. Select the build target

3. Select the Build Phase tab

4. Click the + button on the Link Binary with Libraries section

5. Select AdSupport.framework

6. Click the Add button

<a name="buildsettings"></a>
## Other build settings

Perform the `Other Linker Flag` settings according to the following procedures.

1. Select the project file

2. Select the build target

3. Select the Build Settings tab

4. Search and select Other Linker Flags

5.Add the  `-ObjC` flag

This completes the installation.

<a name="swiftpj"></a>
## Installation in the Swift project

The `Bridging-Header.h` file is required.

Refer to the following.

```objc
// RFP-Bridging-Header.h
#ifndef YourProject_Swift_RFP_Bridging_Header_h
#define YourProject_Swift_RFP_Bridging_Header_h
#import <RFP/RFP.h>
#import <RFP/RFPInstreamAdLoader.h>
#import <RFP/RFPInstreamInfoModel.h>
#import <RFP/RFPPlayerControl.h>
#import <RFP/RFPExceptionDelegate.h>
#endif
```

- Please note that it is necessary to enter `$(SRCROOT)/$(PROJECT)/RFP-Bridging-Header.h` in the  `Objective-C Bridging Header`property.

