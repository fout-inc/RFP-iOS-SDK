---
title: CHANGELOG
weight: 40
pre: "<b>4. </b>"
---

## v2.5.1 (2018-01-11)
### Changes & Enhancements
* Transmission improvements
* Performance improvements

## v2.5.0 (2017-12-13)
### Changes & Enhancements
* Add video advertising cache function
* Delete deprecated functions
    - `RFPInstreamAdLoader` - `rfpGetVideoPlayerView:infoModel:`
    - `RFPInstreamAdLoaderDelegate` - `playerReadyToPlay:`
    - `RFPPlayerView`
    - --- ***Move to the following new functions*** ---
    - `RFPInstreamAdLoader` - `getVideoControlWithFrame:infoModel:`
    - `RFPInstreamAdLoaderDelegate` - `readyToPlayWithPlayerControl:`
    - `RFPPlayerControl`
* Implement minor improvements

## v2.4.2 (2017-11-29)
### Bug Fixes
* Fixed the defect in which the browser does not move to a new page when advertisements are clicked, which is present in v2.4.1, in iOS9 (and earlier) versions

## v2.4.1 (2017-11-09)
### Bug Fixes
* Support for defects in which delegate events do not occur when clicking on an advertisement

### Changes & Enhancements
* Implement minor improvements

## v2.4.0 (2017-10-30)
### Bug Fixes
* Support for communications-related crash issues

### Changes & Enhancements
* Support for acquisition of advertising ID
* Implement minor improvements

## v2.3.2 (2017-10-24)
### Bug Fixes
* Support for Video-related crash issues

### Changes & Enhancements
* Implement minor improvements

## v2.3.1 (2017-10-13)
### Bug Fixes
* Fix for problem in which a timing-related exception occurred when playing back video

## v2.3.0 (2017-10-13)
### Changes & Enhancements
* Implement minor improvements

## v2.2.1 (2017-10-11)
### Bug Fixes
* Fix for the problem in which ScrollToTop on the calling side responds during full screen display

## v2.2.0 (2017-10-02)
### Changes & Enhancements
* iPhone X support
* Addition of content acquisition processing exception

## v2.1.2 (2017-09-19)
### Changes & Enhancements
* Implement minor improvements

## v2.1.1 (2017-09-05)
### Changes & Enhancements
* Improved functionality for full screen video display (close with up/down swipe)
* Other performance improvements

## v2.1.0 (2017-08-25)
### Changes & Enhancements
* Add button name acquisition for custom infeed advertising
* Simplification of Video playback interface

## v2.0.1 (2017-08-16)
### Bug Fixes
* Fixed errors in which two or more video advertisements occurred within the same advertising framework
* Progress bar operation improvements in full screen display

## v2.0.0 (2017-08-09)
### Changes & Enhancements
* Video advertising support

## v1.0.0 (2017-06-21)

Original version.

