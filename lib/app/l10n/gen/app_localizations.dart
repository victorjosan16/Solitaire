import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('pl'),
    Locale('pt'),
    Locale('ro'),
    Locale('ru'),
    Locale('tr'),
    Locale('uk'),
    Locale('vi'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Solitaire Nova'**
  String get appTitle;

  /// No description provided for @splashLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading… {percent}%'**
  String splashLoading(int percent);

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navStats.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get navStats;

  /// No description provided for @navShop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get navShop;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @levelLabel.
  ///
  /// In en, this message translates to:
  /// **'Level {level}'**
  String levelLabel(int level);

  /// No description provided for @coinsBalance.
  ///
  /// In en, this message translates to:
  /// **'{coins} coins'**
  String coinsBalance(int coins);

  /// No description provided for @continueGame.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueGame;

  /// No description provided for @continueSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{mode} · {moves} moves · {time}'**
  String continueSubtitle(String mode, int moves, String time);

  /// No description provided for @playClassic.
  ///
  /// In en, this message translates to:
  /// **'Classic Game'**
  String get playClassic;

  /// No description provided for @drawOne.
  ///
  /// In en, this message translates to:
  /// **'Draw 1'**
  String get drawOne;

  /// No description provided for @drawThree.
  ///
  /// In en, this message translates to:
  /// **'Draw 3'**
  String get drawThree;

  /// No description provided for @dealRandom.
  ///
  /// In en, this message translates to:
  /// **'Random deal'**
  String get dealRandom;

  /// No description provided for @dealWinning.
  ///
  /// In en, this message translates to:
  /// **'Winning deal'**
  String get dealWinning;

  /// No description provided for @dealWinningInfo.
  ///
  /// In en, this message translates to:
  /// **'Winning deals are verified solvable by our solver. Random deals may have no solution.'**
  String get dealWinningInfo;

  /// No description provided for @dailyChallenge.
  ///
  /// In en, this message translates to:
  /// **'Daily Challenge'**
  String get dailyChallenge;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @themes.
  ///
  /// In en, this message translates to:
  /// **'Themes'**
  String get themes;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @shop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get shop;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @modeRandom.
  ///
  /// In en, this message translates to:
  /// **'Random'**
  String get modeRandom;

  /// No description provided for @modeWinning.
  ///
  /// In en, this message translates to:
  /// **'Winning'**
  String get modeWinning;

  /// No description provided for @modeDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get modeDaily;

  /// No description provided for @hudScore.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get hudScore;

  /// No description provided for @hudTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get hudTime;

  /// No description provided for @hudMoves.
  ///
  /// In en, this message translates to:
  /// **'Moves'**
  String get hudMoves;

  /// No description provided for @actionUndo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get actionUndo;

  /// No description provided for @actionHint.
  ///
  /// In en, this message translates to:
  /// **'Hint'**
  String get actionHint;

  /// No description provided for @actionAuto.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get actionAuto;

  /// No description provided for @actionNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get actionNew;

  /// No description provided for @actionPause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get actionPause;

  /// No description provided for @hintsLeft.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No hints left} =1{1 hint left} other{{count} hints left}}'**
  String hintsLeft(int count);

  /// No description provided for @semStock.
  ///
  /// In en, this message translates to:
  /// **'Stock, {count} cards. Tap to draw.'**
  String semStock(int count);

  /// No description provided for @semStockRecycle.
  ///
  /// In en, this message translates to:
  /// **'Empty stock. Tap to turn the waste over.'**
  String get semStockRecycle;

  /// No description provided for @semStockEmpty.
  ///
  /// In en, this message translates to:
  /// **'Empty stock'**
  String get semStockEmpty;

  /// No description provided for @semWaste.
  ///
  /// In en, this message translates to:
  /// **'Waste pile'**
  String get semWaste;

  /// No description provided for @semFoundation.
  ///
  /// In en, this message translates to:
  /// **'{suit} foundation, {count} cards'**
  String semFoundation(String suit, int count);

  /// No description provided for @semEmptyColumn.
  ///
  /// In en, this message translates to:
  /// **'Empty column {column}'**
  String semEmptyColumn(int column);

  /// No description provided for @semCard.
  ///
  /// In en, this message translates to:
  /// **'{rank} of {suit}'**
  String semCard(String rank, String suit);

  /// No description provided for @semFaceDown.
  ///
  /// In en, this message translates to:
  /// **'Face-down card'**
  String get semFaceDown;

  /// No description provided for @suitClubs.
  ///
  /// In en, this message translates to:
  /// **'Clubs'**
  String get suitClubs;

  /// No description provided for @suitDiamonds.
  ///
  /// In en, this message translates to:
  /// **'Diamonds'**
  String get suitDiamonds;

  /// No description provided for @suitHearts.
  ///
  /// In en, this message translates to:
  /// **'Hearts'**
  String get suitHearts;

  /// No description provided for @suitSpades.
  ///
  /// In en, this message translates to:
  /// **'Spades'**
  String get suitSpades;

  /// No description provided for @rankAce.
  ///
  /// In en, this message translates to:
  /// **'Ace'**
  String get rankAce;

  /// No description provided for @rankJack.
  ///
  /// In en, this message translates to:
  /// **'Jack'**
  String get rankJack;

  /// No description provided for @rankQueen.
  ///
  /// In en, this message translates to:
  /// **'Queen'**
  String get rankQueen;

  /// No description provided for @rankKing.
  ///
  /// In en, this message translates to:
  /// **'King'**
  String get rankKing;

  /// No description provided for @noMovesTitle.
  ///
  /// In en, this message translates to:
  /// **'No useful moves'**
  String get noMovesTitle;

  /// No description provided for @noMovesBody.
  ///
  /// In en, this message translates to:
  /// **'There are no productive moves right now. You can undo, restart this deal or start a new game.'**
  String get noMovesBody;

  /// No description provided for @noHintsTitle.
  ///
  /// In en, this message translates to:
  /// **'Out of hints'**
  String get noHintsTitle;

  /// No description provided for @noHintsBody.
  ///
  /// In en, this message translates to:
  /// **'Get more hints with coins or by watching a short optional ad.'**
  String get noHintsBody;

  /// No description provided for @buyHints.
  ///
  /// In en, this message translates to:
  /// **'Buy {count} for {price}'**
  String buyHints(int count, int price);

  /// No description provided for @watchAdHints.
  ///
  /// In en, this message translates to:
  /// **'Watch ad for {count}'**
  String watchAdHints(int count);

  /// No description provided for @hintsDisabled.
  ///
  /// In en, this message translates to:
  /// **'Hints are turned off in Settings.'**
  String get hintsDisabled;

  /// No description provided for @autoFinishing.
  ///
  /// In en, this message translates to:
  /// **'Finishing…'**
  String get autoFinishing;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @pauseTitle.
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get pauseTitle;

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;

  /// No description provided for @restartDeal.
  ///
  /// In en, this message translates to:
  /// **'Restart deal'**
  String get restartDeal;

  /// No description provided for @newGame.
  ///
  /// In en, this message translates to:
  /// **'New game'**
  String get newGame;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @restartTitle.
  ///
  /// In en, this message translates to:
  /// **'Restart this deal?'**
  String get restartTitle;

  /// No description provided for @restartBody.
  ///
  /// In en, this message translates to:
  /// **'Your progress in this game will be lost. You will play the same deal from the start.'**
  String get restartBody;

  /// No description provided for @newGameTitle.
  ///
  /// In en, this message translates to:
  /// **'Start a new game?'**
  String get newGameTitle;

  /// No description provided for @newGameBody.
  ///
  /// In en, this message translates to:
  /// **'The current game will be counted as a loss.'**
  String get newGameBody;

  /// No description provided for @victoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Victory!'**
  String get victoryTitle;

  /// No description provided for @finalScore.
  ///
  /// In en, this message translates to:
  /// **'Final score'**
  String get finalScore;

  /// No description provided for @timeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get timeLabel;

  /// No description provided for @movesLabel.
  ///
  /// In en, this message translates to:
  /// **'Moves'**
  String get movesLabel;

  /// No description provided for @maxCombo.
  ///
  /// In en, this message translates to:
  /// **'Max combo'**
  String get maxCombo;

  /// No description provided for @timeBonus.
  ///
  /// In en, this message translates to:
  /// **'Time bonus'**
  String get timeBonus;

  /// No description provided for @bestScore.
  ///
  /// In en, this message translates to:
  /// **'Best score'**
  String get bestScore;

  /// No description provided for @newRecord.
  ///
  /// In en, this message translates to:
  /// **'New record!'**
  String get newRecord;

  /// No description provided for @coinsEarned.
  ///
  /// In en, this message translates to:
  /// **'+{coins}'**
  String coinsEarned(int coins);

  /// No description provided for @doubleCoins.
  ///
  /// In en, this message translates to:
  /// **'Double coins · watch ad'**
  String get doubleCoins;

  /// No description provided for @coinsDoubled.
  ///
  /// In en, this message translates to:
  /// **'Coins doubled!'**
  String get coinsDoubled;

  /// No description provided for @playAgain.
  ///
  /// In en, this message translates to:
  /// **'New game'**
  String get playAgain;

  /// No description provided for @mainMenu.
  ///
  /// In en, this message translates to:
  /// **'Main menu'**
  String get mainMenu;

  /// No description provided for @achievementUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Achievement unlocked: {name}'**
  String achievementUnlocked(String name);

  /// No description provided for @dailyTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily Challenge'**
  String get dailyTitle;

  /// No description provided for @todaysChallenge.
  ///
  /// In en, this message translates to:
  /// **'Today\'s challenge'**
  String get todaysChallenge;

  /// No description provided for @dailyInfo.
  ///
  /// In en, this message translates to:
  /// **'Winnable deal · Draw 1'**
  String get dailyInfo;

  /// No description provided for @dailyReward.
  ///
  /// In en, this message translates to:
  /// **'Reward: {coins}'**
  String dailyReward(int coins);

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// No description provided for @playDay.
  ///
  /// In en, this message translates to:
  /// **'Play {date}'**
  String playDay(String date);

  /// No description provided for @dailyCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get dailyCompleted;

  /// No description provided for @dailyRewardClaimed.
  ///
  /// In en, this message translates to:
  /// **'Reward claimed'**
  String get dailyRewardClaimed;

  /// No description provided for @dailyPastNoReward.
  ///
  /// In en, this message translates to:
  /// **'Past days earn a check mark, not coins.'**
  String get dailyPastNoReward;

  /// No description provided for @dailyStreak.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =0{No current streak} =1{1-day streak} other{{days}-day streak}}'**
  String dailyStreak(int days);

  /// No description provided for @dailyCalendarNote.
  ///
  /// In en, this message translates to:
  /// **'Challenges follow your device\'s calendar date.'**
  String get dailyCalendarNote;

  /// No description provided for @dailyFuture.
  ///
  /// In en, this message translates to:
  /// **'Not available yet'**
  String get dailyFuture;

  /// No description provided for @dailyCompletedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} completed'**
  String dailyCompletedCount(int count);

  /// No description provided for @previousMonth.
  ///
  /// In en, this message translates to:
  /// **'Previous month'**
  String get previousMonth;

  /// No description provided for @nextMonth.
  ///
  /// In en, this message translates to:
  /// **'Next month'**
  String get nextMonth;

  /// No description provided for @themesBackgrounds.
  ///
  /// In en, this message translates to:
  /// **'Backgrounds'**
  String get themesBackgrounds;

  /// No description provided for @themesCards.
  ///
  /// In en, this message translates to:
  /// **'Cards'**
  String get themesCards;

  /// No description provided for @themesTables.
  ///
  /// In en, this message translates to:
  /// **'Tables'**
  String get themesTables;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @applied.
  ///
  /// In en, this message translates to:
  /// **'Applied'**
  String get applied;

  /// No description provided for @locked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get locked;

  /// No description provided for @restoreDefaults.
  ///
  /// In en, this message translates to:
  /// **'Restore defaults'**
  String get restoreDefaults;

  /// No description provided for @getInShop.
  ///
  /// In en, this message translates to:
  /// **'Get in shop'**
  String get getInShop;

  /// No description provided for @themesContrastNote.
  ///
  /// In en, this message translates to:
  /// **'Preview shows card legibility on this table.'**
  String get themesContrastNote;

  /// No description provided for @cosmetic_cards_classic.
  ///
  /// In en, this message translates to:
  /// **'Classic'**
  String get cosmetic_cards_classic;

  /// No description provided for @cosmetic_cards_elegant.
  ///
  /// In en, this message translates to:
  /// **'Elegant'**
  String get cosmetic_cards_elegant;

  /// No description provided for @cosmetic_cards_vintage.
  ///
  /// In en, this message translates to:
  /// **'Vintage'**
  String get cosmetic_cards_vintage;

  /// No description provided for @cosmetic_cards_modern.
  ///
  /// In en, this message translates to:
  /// **'Modern'**
  String get cosmetic_cards_modern;

  /// No description provided for @cosmetic_cards_neon.
  ///
  /// In en, this message translates to:
  /// **'Neon'**
  String get cosmetic_cards_neon;

  /// No description provided for @cosmetic_cards_gold.
  ///
  /// In en, this message translates to:
  /// **'Golden'**
  String get cosmetic_cards_gold;

  /// No description provided for @cosmetic_bg_lake.
  ///
  /// In en, this message translates to:
  /// **'Mountain Lake'**
  String get cosmetic_bg_lake;

  /// No description provided for @cosmetic_bg_autumn.
  ///
  /// In en, this message translates to:
  /// **'Autumn Path'**
  String get cosmetic_bg_autumn;

  /// No description provided for @cosmetic_bg_tropic.
  ///
  /// In en, this message translates to:
  /// **'Tropical Bay'**
  String get cosmetic_bg_tropic;

  /// No description provided for @cosmetic_bg_alpine.
  ///
  /// In en, this message translates to:
  /// **'Alpine Peaks'**
  String get cosmetic_bg_alpine;

  /// No description provided for @cosmetic_bg_aurora.
  ///
  /// In en, this message translates to:
  /// **'Northern Lights'**
  String get cosmetic_bg_aurora;

  /// No description provided for @cosmetic_bg_lavender.
  ///
  /// In en, this message translates to:
  /// **'Lavender Dusk'**
  String get cosmetic_bg_lavender;

  /// No description provided for @cosmetic_table_emerald.
  ///
  /// In en, this message translates to:
  /// **'Emerald Felt'**
  String get cosmetic_table_emerald;

  /// No description provided for @cosmetic_table_navy.
  ///
  /// In en, this message translates to:
  /// **'Midnight Navy'**
  String get cosmetic_table_navy;

  /// No description provided for @cosmetic_table_burgundy.
  ///
  /// In en, this message translates to:
  /// **'Royal Burgundy'**
  String get cosmetic_table_burgundy;

  /// No description provided for @cosmetic_table_walnut.
  ///
  /// In en, this message translates to:
  /// **'Walnut'**
  String get cosmetic_table_walnut;

  /// No description provided for @cosmetic_table_slate.
  ///
  /// In en, this message translates to:
  /// **'Slate'**
  String get cosmetic_table_slate;

  /// No description provided for @cosmetic_table_contrast.
  ///
  /// In en, this message translates to:
  /// **'High Contrast'**
  String get cosmetic_table_contrast;

  /// No description provided for @statsTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get statsTotal;

  /// No description provided for @statsPlayed.
  ///
  /// In en, this message translates to:
  /// **'Games played'**
  String get statsPlayed;

  /// No description provided for @statsWins.
  ///
  /// In en, this message translates to:
  /// **'Wins'**
  String get statsWins;

  /// No description provided for @statsWinRate.
  ///
  /// In en, this message translates to:
  /// **'Win rate'**
  String get statsWinRate;

  /// No description provided for @statsTotalTime.
  ///
  /// In en, this message translates to:
  /// **'Total time'**
  String get statsTotalTime;

  /// No description provided for @statsBestScore.
  ///
  /// In en, this message translates to:
  /// **'Best score'**
  String get statsBestScore;

  /// No description provided for @statsFastest.
  ///
  /// In en, this message translates to:
  /// **'Fastest win'**
  String get statsFastest;

  /// No description provided for @statsCurrentStreak.
  ///
  /// In en, this message translates to:
  /// **'Current streak'**
  String get statsCurrentStreak;

  /// No description provided for @statsBestStreak.
  ///
  /// In en, this message translates to:
  /// **'Best streak'**
  String get statsBestStreak;

  /// No description provided for @statsMaxCombo.
  ///
  /// In en, this message translates to:
  /// **'Max combo'**
  String get statsMaxCombo;

  /// No description provided for @statsFewestMoves.
  ///
  /// In en, this message translates to:
  /// **'Fewest moves'**
  String get statsFewestMoves;

  /// No description provided for @statsDailyDone.
  ///
  /// In en, this message translates to:
  /// **'Daily challenges'**
  String get statsDailyDone;

  /// No description provided for @statsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Play your first game to see your statistics here.'**
  String get statsEmpty;

  /// No description provided for @statsLocalLabel.
  ///
  /// In en, this message translates to:
  /// **'Stored on this device'**
  String get statsLocalLabel;

  /// No description provided for @durationHm.
  ///
  /// In en, this message translates to:
  /// **'{hours}h {minutes}m'**
  String durationHm(int hours, int minutes);

  /// No description provided for @achievementsProgress.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} unlocked'**
  String achievementsProgress(int done, int total);

  /// No description provided for @earnedOn.
  ///
  /// In en, this message translates to:
  /// **'Earned {date}'**
  String earnedOn(String date);

  /// No description provided for @rewardCoins.
  ///
  /// In en, this message translates to:
  /// **'+{coins}'**
  String rewardCoins(int coins);

  /// No description provided for @shopTitle.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get shopTitle;

  /// No description provided for @shopCardPacks.
  ///
  /// In en, this message translates to:
  /// **'Card packs'**
  String get shopCardPacks;

  /// No description provided for @shopBackgrounds.
  ///
  /// In en, this message translates to:
  /// **'Backgrounds'**
  String get shopBackgrounds;

  /// No description provided for @shopTables.
  ///
  /// In en, this message translates to:
  /// **'Tables'**
  String get shopTables;

  /// No description provided for @shopHints.
  ///
  /// In en, this message translates to:
  /// **'Hints'**
  String get shopHints;

  /// No description provided for @buy.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get buy;

  /// No description provided for @owned.
  ///
  /// In en, this message translates to:
  /// **'Owned'**
  String get owned;

  /// No description provided for @equip.
  ///
  /// In en, this message translates to:
  /// **'Equip'**
  String get equip;

  /// No description provided for @equipped.
  ///
  /// In en, this message translates to:
  /// **'Equipped'**
  String get equipped;

  /// No description provided for @purchaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Buy {item}?'**
  String purchaseTitle(String item);

  /// No description provided for @purchaseBody.
  ///
  /// In en, this message translates to:
  /// **'This costs {price} coins. Balance after purchase: {after}.'**
  String purchaseBody(int price, int after);

  /// No description provided for @insufficientTitle.
  ///
  /// In en, this message translates to:
  /// **'Not enough coins'**
  String get insufficientTitle;

  /// No description provided for @insufficientBody.
  ///
  /// In en, this message translates to:
  /// **'You need {missing} more coins. Win games, complete daily challenges and unlock achievements to earn more.'**
  String insufficientBody(int missing);

  /// No description provided for @purchaseDone.
  ///
  /// In en, this message translates to:
  /// **'{item} unlocked!'**
  String purchaseDone(String item);

  /// No description provided for @hintPackTitle.
  ///
  /// In en, this message translates to:
  /// **'Hint pack'**
  String get hintPackTitle;

  /// No description provided for @hintPackBody.
  ///
  /// In en, this message translates to:
  /// **'{count} hints for {price} coins'**
  String hintPackBody(int count, int price);

  /// No description provided for @hintsOwned.
  ///
  /// In en, this message translates to:
  /// **'You have {count} hints'**
  String hintsOwned(int count);

  /// No description provided for @coinsDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Coins are an in-game currency with no cash value. They cannot be bought, sold, withdrawn or exchanged.'**
  String get coinsDisclaimer;

  /// No description provided for @settingsGameplay.
  ///
  /// In en, this message translates to:
  /// **'Gameplay'**
  String get settingsGameplay;

  /// No description provided for @settingsAudio.
  ///
  /// In en, this message translates to:
  /// **'Sound & feel'**
  String get settingsAudio;

  /// No description provided for @settingsDisplay.
  ///
  /// In en, this message translates to:
  /// **'Display'**
  String get settingsDisplay;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get settingsPrivacy;

  /// No description provided for @settingsData.
  ///
  /// In en, this message translates to:
  /// **'Data & account'**
  String get settingsData;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAbout;

  /// No description provided for @music.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get music;

  /// No description provided for @sound.
  ///
  /// In en, this message translates to:
  /// **'Sound effects'**
  String get sound;

  /// No description provided for @haptics.
  ///
  /// In en, this message translates to:
  /// **'Vibration'**
  String get haptics;

  /// No description provided for @reducedMotion.
  ///
  /// In en, this message translates to:
  /// **'Reduce motion'**
  String get reducedMotion;

  /// No description provided for @leftHanded.
  ///
  /// In en, this message translates to:
  /// **'Left-handed mode'**
  String get leftHanded;

  /// No description provided for @defaultDraw.
  ///
  /// In en, this message translates to:
  /// **'Default draw mode'**
  String get defaultDraw;

  /// No description provided for @tapToFoundation.
  ///
  /// In en, this message translates to:
  /// **'Tap sends cards to foundations first'**
  String get tapToFoundation;

  /// No description provided for @hintsSetting.
  ///
  /// In en, this message translates to:
  /// **'Hints'**
  String get hintsSetting;

  /// No description provided for @showTimer.
  ///
  /// In en, this message translates to:
  /// **'Show timer'**
  String get showTimer;

  /// No description provided for @unlimitedPasses.
  ///
  /// In en, this message translates to:
  /// **'Unlimited stock passes'**
  String get unlimitedPasses;

  /// No description provided for @limitedPassesNote.
  ///
  /// In en, this message translates to:
  /// **'When off: Draw 1 allows 2 recycles, Draw 3 allows 3.'**
  String get limitedPassesNote;

  /// No description provided for @foundationMoves.
  ///
  /// In en, this message translates to:
  /// **'Allow moves from foundations'**
  String get foundationMoves;

  /// No description provided for @rulesNextGame.
  ///
  /// In en, this message translates to:
  /// **'Rule changes apply from your next game.'**
  String get rulesNextGame;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get languageSystem;

  /// No description provided for @cloudBackup.
  ///
  /// In en, this message translates to:
  /// **'Cloud backup'**
  String get cloudBackup;

  /// No description provided for @cloudBackupUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Cloud backup isn\'t configured in this build. Your progress is saved on this device.'**
  String get cloudBackupUnavailable;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @privacyChoices.
  ///
  /// In en, this message translates to:
  /// **'Privacy & ad choices'**
  String get privacyChoices;

  /// No description provided for @analyticsSetting.
  ///
  /// In en, this message translates to:
  /// **'Share anonymous usage statistics'**
  String get analyticsSetting;

  /// No description provided for @personalizedAds.
  ///
  /// In en, this message translates to:
  /// **'Personalized ads'**
  String get personalizedAds;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicy;

  /// No description provided for @privacyPolicyBody.
  ///
  /// In en, this message translates to:
  /// **'Solitaire Nova stores your games, statistics and purchases only on this device. No account is required. If you allow it, anonymous usage statistics and ads (via Google AdMob) may be used; ad partners may process device identifiers according to your consent choices. You can withdraw consent at any time in Settings.'**
  String get privacyPolicyBody;

  /// No description provided for @deleteData.
  ///
  /// In en, this message translates to:
  /// **'Delete local data'**
  String get deleteData;

  /// No description provided for @deleteDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete all local data?'**
  String get deleteDataTitle;

  /// No description provided for @deleteDataBody.
  ///
  /// In en, this message translates to:
  /// **'This permanently removes your saved game, statistics, achievements, coins and items on this device. This cannot be undone.'**
  String get deleteDataBody;

  /// No description provided for @deleteDataDone.
  ///
  /// In en, this message translates to:
  /// **'Local data deleted'**
  String get deleteDataDone;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @restorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get restorePurchases;

  /// No description provided for @restoreNone.
  ///
  /// In en, this message translates to:
  /// **'There are no store purchases to restore. Items bought with coins stay on this device.'**
  String get restoreNone;

  /// No description provided for @howToPlay.
  ///
  /// In en, this message translates to:
  /// **'How to play'**
  String get howToPlay;

  /// No description provided for @rulesTableau.
  ///
  /// In en, this message translates to:
  /// **'Build the seven columns down in alternating colours (red on black, black on red). Only a King can fill an empty column.'**
  String get rulesTableau;

  /// No description provided for @rulesFoundation.
  ///
  /// In en, this message translates to:
  /// **'Move all cards to the four foundations, by suit, from Ace up to King.'**
  String get rulesFoundation;

  /// No description provided for @rulesStock.
  ///
  /// In en, this message translates to:
  /// **'Tap the stock to turn 1 or 3 cards. When it\'s empty, tap again to turn the waste over.'**
  String get rulesStock;

  /// No description provided for @rulesControls.
  ///
  /// In en, this message translates to:
  /// **'Tap a card to move it automatically, or drag it. Undo any move, ask for a hint, or let Auto finish the game when all cards are revealed.'**
  String get rulesControls;

  /// No description provided for @rulesCombo.
  ///
  /// In en, this message translates to:
  /// **'Combos count consecutive productive moves. They are just for fun and never change the rules.'**
  String get rulesCombo;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String version(String version);

  /// No description provided for @licenses.
  ///
  /// In en, this message translates to:
  /// **'Open-source licenses'**
  String get licenses;

  /// No description provided for @aboutBody.
  ///
  /// In en, this message translates to:
  /// **'A classic Klondike Solitaire. No gambling, no cash prizes.'**
  String get aboutBody;

  /// No description provided for @consentTitle.
  ///
  /// In en, this message translates to:
  /// **'Your privacy'**
  String get consentTitle;

  /// No description provided for @consentBody.
  ///
  /// In en, this message translates to:
  /// **'Solitaire Nova works fully offline. With your permission we show ads that keep the game free and collect anonymous usage statistics to improve it. You can change this any time in Settings.'**
  String get consentBody;

  /// No description provided for @consentAccept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get consentAccept;

  /// No description provided for @consentEssential.
  ///
  /// In en, this message translates to:
  /// **'Essential only'**
  String get consentEssential;

  /// No description provided for @offlineTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re offline'**
  String get offlineTitle;

  /// No description provided for @offlineBody.
  ///
  /// In en, this message translates to:
  /// **'This feature needs an internet connection. The game itself works offline.'**
  String get offlineBody;

  /// No description provided for @adUnavailableTitle.
  ///
  /// In en, this message translates to:
  /// **'No ad available'**
  String get adUnavailableTitle;

  /// No description provided for @adUnavailableBody.
  ///
  /// In en, this message translates to:
  /// **'There\'s no ad to show right now. Please try again later.'**
  String get adUnavailableBody;

  /// No description provided for @adNotCompleted.
  ///
  /// In en, this message translates to:
  /// **'The ad was closed before the reward was earned.'**
  String get adNotCompleted;

  /// No description provided for @cloudConflictTitle.
  ///
  /// In en, this message translates to:
  /// **'Two saved games found'**
  String get cloudConflictTitle;

  /// No description provided for @cloudConflictBody.
  ///
  /// In en, this message translates to:
  /// **'This device and your cloud backup both have a game in progress. Which one do you want to keep?'**
  String get cloudConflictBody;

  /// No description provided for @keepThisDevice.
  ///
  /// In en, this message translates to:
  /// **'Keep this device'**
  String get keepThisDevice;

  /// No description provided for @keepCloud.
  ///
  /// In en, this message translates to:
  /// **'Keep cloud'**
  String get keepCloud;

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorTitle;

  /// No description provided for @errorBody.
  ///
  /// In en, this message translates to:
  /// **'Your progress is safe. Please try again.'**
  String get errorBody;

  /// No description provided for @achTitle_first_win.
  ///
  /// In en, this message translates to:
  /// **'First Victory'**
  String get achTitle_first_win;

  /// No description provided for @achTitle_wins_10.
  ///
  /// In en, this message translates to:
  /// **'Rising Star'**
  String get achTitle_wins_10;

  /// No description provided for @achTitle_wins_50.
  ///
  /// In en, this message translates to:
  /// **'Card Sharp'**
  String get achTitle_wins_50;

  /// No description provided for @achTitle_wins_100.
  ///
  /// In en, this message translates to:
  /// **'Solitaire Master'**
  String get achTitle_wins_100;

  /// No description provided for @achTitle_wins_250.
  ///
  /// In en, this message translates to:
  /// **'Grand Master'**
  String get achTitle_wins_250;

  /// No description provided for @achTitle_wins_500.
  ///
  /// In en, this message translates to:
  /// **'Living Legend'**
  String get achTitle_wins_500;

  /// No description provided for @achTitle_played_10.
  ///
  /// In en, this message translates to:
  /// **'Getting Started'**
  String get achTitle_played_10;

  /// No description provided for @achTitle_played_100.
  ///
  /// In en, this message translates to:
  /// **'Regular'**
  String get achTitle_played_100;

  /// No description provided for @achTitle_played_500.
  ///
  /// In en, this message translates to:
  /// **'Devotee'**
  String get achTitle_played_500;

  /// No description provided for @achTitle_streak_3.
  ///
  /// In en, this message translates to:
  /// **'Hat Trick'**
  String get achTitle_streak_3;

  /// No description provided for @achTitle_streak_5.
  ///
  /// In en, this message translates to:
  /// **'On Fire'**
  String get achTitle_streak_5;

  /// No description provided for @achTitle_streak_10.
  ///
  /// In en, this message translates to:
  /// **'Unstoppable'**
  String get achTitle_streak_10;

  /// No description provided for @achTitle_draw3_first.
  ///
  /// In en, this message translates to:
  /// **'Triple Threat'**
  String get achTitle_draw3_first;

  /// No description provided for @achTitle_draw3_25.
  ///
  /// In en, this message translates to:
  /// **'Draw Three Veteran'**
  String get achTitle_draw3_25;

  /// No description provided for @achTitle_no_hints.
  ///
  /// In en, this message translates to:
  /// **'Self-Reliant'**
  String get achTitle_no_hints;

  /// No description provided for @achTitle_no_undo.
  ///
  /// In en, this message translates to:
  /// **'No Regrets'**
  String get achTitle_no_undo;

  /// No description provided for @achTitle_purist_10.
  ///
  /// In en, this message translates to:
  /// **'Purist'**
  String get achTitle_purist_10;

  /// No description provided for @achTitle_speed_5.
  ///
  /// In en, this message translates to:
  /// **'Quick Hands'**
  String get achTitle_speed_5;

  /// No description provided for @achTitle_speed_3.
  ///
  /// In en, this message translates to:
  /// **'Swift'**
  String get achTitle_speed_3;

  /// No description provided for @achTitle_speed_2.
  ///
  /// In en, this message translates to:
  /// **'Lightning'**
  String get achTitle_speed_2;

  /// No description provided for @achTitle_moves_120.
  ///
  /// In en, this message translates to:
  /// **'Efficient'**
  String get achTitle_moves_120;

  /// No description provided for @achTitle_moves_100.
  ///
  /// In en, this message translates to:
  /// **'Economist'**
  String get achTitle_moves_100;

  /// No description provided for @achTitle_score_4000.
  ///
  /// In en, this message translates to:
  /// **'High Scorer'**
  String get achTitle_score_4000;

  /// No description provided for @achTitle_score_6000.
  ///
  /// In en, this message translates to:
  /// **'Score Legend'**
  String get achTitle_score_6000;

  /// No description provided for @achTitle_combo_5.
  ///
  /// In en, this message translates to:
  /// **'Combo Starter'**
  String get achTitle_combo_5;

  /// No description provided for @achTitle_combo_10.
  ///
  /// In en, this message translates to:
  /// **'Combo Expert'**
  String get achTitle_combo_10;

  /// No description provided for @achTitle_daily_first.
  ///
  /// In en, this message translates to:
  /// **'Daily Debut'**
  String get achTitle_daily_first;

  /// No description provided for @achTitle_daily_total_10.
  ///
  /// In en, this message translates to:
  /// **'Daily Regular'**
  String get achTitle_daily_total_10;

  /// No description provided for @achTitle_daily_total_30.
  ///
  /// In en, this message translates to:
  /// **'Daily Devotee'**
  String get achTitle_daily_total_30;

  /// No description provided for @achTitle_daily_streak_7.
  ///
  /// In en, this message translates to:
  /// **'Daily Player'**
  String get achTitle_daily_streak_7;

  /// No description provided for @achTitle_winning_10.
  ///
  /// In en, this message translates to:
  /// **'Deal Closer'**
  String get achTitle_winning_10;

  /// No description provided for @achTitle_auto_finish.
  ///
  /// In en, this message translates to:
  /// **'Smooth Finish'**
  String get achTitle_auto_finish;

  /// No description provided for @achTitle_marathon.
  ///
  /// In en, this message translates to:
  /// **'Marathon'**
  String get achTitle_marathon;

  /// No description provided for @achTitle_collector_5.
  ///
  /// In en, this message translates to:
  /// **'Collector'**
  String get achTitle_collector_5;

  /// No description provided for @achTitle_stylist.
  ///
  /// In en, this message translates to:
  /// **'Stylist'**
  String get achTitle_stylist;

  /// No description provided for @achTitle_level_10.
  ///
  /// In en, this message translates to:
  /// **'Seasoned'**
  String get achTitle_level_10;

  /// No description provided for @achDescWins.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Win your first game} other{Win {count} games}}'**
  String achDescWins(int count);

  /// No description provided for @achDescPlayed.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Play 1 game} other{Play {count} games}}'**
  String achDescPlayed(int count);

  /// No description provided for @achDescStreak.
  ///
  /// In en, this message translates to:
  /// **'Win {count} games in a row'**
  String achDescStreak(int count);

  /// No description provided for @achDescDraw3.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Win a Draw 3 game} other{Win {count} Draw 3 games}}'**
  String achDescDraw3(int count);

  /// No description provided for @achDescNoHints.
  ///
  /// In en, this message translates to:
  /// **'Win a game without using hints'**
  String get achDescNoHints;

  /// No description provided for @achDescNoUndo.
  ///
  /// In en, this message translates to:
  /// **'Win a game without using undo'**
  String get achDescNoUndo;

  /// No description provided for @achDescPurist.
  ///
  /// In en, this message translates to:
  /// **'Win {count} games without hints or undo'**
  String achDescPurist(int count);

  /// No description provided for @achDescSpeed.
  ///
  /// In en, this message translates to:
  /// **'Win a game in under {minutes} minutes'**
  String achDescSpeed(int minutes);

  /// No description provided for @achDescMoves.
  ///
  /// In en, this message translates to:
  /// **'Win a game in {count} moves or fewer'**
  String achDescMoves(int count);

  /// No description provided for @achDescScore.
  ///
  /// In en, this message translates to:
  /// **'Score {score} points in one game'**
  String achDescScore(int score);

  /// No description provided for @achDescCombo.
  ///
  /// In en, this message translates to:
  /// **'Reach a {count}x combo'**
  String achDescCombo(int count);

  /// No description provided for @achDescDailyTotal.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Complete a daily challenge} other{Complete {count} daily challenges}}'**
  String achDescDailyTotal(int count);

  /// No description provided for @achDescDailyStreak.
  ///
  /// In en, this message translates to:
  /// **'Complete daily challenges {count} days in a row'**
  String achDescDailyStreak(int count);

  /// No description provided for @achDescWinning.
  ///
  /// In en, this message translates to:
  /// **'Win {count} winning deals'**
  String achDescWinning(int count);

  /// No description provided for @achDescAutoFinish.
  ///
  /// In en, this message translates to:
  /// **'Finish a game with Auto'**
  String get achDescAutoFinish;

  /// No description provided for @achDescMarathon.
  ///
  /// In en, this message translates to:
  /// **'Play for {hours} hours in total'**
  String achDescMarathon(int hours);

  /// No description provided for @achDescCollector.
  ///
  /// In en, this message translates to:
  /// **'Buy {count} cosmetic items'**
  String achDescCollector(int count);

  /// No description provided for @achDescStylist.
  ///
  /// In en, this message translates to:
  /// **'Apply a new theme'**
  String get achDescStylist;

  /// No description provided for @achDescLevel.
  ///
  /// In en, this message translates to:
  /// **'Reach level {level}'**
  String achDescLevel(int level);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'id',
    'it',
    'ja',
    'ko',
    'pl',
    'pt',
    'ro',
    'ru',
    'tr',
    'uk',
    'vi',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ro':
      return AppLocalizationsRo();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
    case 'uk':
      return AppLocalizationsUk();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
