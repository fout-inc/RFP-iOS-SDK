---
title: インストールガイド
weight: 10
pre: "<b>1. </b>"
---
* [環境](#env)
* [IDFAの使用について](#idfa)
* [CocoaPodsを利用してインストール](#cocoapods)
* [carthageを利用してインストール](#carthage)
* [AdSupport.frameworkの利用設定](#adsupport)
* [その他ビルド設定](#buildsettings)
* [Swiftプロジェクトへのインストール](#swiftpj)

本ページではRFP iOS SDKのインストール手順について記述します。

<a name="env"></a>
## 環境
* iOS8.0以上
* Xcode8.3以上

<a name="idfa"></a>
## IDFAの使用について

本SDKは広告の成果測定のため IDFA を利用しています。

端末から取得する情報につきまして、詳しくは[FAQ](../faq/#info)をご覧ください。

<a name="cocoapods"></a>
## CocoaPodsを利用してインストール

Podfileに以下のように記入し `pod install` することで SDK がご利用いただけます。

```
pod 'RFP-iOS-SDK'
```

<a name="carthage"></a>
## Carthageを利用してインストール

Cartfileに下記を追記し、`carthage update`を実行してください。

```
github "fout/RFP-iOS-SDK"
```

Carthageのプロジェクト設定につきまして、詳しくは[Carthage README.md](https://github.com/Carthage/Carthage/blob/master/README.md)をご覧ください。

<a name="adsupport"></a>
## AdSupport.frameworkの利用設定

下記手順でAdSupport.Frameworkの設定を行って下さい。

1. プロジェクトファイルを選択

2. ビルドターゲットを選択

3. Build Phase タブを選択

4. Link Binary with Libraries セクションの + ボタンをクリック

5. AdSupport.framework を選択

6. Add ボタンをクリック

<a name="buildsettings"></a>
## その他ビルド設定

下記手順で`Other Linker Flag`の設定を行って下さい。

1. プロジェクトファイルを選択

2. ビルドターゲットを選択

3. Build Settings タブを選択

4. Other Linker Flags を検索、選択

5. `-ObjC` フラグを追加

これでインストールは完了です。

<a name="swiftpj"></a>
## Swiftプロジェクトへのインストール

`Bridging-Header.h` ファイルが必要です。

以下を参考にしてください。

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

- `Objective-C Bridging Header` プロパティに、`$(SRCROOT)/$(PROJECT)/RFP-Bridging-Header.h` などを入力する必要がある点に注意ください。
