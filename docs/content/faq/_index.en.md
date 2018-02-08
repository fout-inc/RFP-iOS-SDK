---
title: FAQ
weight: 30
pre: "<b>3. </b>"
---

* [Inquiry point](#howto)
* [What kind of information is acquired from the terminal？](#info)
* [What is the meaning of the version number？](#version)

<a name="howto"></a>
## Inquiry point

- Please direct inquiries to the representative

<a name="info"></a>
## What kind of information is acquired from the terminal?

- Acquires the following information

| Name | API | Details |
| --- | --- | --- |
| IDFA | `ASIdentifierManager advertisingIdentifier` | Do not acquire when user is setting optput|
| OS | `UIDevice systemName` | `iPhone OS` etc. |
| OS version | `UIDevice systemVersion` | `5.0.1 `, `7.1` etc. |
| Terminal name | `utsname machine` | `iPhone4,1`, `iPhone7,1` etc.|
| Language settings | `NSLocale preferredLanguages [0]` | `ja`, `en` etc. |
| Country code | `NSLocale NSLocaleCountryCode` | `JP`, `US` etc. |

<a name="version"></a>
## What is the meaning of the version number?
Follow [semver](http://semver.org/)

