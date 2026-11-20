// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Solitaire Nova';

  @override
  String splashLoading(int percent) {
    return '読み込み中… $percent%';
  }

  @override
  String get navHome => 'ホーム';

  @override
  String get navStats => '統計';

  @override
  String get navShop => 'ショップ';

  @override
  String get navSettings => '設定';

  @override
  String get back => '戻る';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'キャンセル';

  @override
  String get confirm => '確認';

  @override
  String get close => '閉じる';

  @override
  String levelLabel(int level) {
    return 'レベル $level';
  }

  @override
  String coinsBalance(int coins) {
    return '$coins コイン';
  }

  @override
  String get continueGame => '続きから';

  @override
  String continueSubtitle(String mode, int moves, String time) {
    return '$mode · $moves 手 · $time';
  }

  @override
  String get playClassic => 'クラシック';

  @override
  String get drawOne => '1枚めくり';

  @override
  String get drawThree => '3枚めくり';

  @override
  String get dealRandom => 'ランダム配札';

  @override
  String get dealWinning => 'クリア可能な配札';

  @override
  String get dealWinningInfo =>
      'クリア可能な配札は、ソルバーで解けることを確認済みです。ランダム配札には解がない場合があります。';

  @override
  String get dailyChallenge => 'デイリーチャレンジ';

  @override
  String get achievements => '実績';

  @override
  String get themes => 'テーマ';

  @override
  String get statistics => '統計';

  @override
  String get shop => 'ショップ';

  @override
  String get settings => '設定';

  @override
  String get modeRandom => 'ランダム';

  @override
  String get modeWinning => 'クリア可能';

  @override
  String get modeDaily => 'デイリー';

  @override
  String get hudScore => 'スコア';

  @override
  String get hudTime => '時間';

  @override
  String get hudMoves => '手数';

  @override
  String get actionUndo => '元に戻す';

  @override
  String get actionHint => 'ヒント';

  @override
  String get actionAuto => '自動';

  @override
  String get actionNew => '新規';

  @override
  String get actionPause => '一時停止';

  @override
  String hintsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '残りヒント $count 回',
      zero: 'ヒントはありません',
    );
    return '$_temp0';
  }

  @override
  String semStock(int count) {
    return '山札、$count 枚。タップでめくります。';
  }

  @override
  String get semStockRecycle => '山札は空です。タップで捨て札を戻します。';

  @override
  String get semStockEmpty => '山札は空です';

  @override
  String get semWaste => '捨て札';

  @override
  String semFoundation(String suit, int count) {
    return '$suitの組札、$count 枚';
  }

  @override
  String semEmptyColumn(int column) {
    return '空の列 $column';
  }

  @override
  String semCard(String rank, String suit) {
    return '$suitの$rank';
  }

  @override
  String get semFaceDown => '裏向きのカード';

  @override
  String get suitClubs => 'クラブ';

  @override
  String get suitDiamonds => 'ダイヤ';

  @override
  String get suitHearts => 'ハート';

  @override
  String get suitSpades => 'スペード';

  @override
  String get rankAce => 'エース';

  @override
  String get rankJack => 'ジャック';

  @override
  String get rankQueen => 'クイーン';

  @override
  String get rankKing => 'キング';

  @override
  String get noMovesTitle => '有効な手がありません';

  @override
  String get noMovesBody => '今は有効な手がありません。元に戻す、この配札をやり直す、または新しいゲームを始めることができます。';

  @override
  String get noHintsTitle => 'ヒントがありません';

  @override
  String get noHintsBody => 'コインを使うか、任意の短い広告を見てヒントを入手できます。';

  @override
  String buyHints(int count, int price) {
    return '$priceで$count回分を購入';
  }

  @override
  String watchAdHints(int count) {
    return '広告で$count回分';
  }

  @override
  String get hintsDisabled => 'ヒントは設定でオフになっています。';

  @override
  String get autoFinishing => '仕上げ中…';

  @override
  String get skip => 'スキップ';

  @override
  String get pauseTitle => '一時停止中';

  @override
  String get resume => '再開';

  @override
  String get restartDeal => 'この配札をやり直す';

  @override
  String get newGame => '新しいゲーム';

  @override
  String get home => 'ホーム';

  @override
  String get restartTitle => 'この配札をやり直しますか？';

  @override
  String get restartBody => 'このゲームの進行状況は失われます。同じ配札を最初からプレイします。';

  @override
  String get newGameTitle => '新しいゲームを始めますか？';

  @override
  String get newGameBody => '現在のゲームは負けとして記録されます。';

  @override
  String get victoryTitle => '勝利！';

  @override
  String get finalScore => '最終スコア';

  @override
  String get timeLabel => '時間';

  @override
  String get movesLabel => '手数';

  @override
  String get maxCombo => '最大コンボ';

  @override
  String get timeBonus => 'タイムボーナス';

  @override
  String get bestScore => 'ベストスコア';

  @override
  String get newRecord => '新記録！';

  @override
  String coinsEarned(int coins) {
    return '+$coins';
  }

  @override
  String get doubleCoins => 'コイン2倍・広告を見る';

  @override
  String get coinsDoubled => 'コインが2倍になりました！';

  @override
  String get playAgain => '新しいゲーム';

  @override
  String get mainMenu => 'メインメニュー';

  @override
  String achievementUnlocked(String name) {
    return '実績解除：$name';
  }

  @override
  String get dailyTitle => 'デイリーチャレンジ';

  @override
  String get todaysChallenge => '今日のチャレンジ';

  @override
  String get dailyInfo => 'クリア可能な配札・1枚めくり';

  @override
  String dailyReward(int coins) {
    return '報酬：$coins';
  }

  @override
  String get play => 'プレイ';

  @override
  String playDay(String date) {
    return '$date をプレイ';
  }

  @override
  String get dailyCompleted => 'クリア済み';

  @override
  String get dailyRewardClaimed => '報酬受け取り済み';

  @override
  String get dailyPastNoReward => '過去の日はチェックマークのみで、コインはもらえません。';

  @override
  String dailyStreak(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days 日連続',
      zero: '連続記録なし',
    );
    return '$_temp0';
  }

  @override
  String get dailyCalendarNote => 'チャレンジは端末のカレンダーの日付に従います。';

  @override
  String get dailyFuture => 'まだプレイできません';

  @override
  String dailyCompletedCount(int count) {
    return '$count 日クリア';
  }

  @override
  String get previousMonth => '前の月';

  @override
  String get nextMonth => '次の月';

  @override
  String get themesBackgrounds => '背景';

  @override
  String get themesCards => 'カード';

  @override
  String get themesTables => 'テーブル';

  @override
  String get apply => '適用';

  @override
  String get applied => '適用中';

  @override
  String get locked => 'ロック中';

  @override
  String get restoreDefaults => '初期設定に戻す';

  @override
  String get getInShop => 'ショップで入手';

  @override
  String get themesContrastNote => 'このテーブル上でのカードの見やすさをプレビューできます。';

  @override
  String get cosmetic_cards_classic => 'クラシック';

  @override
  String get cosmetic_cards_elegant => 'エレガント';

  @override
  String get cosmetic_cards_vintage => 'ヴィンテージ';

  @override
  String get cosmetic_cards_modern => 'モダン';

  @override
  String get cosmetic_cards_neon => 'ネオン';

  @override
  String get cosmetic_cards_gold => 'ゴールド';

  @override
  String get cosmetic_bg_lake => '山の湖';

  @override
  String get cosmetic_bg_autumn => '秋の小道';

  @override
  String get cosmetic_bg_tropic => '南国の入り江';

  @override
  String get cosmetic_bg_alpine => 'アルプスの峰';

  @override
  String get cosmetic_bg_aurora => 'オーロラ';

  @override
  String get cosmetic_bg_lavender => 'ラベンダーの夕暮れ';

  @override
  String get cosmetic_table_emerald => 'エメラルドのフェルト';

  @override
  String get cosmetic_table_navy => 'ミッドナイトネイビー';

  @override
  String get cosmetic_table_burgundy => 'ロイヤルバーガンディ';

  @override
  String get cosmetic_table_walnut => 'ウォールナット';

  @override
  String get cosmetic_table_slate => 'スレート';

  @override
  String get cosmetic_table_contrast => 'ハイコントラスト';

  @override
  String get statsTotal => '合計';

  @override
  String get statsPlayed => 'プレイ回数';

  @override
  String get statsWins => '勝利数';

  @override
  String get statsWinRate => '勝率';

  @override
  String get statsTotalTime => '合計プレイ時間';

  @override
  String get statsBestScore => 'ベストスコア';

  @override
  String get statsFastest => '最速勝利';

  @override
  String get statsCurrentStreak => '現在の連勝';

  @override
  String get statsBestStreak => '最長連勝';

  @override
  String get statsMaxCombo => '最大コンボ';

  @override
  String get statsFewestMoves => '最少手数';

  @override
  String get statsDailyDone => 'デイリーチャレンジ';

  @override
  String get statsEmpty => '最初のゲームをプレイすると、ここに統計が表示されます。';

  @override
  String get statsLocalLabel => 'この端末に保存';

  @override
  String durationHm(int hours, int minutes) {
    return '$hours時間$minutes分';
  }

  @override
  String achievementsProgress(int done, int total) {
    return '$total 個中 $done 個解除';
  }

  @override
  String earnedOn(String date) {
    return '$date に獲得';
  }

  @override
  String rewardCoins(int coins) {
    return '+$coins';
  }

  @override
  String get shopTitle => 'ショップ';

  @override
  String get shopCardPacks => 'カードセット';

  @override
  String get shopBackgrounds => '背景';

  @override
  String get shopTables => 'テーブル';

  @override
  String get shopHints => 'ヒント';

  @override
  String get buy => '購入';

  @override
  String get owned => '所持済み';

  @override
  String get equip => '使用する';

  @override
  String get equipped => '使用中';

  @override
  String purchaseTitle(String item) {
    return '$itemを購入しますか？';
  }

  @override
  String purchaseBody(int price, int after) {
    return '価格は $price コインです。購入後の残高：$after';
  }

  @override
  String get insufficientTitle => 'コインが足りません';

  @override
  String insufficientBody(int missing) {
    return 'あと $missing コイン必要です。ゲームに勝つ、デイリーチャレンジをクリアする、実績を解除するとコインを獲得できます。';
  }

  @override
  String purchaseDone(String item) {
    return '$itemを解除しました！';
  }

  @override
  String get hintPackTitle => 'ヒントパック';

  @override
  String hintPackBody(int count, int price) {
    return '$price コインでヒント $count 回';
  }

  @override
  String hintsOwned(int count) {
    return 'ヒント所持数：$count';
  }

  @override
  String get coinsDisclaimer => 'コインは金銭的価値のないゲーム内通貨です。購入、販売、換金、交換はできません。';

  @override
  String get settingsGameplay => 'ゲームプレイ';

  @override
  String get settingsAudio => 'サウンドと振動';

  @override
  String get settingsDisplay => '表示';

  @override
  String get settingsPrivacy => 'プライバシー';

  @override
  String get settingsData => 'データとアカウント';

  @override
  String get settingsAbout => 'このアプリについて';

  @override
  String get music => '音楽';

  @override
  String get sound => '効果音';

  @override
  String get haptics => '振動';

  @override
  String get reducedMotion => '動きを減らす';

  @override
  String get leftHanded => '左手モード';

  @override
  String get defaultDraw => '標準のめくり方';

  @override
  String get tapToFoundation => 'タップで組札を優先して移動';

  @override
  String get hintsSetting => 'ヒント';

  @override
  String get showTimer => 'タイマーを表示';

  @override
  String get unlimitedPasses => '山札の周回を無制限にする';

  @override
  String get limitedPassesNote => 'オフの場合：1枚めくりは2回、3枚めくりは3回まで山札を戻せます。';

  @override
  String get foundationMoves => '組札からの移動を許可';

  @override
  String get rulesNextGame => 'ルールの変更は次のゲームから適用されます。';

  @override
  String get language => '言語';

  @override
  String get languageSystem => 'システムの設定';

  @override
  String get cloudBackup => 'クラウドバックアップ';

  @override
  String get cloudBackupUnavailable =>
      'このバージョンではクラウドバックアップは設定されていません。進行状況はこの端末に保存されます。';

  @override
  String get signIn => 'サインイン';

  @override
  String get privacyChoices => 'プライバシーと広告の設定';

  @override
  String get analyticsSetting => '匿名の利用統計を共有する';

  @override
  String get personalizedAds => 'パーソナライズ広告';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get privacyPolicyBody =>
      'Solitaire Nova は、ゲーム、統計、購入アイテムをこの端末にのみ保存します。アカウントは不要です。許可した場合、匿名の利用統計と広告（Google AdMob 経由）が使用されることがあり、広告パートナーは同意内容に従って端末の識別子を処理する場合があります。同意は設定からいつでも撤回できます。';

  @override
  String get deleteData => 'ローカルデータを削除';

  @override
  String get deleteDataTitle => 'すべてのローカルデータを削除しますか？';

  @override
  String get deleteDataBody =>
      'この端末に保存されたゲーム、統計、実績、コイン、アイテムが完全に削除されます。元に戻すことはできません。';

  @override
  String get deleteDataDone => 'ローカルデータを削除しました';

  @override
  String get delete => '削除';

  @override
  String get restorePurchases => '購入の復元';

  @override
  String get restoreNone => '復元するストア購入はありません。コインで購入したアイテムはこの端末に残ります。';

  @override
  String get howToPlay => '遊び方';

  @override
  String get rulesTableau =>
      '7つの列に、色を交互にしながら大きい順にカードを重ねます（赤の上に黒、黒の上に赤）。空いた列に置けるのはキングだけです。';

  @override
  String get rulesFoundation => 'すべてのカードをスートごとに、エースからキングまで4つの組札に移します。';

  @override
  String get rulesStock => '山札をタップすると1枚または3枚めくれます。山札がなくなったら、もう一度タップして捨て札を戻します。';

  @override
  String get rulesControls =>
      'カードをタップすると自動で移動し、ドラッグでも動かせます。どの手も元に戻せ、ヒントも使えます。すべてのカードが表になったら「自動」で仕上げられます。';

  @override
  String get rulesCombo => 'コンボは連続した有効な手を数えます。楽しむためのもので、ルールは変わりません。';

  @override
  String get about => 'このアプリについて';

  @override
  String version(String version) {
    return 'バージョン $version';
  }

  @override
  String get licenses => 'オープンソースライセンス';

  @override
  String get aboutBody => 'クラシックなクロンダイク・ソリティア。ギャンブル要素や賞金はありません。';

  @override
  String get consentTitle => 'プライバシーについて';

  @override
  String get consentBody =>
      'Solitaire Nova は完全にオフラインで遊べます。許可していただければ、ゲームを無料で提供するための広告を表示し、改善のために匿名の利用統計を収集します。設定からいつでも変更できます。';

  @override
  String get consentAccept => '同意する';

  @override
  String get consentEssential => '必要なもののみ';

  @override
  String get offlineTitle => 'オフラインです';

  @override
  String get offlineBody => 'この機能にはインターネット接続が必要です。ゲーム自体はオフラインで遊べます。';

  @override
  String get adUnavailableTitle => '広告がありません';

  @override
  String get adUnavailableBody => '現在表示できる広告がありません。しばらくしてからもう一度お試しください。';

  @override
  String get adNotCompleted => '報酬を獲得する前に広告が閉じられました。';

  @override
  String get cloudConflictTitle => '保存データが2つ見つかりました';

  @override
  String get cloudConflictBody => 'この端末とクラウドバックアップの両方に進行中のゲームがあります。どちらを残しますか？';

  @override
  String get keepThisDevice => 'この端末';

  @override
  String get keepCloud => 'クラウド';

  @override
  String get errorTitle => '問題が発生しました';

  @override
  String get errorBody => '進行状況は保護されています。もう一度お試しください。';

  @override
  String get achTitle_first_win => '初勝利';

  @override
  String get achTitle_wins_10 => '期待の新星';

  @override
  String get achTitle_wins_50 => 'カード巧者';

  @override
  String get achTitle_wins_100 => 'ソリティアマスター';

  @override
  String get achTitle_wins_250 => 'グランドマスター';

  @override
  String get achTitle_wins_500 => '生ける伝説';

  @override
  String get achTitle_played_10 => 'はじめの一歩';

  @override
  String get achTitle_played_100 => '常連';

  @override
  String get achTitle_played_500 => '熱心なプレイヤー';

  @override
  String get achTitle_streak_3 => 'ハットトリック';

  @override
  String get achTitle_streak_5 => '絶好調';

  @override
  String get achTitle_streak_10 => '止められない';

  @override
  String get achTitle_draw3_first => 'トリプルスレット';

  @override
  String get achTitle_draw3_25 => '3枚めくりのベテラン';

  @override
  String get achTitle_no_hints => '自力で';

  @override
  String get achTitle_no_undo => '後悔なし';

  @override
  String get achTitle_purist_10 => '純粋主義者';

  @override
  String get achTitle_speed_5 => '器用な手';

  @override
  String get achTitle_speed_3 => '俊敏';

  @override
  String get achTitle_speed_2 => '電光石火';

  @override
  String get achTitle_moves_120 => '効率的';

  @override
  String get achTitle_moves_100 => '倹約家';

  @override
  String get achTitle_score_4000 => 'ハイスコア';

  @override
  String get achTitle_score_6000 => 'スコアの伝説';

  @override
  String get achTitle_combo_5 => 'コンボの始まり';

  @override
  String get achTitle_combo_10 => 'コンボの達人';

  @override
  String get achTitle_daily_first => 'デイリーデビュー';

  @override
  String get achTitle_daily_total_10 => 'デイリーの常連';

  @override
  String get achTitle_daily_total_30 => 'デイリーの鉄人';

  @override
  String get achTitle_daily_streak_7 => '毎日プレイヤー';

  @override
  String get achTitle_winning_10 => '仕上げ人';

  @override
  String get achTitle_auto_finish => 'スムーズな仕上げ';

  @override
  String get achTitle_marathon => 'マラソン';

  @override
  String get achTitle_collector_5 => 'コレクター';

  @override
  String get achTitle_stylist => 'スタイリスト';

  @override
  String get achTitle_level_10 => '熟練者';

  @override
  String achDescWins(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 回勝利する',
      one: '初めてゲームに勝利する',
    );
    return '$_temp0';
  }

  @override
  String achDescPlayed(int count) {
    return '$count 回プレイする';
  }

  @override
  String achDescStreak(int count) {
    return '$count 連勝する';
  }

  @override
  String achDescDraw3(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '3枚めくりで $count 回勝利する',
      one: '3枚めくりで勝利する',
    );
    return '$_temp0';
  }

  @override
  String get achDescNoHints => 'ヒントを使わずに勝利する';

  @override
  String get achDescNoUndo => '元に戻すを使わずに勝利する';

  @override
  String achDescPurist(int count) {
    return 'ヒントも元に戻すも使わずに $count 回勝利する';
  }

  @override
  String achDescSpeed(int minutes) {
    return '$minutes 分以内に勝利する';
  }

  @override
  String achDescMoves(int count) {
    return '$count 手以内で勝利する';
  }

  @override
  String achDescScore(int score) {
    return '1ゲームで $score 点を獲得する';
  }

  @override
  String achDescCombo(int count) {
    return '${count}x コンボを達成する';
  }

  @override
  String achDescDailyTotal(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'デイリーチャレンジを $count 回クリアする',
      one: 'デイリーチャレンジをクリアする',
    );
    return '$_temp0';
  }

  @override
  String achDescDailyStreak(int count) {
    return 'デイリーチャレンジを $count 日連続でクリアする';
  }

  @override
  String achDescWinning(int count) {
    return 'クリア可能な配札で $count 回勝利する';
  }

  @override
  String get achDescAutoFinish => '「自動」でゲームを仕上げる';

  @override
  String achDescMarathon(int hours) {
    return '合計 $hours 時間プレイする';
  }

  @override
  String achDescCollector(int count) {
    return '装飾アイテムを $count 個購入する';
  }

  @override
  String get achDescStylist => '新しいテーマを適用する';

  @override
  String achDescLevel(int level) {
    return 'レベル $level に到達する';
  }
}
