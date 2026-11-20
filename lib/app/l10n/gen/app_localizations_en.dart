// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Solitaire Nova';

  @override
  String splashLoading(int percent) {
    return 'Loading… $percent%';
  }

  @override
  String get navHome => 'Home';

  @override
  String get navStats => 'Stats';

  @override
  String get navShop => 'Shop';

  @override
  String get navSettings => 'Settings';

  @override
  String get back => 'Back';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get close => 'Close';

  @override
  String levelLabel(int level) {
    return 'Level $level';
  }

  @override
  String coinsBalance(int coins) {
    return '$coins coins';
  }

  @override
  String get continueGame => 'Continue';

  @override
  String continueSubtitle(String mode, int moves, String time) {
    return '$mode · $moves moves · $time';
  }

  @override
  String get playClassic => 'Classic Game';

  @override
  String get drawOne => 'Draw 1';

  @override
  String get drawThree => 'Draw 3';

  @override
  String get dealRandom => 'Random deal';

  @override
  String get dealWinning => 'Winning deal';

  @override
  String get dealWinningInfo =>
      'Winning deals are verified solvable by our solver. Random deals may have no solution.';

  @override
  String get dailyChallenge => 'Daily Challenge';

  @override
  String get achievements => 'Achievements';

  @override
  String get themes => 'Themes';

  @override
  String get statistics => 'Statistics';

  @override
  String get shop => 'Shop';

  @override
  String get settings => 'Settings';

  @override
  String get modeRandom => 'Random';

  @override
  String get modeWinning => 'Winning';

  @override
  String get modeDaily => 'Daily';

  @override
  String get hudScore => 'Score';

  @override
  String get hudTime => 'Time';

  @override
  String get hudMoves => 'Moves';

  @override
  String get actionUndo => 'Undo';

  @override
  String get actionHint => 'Hint';

  @override
  String get actionAuto => 'Auto';

  @override
  String get actionNew => 'New';

  @override
  String get actionPause => 'Pause';

  @override
  String hintsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hints left',
      one: '1 hint left',
      zero: 'No hints left',
    );
    return '$_temp0';
  }

  @override
  String semStock(int count) {
    return 'Stock, $count cards. Tap to draw.';
  }

  @override
  String get semStockRecycle => 'Empty stock. Tap to turn the waste over.';

  @override
  String get semStockEmpty => 'Empty stock';

  @override
  String get semWaste => 'Waste pile';

  @override
  String semFoundation(int count, String suit) {
    return '$suit foundation, $count cards';
  }

  @override
  String semEmptyColumn(int column) {
    return 'Empty column $column';
  }

  @override
  String semCard(String rank, String suit) {
    return '$rank of $suit';
  }

  @override
  String get semFaceDown => 'Face-down card';

  @override
  String get suitClubs => 'Clubs';

  @override
  String get suitDiamonds => 'Diamonds';

  @override
  String get suitHearts => 'Hearts';

  @override
  String get suitSpades => 'Spades';

  @override
  String get rankAce => 'Ace';

  @override
  String get rankJack => 'Jack';

  @override
  String get rankQueen => 'Queen';

  @override
  String get rankKing => 'King';

  @override
  String get noMovesTitle => 'No useful moves';

  @override
  String get noMovesBody =>
      'There are no productive moves right now. You can undo, restart this deal or start a new game.';

  @override
  String get noHintsTitle => 'Out of hints';

  @override
  String get noHintsBody =>
      'Get more hints with coins or by watching a short optional ad.';

  @override
  String buyHints(int count, int price) {
    return 'Buy $count for $price';
  }

  @override
  String watchAdHints(int count) {
    return 'Watch ad for $count';
  }

  @override
  String get hintsDisabled => 'Hints are turned off in Settings.';

  @override
  String get autoFinishing => 'Finishing…';

  @override
  String get skip => 'Skip';

  @override
  String get pauseTitle => 'Paused';

  @override
  String get resume => 'Resume';

  @override
  String get restartDeal => 'Restart deal';

  @override
  String get newGame => 'New game';

  @override
  String get home => 'Home';

  @override
  String get restartTitle => 'Restart this deal?';

  @override
  String get restartBody =>
      'Your progress in this game will be lost. You will play the same deal from the start.';

  @override
  String get newGameTitle => 'Start a new game?';

  @override
  String get newGameBody => 'The current game will be counted as a loss.';

  @override
  String get victoryTitle => 'Victory!';

  @override
  String get finalScore => 'Final score';

  @override
  String get timeLabel => 'Time';

  @override
  String get movesLabel => 'Moves';

  @override
  String get maxCombo => 'Max combo';

  @override
  String get timeBonus => 'Time bonus';

  @override
  String get bestScore => 'Best score';

  @override
  String get newRecord => 'New record!';

  @override
  String coinsEarned(int coins) {
    return '+$coins';
  }

  @override
  String get doubleCoins => 'Double coins · watch ad';

  @override
  String get coinsDoubled => 'Coins doubled!';

  @override
  String get playAgain => 'New game';

  @override
  String get mainMenu => 'Main menu';

  @override
  String achievementUnlocked(String name) {
    return 'Achievement unlocked: $name';
  }

  @override
  String get dailyTitle => 'Daily Challenge';

  @override
  String get todaysChallenge => 'Today\'s challenge';

  @override
  String get dailyInfo => 'Winnable deal · Draw 1';

  @override
  String dailyReward(int coins) {
    return 'Reward: $coins';
  }

  @override
  String get play => 'Play';

  @override
  String playDay(String date) {
    return 'Play $date';
  }

  @override
  String get dailyCompleted => 'Completed';

  @override
  String get dailyRewardClaimed => 'Reward claimed';

  @override
  String get dailyPastNoReward => 'Past days earn a check mark, not coins.';

  @override
  String dailyStreak(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days-day streak',
      one: '1-day streak',
      zero: 'No current streak',
    );
    return '$_temp0';
  }

  @override
  String get dailyCalendarNote =>
      'Challenges follow your device\'s calendar date.';

  @override
  String get dailyFuture => 'Not available yet';

  @override
  String dailyCompletedCount(int count) {
    return '$count completed';
  }

  @override
  String get previousMonth => 'Previous month';

  @override
  String get nextMonth => 'Next month';

  @override
  String get themesBackgrounds => 'Backgrounds';

  @override
  String get themesCards => 'Cards';

  @override
  String get themesTables => 'Tables';

  @override
  String get apply => 'Apply';

  @override
  String get applied => 'Applied';

  @override
  String get locked => 'Locked';

  @override
  String get restoreDefaults => 'Restore defaults';

  @override
  String get getInShop => 'Get in shop';

  @override
  String get themesContrastNote =>
      'Preview shows card legibility on this table.';

  @override
  String get cosmetic_cards_classic => 'Classic';

  @override
  String get cosmetic_cards_elegant => 'Elegant';

  @override
  String get cosmetic_cards_vintage => 'Vintage';

  @override
  String get cosmetic_cards_modern => 'Modern';

  @override
  String get cosmetic_cards_neon => 'Neon';

  @override
  String get cosmetic_cards_gold => 'Golden';

  @override
  String get cosmetic_bg_lake => 'Mountain Lake';

  @override
  String get cosmetic_bg_autumn => 'Autumn Path';

  @override
  String get cosmetic_bg_tropic => 'Tropical Bay';

  @override
  String get cosmetic_bg_alpine => 'Alpine Peaks';

  @override
  String get cosmetic_bg_aurora => 'Northern Lights';

  @override
  String get cosmetic_bg_lavender => 'Lavender Dusk';

  @override
  String get cosmetic_table_emerald => 'Emerald Felt';

  @override
  String get cosmetic_table_navy => 'Midnight Navy';

  @override
  String get cosmetic_table_burgundy => 'Royal Burgundy';

  @override
  String get cosmetic_table_walnut => 'Walnut';

  @override
  String get cosmetic_table_slate => 'Slate';

  @override
  String get cosmetic_table_contrast => 'High Contrast';

  @override
  String get statsTotal => 'Total';

  @override
  String get statsPlayed => 'Games played';

  @override
  String get statsWins => 'Wins';

  @override
  String get statsWinRate => 'Win rate';

  @override
  String get statsTotalTime => 'Total time';

  @override
  String get statsBestScore => 'Best score';

  @override
  String get statsFastest => 'Fastest win';

  @override
  String get statsCurrentStreak => 'Current streak';

  @override
  String get statsBestStreak => 'Best streak';

  @override
  String get statsMaxCombo => 'Max combo';

  @override
  String get statsFewestMoves => 'Fewest moves';

  @override
  String get statsDailyDone => 'Daily challenges';

  @override
  String get statsEmpty => 'Play your first game to see your statistics here.';

  @override
  String get statsLocalLabel => 'Stored on this device';

  @override
  String durationHm(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String achievementsProgress(int done, int total) {
    return '$done of $total unlocked';
  }

  @override
  String earnedOn(String date) {
    return 'Earned $date';
  }

  @override
  String rewardCoins(int coins) {
    return '+$coins';
  }

  @override
  String get shopTitle => 'Shop';

  @override
  String get shopCardPacks => 'Card packs';

  @override
  String get shopBackgrounds => 'Backgrounds';

  @override
  String get shopTables => 'Tables';

  @override
  String get shopHints => 'Hints';

  @override
  String get buy => 'Buy';

  @override
  String get owned => 'Owned';

  @override
  String get equip => 'Equip';

  @override
  String get equipped => 'Equipped';

  @override
  String purchaseTitle(String item) {
    return 'Buy $item?';
  }

  @override
  String purchaseBody(int after, int price) {
    return 'This costs $price coins. Balance after purchase: $after.';
  }

  @override
  String get insufficientTitle => 'Not enough coins';

  @override
  String insufficientBody(int missing) {
    return 'You need $missing more coins. Win games, complete daily challenges and unlock achievements to earn more.';
  }

  @override
  String purchaseDone(String item) {
    return '$item unlocked!';
  }

  @override
  String get hintPackTitle => 'Hint pack';

  @override
  String hintPackBody(int count, int price) {
    return '$count hints for $price coins';
  }

  @override
  String hintsOwned(int count) {
    return 'You have $count hints';
  }

  @override
  String get coinsDisclaimer =>
      'Coins are an in-game currency with no cash value. They cannot be bought, sold, withdrawn or exchanged.';

  @override
  String get settingsGameplay => 'Gameplay';

  @override
  String get settingsAudio => 'Sound & feel';

  @override
  String get settingsDisplay => 'Display';

  @override
  String get settingsPrivacy => 'Privacy';

  @override
  String get settingsData => 'Data & account';

  @override
  String get settingsAbout => 'About';

  @override
  String get music => 'Music';

  @override
  String get sound => 'Sound effects';

  @override
  String get haptics => 'Vibration';

  @override
  String get reducedMotion => 'Reduce motion';

  @override
  String get leftHanded => 'Left-handed mode';

  @override
  String get defaultDraw => 'Default draw mode';

  @override
  String get tapToFoundation => 'Tap sends cards to foundations first';

  @override
  String get hintsSetting => 'Hints';

  @override
  String get showTimer => 'Show timer';

  @override
  String get unlimitedPasses => 'Unlimited stock passes';

  @override
  String get limitedPassesNote =>
      'When off: Draw 1 allows 2 recycles, Draw 3 allows 3.';

  @override
  String get foundationMoves => 'Allow moves from foundations';

  @override
  String get rulesNextGame => 'Rule changes apply from your next game.';

  @override
  String get language => 'Language';

  @override
  String get languageSystem => 'System default';

  @override
  String get cloudBackup => 'Cloud backup';

  @override
  String get cloudBackupUnavailable =>
      'Cloud backup isn\'t configured in this build. Your progress is saved on this device.';

  @override
  String get signIn => 'Sign in';

  @override
  String get privacyChoices => 'Privacy & ad choices';

  @override
  String get analyticsSetting => 'Share anonymous usage statistics';

  @override
  String get personalizedAds => 'Personalized ads';

  @override
  String get privacyPolicy => 'Privacy policy';

  @override
  String get privacyPolicyBody =>
      'Solitaire Nova stores your games, statistics and purchases only on this device. No account is required. If you allow it, anonymous usage statistics and ads (via Google AdMob) may be used; ad partners may process device identifiers according to your consent choices. You can withdraw consent at any time in Settings.';

  @override
  String get deleteData => 'Delete local data';

  @override
  String get deleteDataTitle => 'Delete all local data?';

  @override
  String get deleteDataBody =>
      'This permanently removes your saved game, statistics, achievements, coins and items on this device. This cannot be undone.';

  @override
  String get deleteDataDone => 'Local data deleted';

  @override
  String get delete => 'Delete';

  @override
  String get restorePurchases => 'Restore purchases';

  @override
  String get restoreNone =>
      'There are no store purchases to restore. Items bought with coins stay on this device.';

  @override
  String get howToPlay => 'How to play';

  @override
  String get rulesTableau =>
      'Build the seven columns down in alternating colours (red on black, black on red). Only a King can fill an empty column.';

  @override
  String get rulesFoundation =>
      'Move all cards to the four foundations, by suit, from Ace up to King.';

  @override
  String get rulesStock =>
      'Tap the stock to turn 1 or 3 cards. When it\'s empty, tap again to turn the waste over.';

  @override
  String get rulesControls =>
      'Tap a card to move it automatically, or drag it. Undo any move, ask for a hint, or let Auto finish the game when all cards are revealed.';

  @override
  String get rulesCombo =>
      'Combos count consecutive productive moves. They are just for fun and never change the rules.';

  @override
  String get about => 'About';

  @override
  String version(String version) {
    return 'Version $version';
  }

  @override
  String get licenses => 'Open-source licenses';

  @override
  String get aboutBody =>
      'A classic Klondike Solitaire. No gambling, no cash prizes.';

  @override
  String get consentTitle => 'Your privacy';

  @override
  String get consentBody =>
      'Solitaire Nova works fully offline. With your permission we show ads that keep the game free and collect anonymous usage statistics to improve it. You can change this any time in Settings.';

  @override
  String get consentAccept => 'Accept';

  @override
  String get consentEssential => 'Essential only';

  @override
  String get offlineTitle => 'You\'re offline';

  @override
  String get offlineBody =>
      'This feature needs an internet connection. The game itself works offline.';

  @override
  String get adUnavailableTitle => 'No ad available';

  @override
  String get adUnavailableBody =>
      'There\'s no ad to show right now. Please try again later.';

  @override
  String get adNotCompleted =>
      'The ad was closed before the reward was earned.';

  @override
  String get cloudConflictTitle => 'Two saved games found';

  @override
  String get cloudConflictBody =>
      'This device and your cloud backup both have a game in progress. Which one do you want to keep?';

  @override
  String get keepThisDevice => 'Keep this device';

  @override
  String get keepCloud => 'Keep cloud';

  @override
  String get errorTitle => 'Something went wrong';

  @override
  String get errorBody => 'Your progress is safe. Please try again.';

  @override
  String get achTitle_first_win => 'First Victory';

  @override
  String get achTitle_wins_10 => 'Rising Star';

  @override
  String get achTitle_wins_50 => 'Card Sharp';

  @override
  String get achTitle_wins_100 => 'Solitaire Master';

  @override
  String get achTitle_wins_250 => 'Grand Master';

  @override
  String get achTitle_wins_500 => 'Living Legend';

  @override
  String get achTitle_played_10 => 'Getting Started';

  @override
  String get achTitle_played_100 => 'Regular';

  @override
  String get achTitle_played_500 => 'Devotee';

  @override
  String get achTitle_streak_3 => 'Hat Trick';

  @override
  String get achTitle_streak_5 => 'On Fire';

  @override
  String get achTitle_streak_10 => 'Unstoppable';

  @override
  String get achTitle_draw3_first => 'Triple Threat';

  @override
  String get achTitle_draw3_25 => 'Draw Three Veteran';

  @override
  String get achTitle_no_hints => 'Self-Reliant';

  @override
  String get achTitle_no_undo => 'No Regrets';

  @override
  String get achTitle_purist_10 => 'Purist';

  @override
  String get achTitle_speed_5 => 'Quick Hands';

  @override
  String get achTitle_speed_3 => 'Swift';

  @override
  String get achTitle_speed_2 => 'Lightning';

  @override
  String get achTitle_moves_120 => 'Efficient';

  @override
  String get achTitle_moves_100 => 'Economist';

  @override
  String get achTitle_score_4000 => 'High Scorer';

  @override
  String get achTitle_score_6000 => 'Score Legend';

  @override
  String get achTitle_combo_5 => 'Combo Starter';

  @override
  String get achTitle_combo_10 => 'Combo Expert';

  @override
  String get achTitle_daily_first => 'Daily Debut';

  @override
  String get achTitle_daily_total_10 => 'Daily Regular';

  @override
  String get achTitle_daily_total_30 => 'Daily Devotee';

  @override
  String get achTitle_daily_streak_7 => 'Daily Player';

  @override
  String get achTitle_winning_10 => 'Deal Closer';

  @override
  String get achTitle_auto_finish => 'Smooth Finish';

  @override
  String get achTitle_marathon => 'Marathon';

  @override
  String get achTitle_collector_5 => 'Collector';

  @override
  String get achTitle_stylist => 'Stylist';

  @override
  String get achTitle_level_10 => 'Seasoned';

  @override
  String achDescWins(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Win $count games',
      one: 'Win your first game',
    );
    return '$_temp0';
  }

  @override
  String achDescPlayed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Play $count games',
      one: 'Play 1 game',
    );
    return '$_temp0';
  }

  @override
  String achDescStreak(int count) {
    return 'Win $count games in a row';
  }

  @override
  String achDescDraw3(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Win $count Draw 3 games',
      one: 'Win a Draw 3 game',
    );
    return '$_temp0';
  }

  @override
  String get achDescNoHints => 'Win a game without using hints';

  @override
  String get achDescNoUndo => 'Win a game without using undo';

  @override
  String achDescPurist(int count) {
    return 'Win $count games without hints or undo';
  }

  @override
  String achDescSpeed(int minutes) {
    return 'Win a game in under $minutes minutes';
  }

  @override
  String achDescMoves(int count) {
    return 'Win a game in $count moves or fewer';
  }

  @override
  String achDescScore(int score) {
    return 'Score $score points in one game';
  }

  @override
  String achDescCombo(int count) {
    return 'Reach a ${count}x combo';
  }

  @override
  String achDescDailyTotal(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Complete $count daily challenges',
      one: 'Complete a daily challenge',
    );
    return '$_temp0';
  }

  @override
  String achDescDailyStreak(int count) {
    return 'Complete daily challenges $count days in a row';
  }

  @override
  String achDescWinning(int count) {
    return 'Win $count winning deals';
  }

  @override
  String get achDescAutoFinish => 'Finish a game with Auto';

  @override
  String achDescMarathon(int hours) {
    return 'Play for $hours hours in total';
  }

  @override
  String achDescCollector(int count) {
    return 'Buy $count cosmetic items';
  }

  @override
  String get achDescStylist => 'Apply a new theme';

  @override
  String achDescLevel(int level) {
    return 'Reach level $level';
  }
}
