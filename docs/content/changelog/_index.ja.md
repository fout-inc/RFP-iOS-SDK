---
title: CHANGELOG
weight: 40
pre: "<b>4. </b>"
---

## v2.5.1 (2018-01-11)
### Changes & Enhancements
* 通信処理の改善
* その他パフォーマンス改善

## v2.5.0 (2017-12-13)
### Changes & Enhancements
* 動画広告キャッシュ機能を追加
* deprecated機能の削除
    - `RFPInstreamAdLoader` - `rfpGetVideoPlayerView:infoModel:`
    - `RFPInstreamAdLoaderDelegate` - `playerReadyToPlay:`
    - `RFPPlayerView`
    - --- ***下記の新機能へ移行してください*** ---
    - `RFPInstreamAdLoader` - `getVideoControlWithFrame:infoModel:`
    - `RFPInstreamAdLoaderDelegate` - `readyToPlayWithPlayerControl:`
    - `RFPPlayerControl`
* 軽微な改善を実施

## v2.4.2 (2017-11-29)
### Bug Fixes
* iOS9以下、v2.4.1で発生していた広告クリック時にブラウザ遷移しない不具合に対応

## v2.4.1 (2017-11-09)
### Bug Fixes
* 広告クリック時にDelegateイベントが発生しない不具合に対応

### Changes & Enhancements
* 軽微な改善を実施

## v2.4.0 (2017-10-30)
### Bug Fixes
* 通信周りのクラッシュ問題に対応

### Changes & Enhancements
* 広告ID取得の対応
* 軽微な改善を実施

## v2.3.2 (2017-10-24)
### Bug Fixes
* Video周りのクラッシュ問題に対応

### Changes & Enhancements
* 軽微な改善を実施

## v2.3.1 (2017-10-13)
### Bug Fixes
* Video再生時、タイミングによって例外が発生してしまう問題に対応

## v2.3.0 (2017-10-13)
### Changes & Enhancements
* 軽微な改善を実施

## v2.2.1 (2017-10-11)
### Bug Fixes
* 全画面表示時に呼び出し元のScrollToTopが反応してしまう問題に対応

## v2.2.0 (2017-10-02)
### Changes & Enhancements
* iPhone X対応
* 例外内容取得処理の追加

## v2.1.2 (2017-09-19)
### Changes & Enhancements
* 軽微な改善を実施

## v2.1.1 (2017-09-05)
### Changes & Enhancements
* Video全画面表示の機能改善(上下スワイプで閉じる)
* その他パフォーマンス改善

## v2.1.0 (2017-08-25)
### Changes & Enhancements
* カスタムインフィード広告のボタン名取得を追加
* Video再生インターフェースの簡略化

## v2.0.1 (2017-08-16)
### Bug Fixes
* 同一広告枠にて２つ以上の動画広告が存在する場合に発生していたエラーを修正
* 全画面表示時のプログレスバー操作改善

## v2.0.0 (2017-08-09)
### Changes & Enhancements
* 動画広告対応

## v1.0.0 (2017-06-21)

Original version.
