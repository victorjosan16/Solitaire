// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Solitaire Nova';

  @override
  String splashLoading(int percent) {
    return 'Wird geladen… $percent %';
  }

  @override
  String get navHome => 'Start';

  @override
  String get navStats => 'Statistik';

  @override
  String get navShop => 'Shop';

  @override
  String get navProfile => 'Profil';

  @override
  String get gameModeSetting => 'Spielmodus';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get back => 'Zurück';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get close => 'Schließen';

  @override
  String levelLabel(int level) {
    return 'Level $level';
  }

  @override
  String coinsBalance(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins Münzen',
      one: '1 Münze',
    );
    return '$_temp0';
  }

  @override
  String get continueGame => 'Fortsetzen';

  @override
  String continueSubtitle(String mode, int moves, String time) {
    return '$mode · $moves Züge · $time';
  }

  @override
  String get playClassic => 'Klassisches Spiel';

  @override
  String get drawOne => '1 ziehen';

  @override
  String get drawThree => '3 ziehen';

  @override
  String get dealRandom => 'Zufällige Partie';

  @override
  String get dealWinning => 'Gewinnbare Partie';

  @override
  String get dealWinningInfo =>
      'Gewinnbare Partien wurden von unserem Löser als lösbar bestätigt. Zufällige Partien haben möglicherweise keine Lösung.';

  @override
  String get dailyChallenge => 'Tagesaufgabe';

  @override
  String get achievements => 'Erfolge';

  @override
  String get themes => 'Designs';

  @override
  String get statistics => 'Statistik';

  @override
  String get shop => 'Shop';

  @override
  String get settings => 'Einstellungen';

  @override
  String get modeRandom => 'Zufällig';

  @override
  String get modeWinning => 'Gewinnbar';

  @override
  String get modeDaily => 'Tagesaufgabe';

  @override
  String get hudScore => 'Punkte';

  @override
  String get hudTime => 'Zeit';

  @override
  String get hudMoves => 'Züge';

  @override
  String get actionUndo => 'Zurück';

  @override
  String get actionHint => 'Tipp';

  @override
  String get actionAuto => 'Auto';

  @override
  String get actionNew => 'Neu';

  @override
  String get actionPause => 'Pause';

  @override
  String hintsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Noch $count Tipps',
      one: 'Noch 1 Tipp',
      zero: 'Keine Tipps mehr',
    );
    return '$_temp0';
  }

  @override
  String semStock(int count) {
    return 'Stapel, $count Karten. Tippen zum Ziehen.';
  }

  @override
  String get semStockRecycle =>
      'Stapel leer. Tippen, um den Ablagestapel umzudrehen.';

  @override
  String get semStockEmpty => 'Stapel leer';

  @override
  String get semWaste => 'Ablagestapel';

  @override
  String semFoundation(String suit, int count) {
    return 'Ablage $suit, $count Karten';
  }

  @override
  String semEmptyColumn(int column) {
    return 'Leere Spalte $column';
  }

  @override
  String semCard(String rank, String suit) {
    return '$suit $rank';
  }

  @override
  String get semFaceDown => 'Verdeckte Karte';

  @override
  String get suitClubs => 'Kreuz';

  @override
  String get suitDiamonds => 'Karo';

  @override
  String get suitHearts => 'Herz';

  @override
  String get suitSpades => 'Pik';

  @override
  String get rankAce => 'Ass';

  @override
  String get rankJack => 'Bube';

  @override
  String get rankQueen => 'Dame';

  @override
  String get rankKing => 'König';

  @override
  String get noMovesTitle => 'Keine sinnvollen Züge';

  @override
  String get noMovesBody =>
      'Gerade gibt es keine sinnvollen Züge. Du kannst Züge zurücknehmen, diese Partie neu starten oder ein neues Spiel beginnen.';

  @override
  String get noHintsTitle => 'Keine Tipps mehr';

  @override
  String get noHintsBody =>
      'Hol dir weitere Tipps mit Münzen oder durch eine kurze, freiwillige Werbung.';

  @override
  String buyHints(int count, int price) {
    return '$count für $price kaufen';
  }

  @override
  String watchAdHints(int count) {
    return 'Werbung für $count';
  }

  @override
  String get hintsDisabled => 'Tipps sind in den Einstellungen deaktiviert.';

  @override
  String get actionShuffle => 'Mischen';

  @override
  String get shuffleTitle => 'Karten mischen?';

  @override
  String shuffleBody(int left) {
    return 'Alle Karten außer denen auf den Ablagen werden gemischt und neu ausgeteilt. Das kann nicht rückgängig gemacht werden. Verbleibendes Mischen in diesem Spiel: $left.';
  }

  @override
  String shufflePay(int price) {
    return '$price Münzen zahlen';
  }

  @override
  String get shuffleWatchAd => 'Werbung ansehen';

  @override
  String get shuffleLimit => 'In diesem Spiel kannst du nicht mehr mischen.';

  @override
  String get autoFinishing => 'Wird beendet…';

  @override
  String get skip => 'Überspringen';

  @override
  String get pauseTitle => 'Pausiert';

  @override
  String get resume => 'Weiter';

  @override
  String get restartDeal => 'Partie neu starten';

  @override
  String get newGame => 'Neues Spiel';

  @override
  String get home => 'Start';

  @override
  String get restartTitle => 'Diese Partie neu starten?';

  @override
  String get restartBody =>
      'Dein Fortschritt in diesem Spiel geht verloren. Du spielst dieselbe Partie von vorn.';

  @override
  String get newGameTitle => 'Neues Spiel starten?';

  @override
  String get newGameBody => 'Das aktuelle Spiel wird als verloren gewertet.';

  @override
  String get victoryTitle => 'Sieg!';

  @override
  String get finalScore => 'Endpunktzahl';

  @override
  String get timeLabel => 'Zeit';

  @override
  String get movesLabel => 'Züge';

  @override
  String get maxCombo => 'Max. Combo';

  @override
  String get speedBonus => 'Tempobonus';

  @override
  String get timeBonus => 'Zeitbonus';

  @override
  String get bestScore => 'Bestwert';

  @override
  String get newRecord => 'Neuer Rekord!';

  @override
  String coinsEarned(int coins) {
    return '+$coins';
  }

  @override
  String get doubleCoins => 'Münzen verdoppeln · Werbung';

  @override
  String get coinsDoubled => 'Münzen verdoppelt!';

  @override
  String get playAgain => 'Neues Spiel';

  @override
  String get mainMenu => 'Hauptmenü';

  @override
  String achievementUnlocked(String name) {
    return 'Erfolg freigeschaltet: $name';
  }

  @override
  String get dailyTitle => 'Tagesaufgabe';

  @override
  String get todaysChallenge => 'Heutige Aufgabe';

  @override
  String get dailyInfo => 'Gewinnbare Partie · 1 ziehen';

  @override
  String dailyReward(int coins) {
    return 'Belohnung: $coins';
  }

  @override
  String get play => 'Spielen';

  @override
  String playDay(String date) {
    return '$date spielen';
  }

  @override
  String get dailyCompleted => 'Geschafft';

  @override
  String get dailyRewardClaimed => 'Belohnung erhalten';

  @override
  String get dailyPastNoReward =>
      'Vergangene Tage bringen einen Haken, aber keine Münzen.';

  @override
  String dailyStreak(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Serie: $days Tage',
      one: 'Serie: 1 Tag',
      zero: 'Keine aktuelle Serie',
    );
    return '$_temp0';
  }

  @override
  String get dailyCalendarNote =>
      'Aufgaben richten sich nach dem Kalenderdatum deines Geräts.';

  @override
  String get dailyFuture => 'Noch nicht verfügbar';

  @override
  String dailyCompletedCount(int count) {
    return '$count geschafft';
  }

  @override
  String get previousMonth => 'Vorheriger Monat';

  @override
  String get nextMonth => 'Nächster Monat';

  @override
  String get themesBackgrounds => 'Hintergründe';

  @override
  String get themesCards => 'Karten';

  @override
  String get themesTables => 'Tische';

  @override
  String get apply => 'Anwenden';

  @override
  String get applied => 'Aktiv';

  @override
  String get locked => 'Gesperrt';

  @override
  String get restoreDefaults => 'Standard wiederherstellen';

  @override
  String get getInShop => 'Im Shop holen';

  @override
  String get themesContrastNote =>
      'Die Vorschau zeigt die Lesbarkeit der Karten auf diesem Tisch.';

  @override
  String get cosmetic_cards_classic => 'Klassisch';

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
  String get cosmetic_bg_lake => 'Bergsee';

  @override
  String get cosmetic_bg_autumn => 'Herbstpfad';

  @override
  String get cosmetic_bg_tropic => 'Tropenbucht';

  @override
  String get cosmetic_bg_alpine => 'Alpengipfel';

  @override
  String get cosmetic_bg_aurora => 'Nordlicht';

  @override
  String get cosmetic_bg_lavender => 'Lavendeldämmerung';

  @override
  String get cosmetic_table_emerald => 'Smaragdfilz';

  @override
  String get cosmetic_table_navy => 'Mitternachtsblau';

  @override
  String get cosmetic_table_burgundy => 'Königsbordeaux';

  @override
  String get cosmetic_table_walnut => 'Nussbaum';

  @override
  String get cosmetic_table_slate => 'Schiefer';

  @override
  String get cosmetic_table_contrast => 'Hoher Kontrast';

  @override
  String get statsTotal => 'Gesamt';

  @override
  String get statsPlayed => 'Gespielte Spiele';

  @override
  String get statsWins => 'Siege';

  @override
  String get statsWinRate => 'Siegquote';

  @override
  String get statsTotalTime => 'Gesamtzeit';

  @override
  String get statsBestScore => 'Bestwert';

  @override
  String get statsFastest => 'Schnellster Sieg';

  @override
  String get statsCurrentStreak => 'Aktuelle Serie';

  @override
  String get statsBestStreak => 'Beste Serie';

  @override
  String get statsMaxCombo => 'Max. Combo';

  @override
  String get statsFewestMoves => 'Wenigste Züge';

  @override
  String get statsDailyDone => 'Tagesaufgaben';

  @override
  String get statsEmpty =>
      'Spiel dein erstes Spiel, um hier deine Statistik zu sehen.';

  @override
  String get statsLocalLabel => 'Auf diesem Gerät gespeichert';

  @override
  String durationHm(int hours, int minutes) {
    return '$hours Std. $minutes Min.';
  }

  @override
  String achievementsProgress(int done, int total) {
    return '$done von $total freigeschaltet';
  }

  @override
  String earnedOn(String date) {
    return 'Erhalten am $date';
  }

  @override
  String rewardCoins(int coins) {
    return '+$coins';
  }

  @override
  String get shopTitle => 'Shop';

  @override
  String get shopCardPacks => 'Kartensets';

  @override
  String get shopBackgrounds => 'Hintergründe';

  @override
  String get shopTables => 'Tische';

  @override
  String get shopHints => 'Tipps';

  @override
  String watchAdCoins(int coins) {
    return 'Werbung ansehen: +$coins Münzen';
  }

  @override
  String get buy => 'Kaufen';

  @override
  String get owned => 'Im Besitz';

  @override
  String get equip => 'Verwenden';

  @override
  String get equipped => 'Aktiv';

  @override
  String purchaseTitle(String item) {
    return '$item kaufen?';
  }

  @override
  String purchaseBody(int price, int after) {
    return 'Kostet $price Münzen. Guthaben danach: $after.';
  }

  @override
  String get insufficientTitle => 'Nicht genug Münzen';

  @override
  String insufficientBody(int missing) {
    return 'Dir fehlen $missing Münzen. Gewinne Spiele, schließe Tagesaufgaben ab und schalte Erfolge frei, um mehr zu verdienen.';
  }

  @override
  String purchaseDone(String item) {
    return '$item freigeschaltet!';
  }

  @override
  String get hintPackTitle => 'Tipp-Paket';

  @override
  String hintPackBody(int count, int price) {
    return '$count Tipps für $price Münzen';
  }

  @override
  String hintsOwned(int count) {
    return 'Du hast $count Tipps';
  }

  @override
  String get coinsDisclaimer =>
      'Münzen sind eine Spielwährung ohne Geldwert. Sie können nicht gekauft, verkauft, ausgezahlt oder getauscht werden.';

  @override
  String get settingsGameplay => 'Spiel';

  @override
  String get settingsAudio => 'Ton & Haptik';

  @override
  String get settingsDisplay => 'Anzeige';

  @override
  String get settingsPrivacy => 'Datenschutz';

  @override
  String get settingsData => 'Daten & Konto';

  @override
  String get settingsAbout => 'Über';

  @override
  String get music => 'Musik';

  @override
  String get sound => 'Soundeffekte';

  @override
  String get haptics => 'Vibration';

  @override
  String get reducedMotion => 'Bewegung reduzieren';

  @override
  String get leftHanded => 'Linkshändermodus';

  @override
  String get defaultDraw => 'Standard-Ziehmodus';

  @override
  String get tapToFoundation => 'Tippen legt Karten zuerst auf die Ablage';

  @override
  String get hintsSetting => 'Tipps';

  @override
  String get showTimer => 'Timer anzeigen';

  @override
  String get unlimitedPasses => 'Unbegrenzte Stapeldurchgänge';

  @override
  String get limitedPassesNote =>
      'Aus: „1 ziehen“ erlaubt 2 Durchgänge mehr, „3 ziehen“ 3.';

  @override
  String get foundationMoves => 'Züge von der Ablage erlauben';

  @override
  String get rulesNextGame => 'Regeländerungen gelten ab dem nächsten Spiel.';

  @override
  String get language => 'Sprache';

  @override
  String get languageSystem => 'Systemstandard';

  @override
  String get cloudBackup => 'Cloud-Backup';

  @override
  String get cloudBackupUnavailable =>
      'Cloud-Backup ist in dieser Version nicht eingerichtet. Dein Fortschritt wird auf diesem Gerät gespeichert.';

  @override
  String get signIn => 'Anmelden';

  @override
  String get privacyChoices => 'Datenschutz & Werbung';

  @override
  String get analyticsSetting => 'Anonyme Nutzungsstatistiken teilen';

  @override
  String get personalizedAds => 'Personalisierte Werbung';

  @override
  String get privacyPolicy => 'Datenschutzerklärung';

  @override
  String get privacyPolicyBody =>
      'Solitaire Nova speichert deine Spiele, Statistiken und Käufe nur auf diesem Gerät. Ein Konto ist nicht nötig. Wenn du zustimmst, können anonyme Nutzungsstatistiken und Werbung (über Google AdMob) verwendet werden; Werbepartner können Gerätekennungen gemäß deinen Einwilligungen verarbeiten. Du kannst deine Einwilligung jederzeit in den Einstellungen widerrufen.';

  @override
  String get deleteData => 'Lokale Daten löschen';

  @override
  String get deleteDataTitle => 'Alle lokalen Daten löschen?';

  @override
  String get deleteDataBody =>
      'Dadurch werden dein gespeichertes Spiel, Statistiken, Erfolge, Münzen und Gegenstände auf diesem Gerät dauerhaft entfernt. Dies kann nicht rückgängig gemacht werden.';

  @override
  String get deleteDataDone => 'Lokale Daten gelöscht';

  @override
  String get delete => 'Löschen';

  @override
  String get restorePurchases => 'Käufe wiederherstellen';

  @override
  String get restoreNone =>
      'Es gibt keine Store-Käufe zum Wiederherstellen. Mit Münzen gekaufte Gegenstände bleiben auf diesem Gerät.';

  @override
  String get howToPlay => 'Spielanleitung';

  @override
  String get rulesTableau =>
      'Baue die sieben Spalten absteigend in wechselnden Farben (Rot auf Schwarz, Schwarz auf Rot). Nur ein König darf eine leere Spalte belegen.';

  @override
  String get rulesFoundation =>
      'Lege alle Karten nach Farbe vom Ass bis zum König auf die vier Ablagen.';

  @override
  String get rulesStock =>
      'Tippe auf den Stapel, um 1 oder 3 Karten aufzudecken. Ist er leer, tippe erneut, um den Ablagestapel umzudrehen.';

  @override
  String get rulesControls =>
      'Tippe auf eine Karte, um sie automatisch zu bewegen, oder ziehe sie. Nimm jeden Zug zurück, hol dir einen Tipp oder lass Auto das Spiel beenden, wenn alle Karten aufgedeckt sind.';

  @override
  String get rulesCombo =>
      'Combos zählen aufeinanderfolgende sinnvolle Züge. Sie sind nur zum Spaß und ändern die Regeln nicht.';

  @override
  String get about => 'Über';

  @override
  String version(String version) {
    return 'Version $version';
  }

  @override
  String get licenses => 'Open-Source-Lizenzen';

  @override
  String get aboutBody =>
      'Ein klassisches Klondike-Solitaire. Kein Glücksspiel, keine Geldpreise.';

  @override
  String get consentTitle => 'Deine Privatsphäre';

  @override
  String get consentBody =>
      'Solitaire Nova funktioniert vollständig offline. Mit deiner Erlaubnis zeigen wir Werbung, die das Spiel kostenlos hält, und erfassen anonyme Nutzungsstatistiken, um es zu verbessern. Du kannst das jederzeit in den Einstellungen ändern.';

  @override
  String get consentAccept => 'Akzeptieren';

  @override
  String get consentEssential => 'Nur notwendige';

  @override
  String get offlineTitle => 'Du bist offline';

  @override
  String get offlineBody =>
      'Diese Funktion benötigt eine Internetverbindung. Das Spiel selbst funktioniert offline.';

  @override
  String get adUnavailableTitle => 'Keine Werbung verfügbar';

  @override
  String get adUnavailableBody =>
      'Gerade ist keine Werbung verfügbar. Bitte versuche es später erneut.';

  @override
  String get adNotCompleted =>
      'Die Werbung wurde vor Erhalt der Belohnung geschlossen.';

  @override
  String get cloudConflictTitle => 'Zwei gespeicherte Spiele gefunden';

  @override
  String get cloudConflictBody =>
      'Sowohl dieses Gerät als auch dein Cloud-Backup haben ein laufendes Spiel. Welches möchtest du behalten?';

  @override
  String get keepThisDevice => 'Dieses Gerät';

  @override
  String get keepCloud => 'Cloud';

  @override
  String get errorTitle => 'Etwas ist schiefgelaufen';

  @override
  String get errorBody =>
      'Dein Fortschritt ist sicher. Bitte versuche es erneut.';

  @override
  String get achTitle_first_win => 'Erster Sieg';

  @override
  String get achTitle_wins_10 => 'Aufsteiger';

  @override
  String get achTitle_wins_50 => 'Kartenprofi';

  @override
  String get achTitle_wins_100 => 'Solitaire-Meister';

  @override
  String get achTitle_wins_250 => 'Großmeister';

  @override
  String get achTitle_wins_500 => 'Lebende Legende';

  @override
  String get achTitle_played_10 => 'Erste Schritte';

  @override
  String get achTitle_played_100 => 'Stammgast';

  @override
  String get achTitle_played_500 => 'Leidenschaft';

  @override
  String get achTitle_streak_3 => 'Hattrick';

  @override
  String get achTitle_streak_5 => 'In Topform';

  @override
  String get achTitle_streak_10 => 'Unaufhaltsam';

  @override
  String get achTitle_draw3_first => 'Dreifache Gefahr';

  @override
  String get achTitle_draw3_25 => '3-Ziehen-Veteran';

  @override
  String get achTitle_no_hints => 'Ganz allein';

  @override
  String get achTitle_no_undo => 'Keine Reue';

  @override
  String get achTitle_purist_10 => 'Purist';

  @override
  String get achTitle_speed_5 => 'Flinke Hände';

  @override
  String get achTitle_speed_3 => 'Rasant';

  @override
  String get achTitle_speed_2 => 'Blitz';

  @override
  String get achTitle_moves_120 => 'Effizient';

  @override
  String get achTitle_moves_100 => 'Sparfuchs';

  @override
  String get achTitle_score_4000 => 'Punktejäger';

  @override
  String get achTitle_score_6000 => 'Punktelegende';

  @override
  String get achTitle_combo_5 => 'Combo-Starter';

  @override
  String get achTitle_combo_10 => 'Combo-Experte';

  @override
  String get achTitle_daily_first => 'Tagesdebüt';

  @override
  String get achTitle_daily_total_10 => 'Stammspieler';

  @override
  String get achTitle_daily_total_30 => 'Tagesprofi';

  @override
  String get achTitle_daily_streak_7 => 'Täglich dabei';

  @override
  String get achTitle_winning_10 => 'Abschlussstark';

  @override
  String get achTitle_auto_finish => 'Sanftes Finale';

  @override
  String get achTitle_marathon => 'Marathon';

  @override
  String get achTitle_collector_5 => 'Sammler';

  @override
  String get achTitle_stylist => 'Stilbewusst';

  @override
  String get achTitle_level_10 => 'Erfahren';

  @override
  String achDescWins(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Gewinne $count Spiele',
      one: 'Gewinne dein erstes Spiel',
    );
    return '$_temp0';
  }

  @override
  String achDescPlayed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Spiele $count Spiele',
      one: 'Spiele 1 Spiel',
    );
    return '$_temp0';
  }

  @override
  String achDescStreak(int count) {
    return 'Gewinne $count Spiele in Folge';
  }

  @override
  String achDescDraw3(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Gewinne $count „3 ziehen“-Spiele',
      one: 'Gewinne ein „3 ziehen“-Spiel',
    );
    return '$_temp0';
  }

  @override
  String get achDescNoHints => 'Gewinne ein Spiel ohne Tipps';

  @override
  String get achDescNoUndo => 'Gewinne ein Spiel ohne Zurücknehmen';

  @override
  String achDescPurist(int count) {
    return 'Gewinne $count Spiele ohne Tipps und Zurücknehmen';
  }

  @override
  String achDescSpeed(int minutes) {
    return 'Gewinne ein Spiel in unter $minutes Minuten';
  }

  @override
  String achDescMoves(int count) {
    return 'Gewinne ein Spiel mit höchstens $count Zügen';
  }

  @override
  String achDescScore(int score) {
    return 'Erziele $score Punkte in einem Spiel';
  }

  @override
  String achDescCombo(int count) {
    return 'Erreiche eine ${count}x-Combo';
  }

  @override
  String achDescDailyTotal(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Schließe $count Tagesaufgaben ab',
      one: 'Schließe eine Tagesaufgabe ab',
    );
    return '$_temp0';
  }

  @override
  String achDescDailyStreak(int count) {
    return 'Schließe $count Tage in Folge die Tagesaufgabe ab';
  }

  @override
  String achDescWinning(int count) {
    return 'Gewinne $count gewinnbare Partien';
  }

  @override
  String get achDescAutoFinish => 'Beende ein Spiel mit Auto';

  @override
  String achDescMarathon(int hours) {
    return 'Spiele insgesamt $hours Stunden';
  }

  @override
  String achDescCollector(int count) {
    return 'Kaufe $count kosmetische Gegenstände';
  }

  @override
  String get achDescStylist => 'Wende ein neues Design an';

  @override
  String achDescLevel(int level) {
    return 'Erreiche Level $level';
  }
}
