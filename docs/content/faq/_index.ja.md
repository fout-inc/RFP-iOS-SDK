---
title: FAQ
weight: 30
pre: "<b>3. </b>"
---

* [お問い合わせ先](#howto)
* [端末からどのような情報を取得していますか？](#info)
* [バージョン番号はどういう意味がありますか？](#version)

<a name="howto"></a>
## お問い合わせ先

- 担当者へお問い合わせください

<a name="info"></a>
## 端末からどのような情報を取得していますか？

- 次の情報を取得しています

| 名称 | API | 詳細 |
| --- | --- | --- |
| IDFA | `ASIdentifierManager advertisingIdentifier` | ユーザーがオプトアウト設定をしている場合には取得しない |
| OS | `UIDevice systemName` | `iPhone OS` など |
| OS バージョン | `UIDevice systemVersion` | `5.0.1 `, `7.1` など |
| 端末名称 | `utsname machine` | `iPhone4,1`, `iPhone7,1` など |
| 言語設定 | `NSLocale preferredLanguages [0]` | `ja`, `en` など |
| 国コード | `NSLocale NSLocaleCountryCode` | `JP`, `US` など |

<a name="version"></a>
## バージョン番号はどういう意味がありますか？
[semver](http://semver.org/) に従います
