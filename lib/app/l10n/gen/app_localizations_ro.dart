// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get appTitle => 'Solitaire Nova';

  @override
  String splashLoading(int percent) {
    return 'Se încarcă… $percent%';
  }

  @override
  String get navHome => 'Acasă';

  @override
  String get navStats => 'Statistici';

  @override
  String get navShop => 'Magazin';

  @override
  String get navProfile => 'Profil';

  @override
  String get gameModeSetting => 'Mod de joc';

  @override
  String get navSettings => 'Setări';

  @override
  String get back => 'Înapoi';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Anulează';

  @override
  String get confirm => 'Confirmă';

  @override
  String get close => 'Închide';

  @override
  String levelLabel(int level) {
    return 'Nivel $level';
  }

  @override
  String coinsBalance(int coins) {
    return '$coins monede';
  }

  @override
  String get continueGame => 'Continuă';

  @override
  String continueSubtitle(String mode, int moves, String time) {
    return '$mode · $moves mutări · $time';
  }

  @override
  String get playClassic => 'Joc Clasic';

  @override
  String get drawOne => 'Câte 1';

  @override
  String get drawThree => 'Câte 3';

  @override
  String get dealRandom => 'Împărțire aleatorie';

  @override
  String get dealWinning => 'Împărțire câștigătoare';

  @override
  String get dealWinningInfo =>
      'Împărțirile câștigătoare sunt verificate ca rezolvabile de algoritmul nostru. Împărțirile aleatorii pot să nu aibă soluție.';

  @override
  String get dailyChallenge => 'Provocarea Zilei';

  @override
  String get achievements => 'Realizări';

  @override
  String get themes => 'Teme';

  @override
  String get statistics => 'Statistici';

  @override
  String get shop => 'Magazin';

  @override
  String get settings => 'Setări';

  @override
  String get modeRandom => 'Aleatoriu';

  @override
  String get modeWinning => 'Câștigătoare';

  @override
  String get modeDaily => 'Zilnic';

  @override
  String get hudScore => 'Scor';

  @override
  String get hudTime => 'Timp';

  @override
  String get hudMoves => 'Mutări';

  @override
  String get actionUndo => 'Anulează';

  @override
  String get actionHint => 'Indiciu';

  @override
  String get actionAuto => 'Auto';

  @override
  String get actionNew => 'Nou';

  @override
  String get actionPause => 'Pauză';

  @override
  String hintsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de indicii rămase',
      few: '$count indicii rămase',
      one: '1 indiciu rămas',
      zero: 'Niciun indiciu rămas',
    );
    return '$_temp0';
  }

  @override
  String semStock(int count) {
    return 'Pachet, $count cărți. Atinge pentru a trage.';
  }

  @override
  String get semStockRecycle =>
      'Pachet gol. Atinge pentru a întoarce cărțile trase.';

  @override
  String get semStockEmpty => 'Pachet gol';

  @override
  String get semWaste => 'Cărți trase';

  @override
  String semFoundation(String suit, int count) {
    return 'Fundația de $suit, $count cărți';
  }

  @override
  String semEmptyColumn(int column) {
    return 'Coloana goală $column';
  }

  @override
  String semCard(String rank, String suit) {
    return '$rank de $suit';
  }

  @override
  String get semFaceDown => 'Carte cu fața în jos';

  @override
  String get suitClubs => 'treflă';

  @override
  String get suitDiamonds => 'caro';

  @override
  String get suitHearts => 'inimă roșie';

  @override
  String get suitSpades => 'inimă neagră';

  @override
  String get rankAce => 'As';

  @override
  String get rankJack => 'Valet';

  @override
  String get rankQueen => 'Damă';

  @override
  String get rankKing => 'Rege';

  @override
  String get noMovesTitle => 'Nicio mutare utilă';

  @override
  String get noMovesBody =>
      'Momentan nu există mutări productive. Poți anula, reporni această împărțire sau începe un joc nou.';

  @override
  String get noHintsTitle => 'Nu mai ai indicii';

  @override
  String get noHintsBody =>
      'Obține mai multe indicii cu monede sau urmărind o reclamă scurtă, opțională.';

  @override
  String buyHints(int count, int price) {
    return 'Cumpără $count cu $price';
  }

  @override
  String watchAdHints(int count) {
    return 'Reclamă pentru $count';
  }

  @override
  String get hintsDisabled => 'Indiciile sunt dezactivate în Setări.';

  @override
  String get actionShuffle => 'Amestecă';

  @override
  String get shuffleTitle => 'Amesteci cărțile?';

  @override
  String shuffleBody(int left) {
    return 'Toate cărțile, în afară de cele de pe fundații, vor fi amestecate și împărțite din nou. Acțiunea nu poate fi anulată. Amestecări rămase în acest joc: $left.';
  }

  @override
  String get shuffleInfo =>
      'Toate cărțile, în afară de cele de pe fundații, vor fi amestecate și împărțite din nou. Acțiunea nu poate fi anulată.';

  @override
  String get shufflesLeftLabel => 'Amestecări rămase în acest joc';

  @override
  String shufflePay(int price) {
    return 'Plătește $price monede';
  }

  @override
  String get shuffleWatchAd => 'Vezi o reclamă';

  @override
  String get shuffleLimit => 'Nu mai ai amestecări în acest joc.';

  @override
  String get autoFinishing => 'Se finalizează…';

  @override
  String get skip => 'Sari peste';

  @override
  String get pauseTitle => 'Pauză';

  @override
  String get resume => 'Continuă';

  @override
  String get restartDeal => 'Repornește împărțirea';

  @override
  String get newGame => 'Joc nou';

  @override
  String get home => 'Acasă';

  @override
  String get restartTitle => 'Repornești această împărțire?';

  @override
  String get restartBody =>
      'Progresul din acest joc se va pierde. Vei juca aceeași împărțire de la început.';

  @override
  String get newGameTitle => 'Începi un joc nou?';

  @override
  String get newGameBody => 'Jocul curent va fi numărat ca pierdut.';

  @override
  String get victoryTitle => 'Victorie!';

  @override
  String get finalScore => 'Scor final';

  @override
  String get timeLabel => 'Timp';

  @override
  String get movesLabel => 'Mutări';

  @override
  String get maxCombo => 'Combo maxim';

  @override
  String get speedBonus => 'Bonus de viteză';

  @override
  String get timeBonus => 'Bonus de timp';

  @override
  String get bestScore => 'Cel mai bun scor';

  @override
  String get newRecord => 'Record nou!';

  @override
  String coinsEarned(int coins) {
    return '+$coins';
  }

  @override
  String get doubleCoins => 'Dublează monedele · reclamă';

  @override
  String get coinsDoubled => 'Monede dublate!';

  @override
  String get playAgain => 'Joc nou';

  @override
  String get mainMenu => 'Meniu principal';

  @override
  String achievementUnlocked(String name) {
    return 'Realizare deblocată: $name';
  }

  @override
  String get dailyTitle => 'Provocarea Zilei';

  @override
  String get todaysChallenge => 'Provocarea de astăzi';

  @override
  String get dailyInfo => 'Împărțire câștigătoare · Câte 1';

  @override
  String dailyReward(int coins) {
    return 'Recompensă: $coins';
  }

  @override
  String get play => 'Joacă';

  @override
  String playDay(String date) {
    return 'Joacă $date';
  }

  @override
  String get dailyCompleted => 'Finalizată';

  @override
  String get dailyRewardClaimed => 'Recompensă primită';

  @override
  String get dailyPastNoReward => 'Zilele trecute primesc o bifă, nu monede.';

  @override
  String dailyStreak(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Serie de $days de zile',
      few: 'Serie de $days zile',
      one: 'Serie de 1 zi',
      zero: 'Nicio serie activă',
    );
    return '$_temp0';
  }

  @override
  String get dailyCalendarNote =>
      'Provocările urmează data din calendarul dispozitivului.';

  @override
  String get dailyFuture => 'Încă indisponibilă';

  @override
  String dailyCompletedCount(int count) {
    return '$count finalizate';
  }

  @override
  String get previousMonth => 'Luna anterioară';

  @override
  String get nextMonth => 'Luna următoare';

  @override
  String get themesBackgrounds => 'Fundaluri';

  @override
  String get themesCards => 'Cărți';

  @override
  String get themesTables => 'Mese';

  @override
  String get apply => 'Aplică';

  @override
  String get applied => 'Aplicat';

  @override
  String get locked => 'Blocat';

  @override
  String get restoreDefaults => 'Restabilește implicitele';

  @override
  String get getInShop => 'Obține din magazin';

  @override
  String get themesContrastNote =>
      'Previzualizarea arată lizibilitatea cărților pe această masă.';

  @override
  String get cosmetic_cards_classic => 'Clasic';

  @override
  String get cosmetic_cards_elegant => 'Elegant';

  @override
  String get cosmetic_cards_vintage => 'Vintage';

  @override
  String get cosmetic_cards_modern => 'Modern';

  @override
  String get cosmetic_cards_neon => 'Neon';

  @override
  String get cosmetic_cards_gold => 'Auriu';

  @override
  String get cosmetic_bg_lake => 'Lac de munte';

  @override
  String get cosmetic_bg_autumn => 'Cărare de toamnă';

  @override
  String get cosmetic_bg_tropic => 'Golf tropical';

  @override
  String get cosmetic_bg_alpine => 'Vârfuri alpine';

  @override
  String get cosmetic_bg_aurora => 'Aurora boreală';

  @override
  String get cosmetic_bg_lavender => 'Amurg de lavandă';

  @override
  String get cosmetic_table_emerald => 'Postav smarald';

  @override
  String get cosmetic_table_navy => 'Bleumarin nocturn';

  @override
  String get cosmetic_table_burgundy => 'Burgund regal';

  @override
  String get cosmetic_table_walnut => 'Nuc';

  @override
  String get cosmetic_table_slate => 'Ardezie';

  @override
  String get cosmetic_table_contrast => 'Contrast ridicat';

  @override
  String get statsTotal => 'Total';

  @override
  String get statsPlayed => 'Partide jucate';

  @override
  String get statsWins => 'Victorii';

  @override
  String get statsWinRate => 'Rată victorii';

  @override
  String get statsTotalTime => 'Timp total';

  @override
  String get statsBestScore => 'Scor maxim';

  @override
  String get statsFastest => 'Cea mai rapidă victorie';

  @override
  String get statsCurrentStreak => 'Serie curentă';

  @override
  String get statsBestStreak => 'Cea mai lungă serie';

  @override
  String get statsMaxCombo => 'Combo maxim';

  @override
  String get statsFewestMoves => 'Cele mai puține mutări';

  @override
  String get statsDailyDone => 'Provocări zilnice';

  @override
  String get statsEmpty =>
      'Joacă primul tău joc pentru a-ți vedea statisticile aici.';

  @override
  String get statsLocalLabel => 'Salvate pe acest dispozitiv';

  @override
  String durationHm(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String achievementsProgress(int done, int total) {
    return '$done din $total deblocate';
  }

  @override
  String earnedOn(String date) {
    return 'Obținută pe $date';
  }

  @override
  String rewardCoins(int coins) {
    return '+$coins';
  }

  @override
  String get shopTitle => 'Magazin';

  @override
  String get shopCardPacks => 'Pachete de cărți';

  @override
  String get shopBackgrounds => 'Fundaluri';

  @override
  String get shopTables => 'Mese';

  @override
  String get shopHints => 'Indicii';

  @override
  String watchAdCoins(int coins) {
    return 'Vezi o reclamă: +$coins monede';
  }

  @override
  String get buy => 'Cumpără';

  @override
  String get owned => 'Deținut';

  @override
  String get equip => 'Folosește';

  @override
  String get equipped => 'În uz';

  @override
  String purchaseTitle(String item) {
    return 'Cumperi $item?';
  }

  @override
  String purchaseBody(int price, int after) {
    return 'Costă $price monede. Sold după cumpărare: $after.';
  }

  @override
  String get insufficientTitle => 'Monede insuficiente';

  @override
  String insufficientBody(int missing) {
    return 'Îți mai trebuie $missing monede. Câștigă jocuri, finalizează provocări zilnice și deblochează realizări pentru a obține mai multe.';
  }

  @override
  String purchaseDone(String item) {
    return '$item deblocat!';
  }

  @override
  String get hintPackTitle => 'Pachet de indicii';

  @override
  String hintPackBody(int count, int price) {
    return '$count indicii pentru $price monede';
  }

  @override
  String hintsOwned(int count) {
    return 'Ai $count indicii';
  }

  @override
  String get coinsDisclaimer =>
      'Monedele sunt o monedă din joc fără valoare bănească. Nu pot fi cumpărate, vândute, retrase sau schimbate.';

  @override
  String get settingsGameplay => 'Joc';

  @override
  String get settingsAudio => 'Sunet și vibrații';

  @override
  String get settingsDisplay => 'Afișare';

  @override
  String get settingsPrivacy => 'Confidențialitate';

  @override
  String get settingsData => 'Date și cont';

  @override
  String get settingsAbout => 'Despre';

  @override
  String get music => 'Muzică';

  @override
  String get sound => 'Sunet';

  @override
  String get haptics => 'Vibrații';

  @override
  String get reducedMotion => 'Reduce animațiile';

  @override
  String get leftHanded => 'Mod stângaci';

  @override
  String get defaultDraw => 'Mod implicit de tragere';

  @override
  String get tapToFoundation => 'Atingerea trimite întâi cărțile la fundații';

  @override
  String get hintsSetting => 'Indicii';

  @override
  String get showTimer => 'Afișează cronometrul';

  @override
  String get unlimitedPasses => 'Treceri nelimitate prin pachet';

  @override
  String get limitedPassesNote =>
      'Dezactivat: Câte 1 permite 2 reîntoarceri, Câte 3 permite 3.';

  @override
  String get foundationMoves => 'Permite mutări din fundații';

  @override
  String get rulesNextGame =>
      'Modificările de reguli se aplică din jocul următor.';

  @override
  String get language => 'Limbă';

  @override
  String get languageSystem => 'Implicit sistem';

  @override
  String get cloudBackup => 'Backup în cloud';

  @override
  String get cloudBackupUnavailable =>
      'Backup-ul în cloud nu este configurat în această versiune. Progresul tău este salvat pe acest dispozitiv.';

  @override
  String get signIn => 'Autentificare';

  @override
  String get privacyChoices => 'Confidențialitate și reclame';

  @override
  String get analyticsSetting => 'Trimite statistici anonime de utilizare';

  @override
  String get personalizedAds => 'Reclame personalizate';

  @override
  String get privacyPolicy => 'Politica de confidențialitate';

  @override
  String get privacyPolicyBody =>
      'Solitaire Nova îți păstrează jocurile, statisticile și achizițiile doar pe acest dispozitiv. Nu este nevoie de cont. Dacă permiți, pot fi folosite statistici anonime de utilizare și reclame (prin Google AdMob); partenerii de publicitate pot procesa identificatori ai dispozitivului conform opțiunilor tale de consimțământ. Îți poți retrage consimțământul oricând din Setări.';

  @override
  String get deleteData => 'Șterge datele locale';

  @override
  String get deleteDataTitle => 'Ștergi toate datele locale?';

  @override
  String get deleteDataBody =>
      'Aceasta elimină definitiv jocul salvat, statisticile, realizările, monedele și obiectele de pe acest dispozitiv. Acțiunea nu poate fi anulată.';

  @override
  String get deleteDataDone => 'Datele locale au fost șterse';

  @override
  String get delete => 'Șterge';

  @override
  String get restorePurchases => 'Restabilește achizițiile';

  @override
  String get restoreNone =>
      'Nu există achiziții din magazin de restabilit. Obiectele cumpărate cu monede rămân pe acest dispozitiv.';

  @override
  String get howToPlay => 'Cum se joacă';

  @override
  String get rulesTableau =>
      'Construiește cele șapte coloane în ordine descrescătoare, alternând culorile (roșu pe negru, negru pe roșu). Doar un Rege poate ocupa o coloană goală.';

  @override
  String get rulesFoundation =>
      'Mută toate cărțile pe cele patru fundații, pe culori, de la As la Rege.';

  @override
  String get rulesStock =>
      'Atinge pachetul pentru a întoarce 1 sau 3 cărți. Când se golește, atinge din nou pentru a întoarce cărțile trase.';

  @override
  String get rulesControls =>
      'Atinge o carte ca s-o trimiți sus, pe fundații, sau trage-o pe orice coloană. Poți anula orice mutare, poți cere un indiciu sau poți lăsa Auto să termine jocul când toate cărțile sunt descoperite.';

  @override
  String get rulesCombo =>
      'Combo-urile numără mutările productive consecutive. Sunt doar pentru distracție și nu schimbă regulile.';

  @override
  String get about => 'Despre joc';

  @override
  String version(String version) {
    return 'Versiunea $version';
  }

  @override
  String get licenses => 'Licențe open-source';

  @override
  String get aboutBody =>
      'Un Solitaire Klondike clasic. Fără jocuri de noroc, fără premii în bani.';

  @override
  String get consentTitle => 'Confidențialitatea ta';

  @override
  String get consentBody =>
      'Solitaire Nova funcționează complet offline. Cu permisiunea ta, afișăm reclame care mențin jocul gratuit și colectăm statistici anonime de utilizare pentru a-l îmbunătăți. Poți schimba oricând aceste opțiuni în Setări.';

  @override
  String get consentAccept => 'Accept';

  @override
  String get consentEssential => 'Doar esențiale';

  @override
  String get offlineTitle => 'Ești offline';

  @override
  String get offlineBody =>
      'Această funcție necesită conexiune la internet. Jocul în sine funcționează offline.';

  @override
  String get adUnavailableTitle => 'Nicio reclamă disponibilă';

  @override
  String get adUnavailableBody =>
      'Momentan nu există nicio reclamă de afișat. Încearcă mai târziu.';

  @override
  String get adNotCompleted =>
      'Reclama a fost închisă înainte de obținerea recompensei.';

  @override
  String get cloudConflictTitle => 'Două jocuri salvate găsite';

  @override
  String get cloudConflictBody =>
      'Atât acest dispozitiv, cât și backup-ul din cloud au un joc în desfășurare. Pe care vrei să-l păstrezi?';

  @override
  String get keepThisDevice => 'Păstrează dispozitivul';

  @override
  String get keepCloud => 'Păstrează cloud-ul';

  @override
  String get errorTitle => 'A apărut o eroare';

  @override
  String get errorBody =>
      'Progresul tău este în siguranță. Te rugăm să încerci din nou.';

  @override
  String get achTitle_first_win => 'Prima victorie';

  @override
  String get achTitle_wins_10 => 'Stea în ascensiune';

  @override
  String get achTitle_wins_50 => 'Mână sigură';

  @override
  String get achTitle_wins_100 => 'Maestru Solitaire';

  @override
  String get achTitle_wins_250 => 'Mare maestru';

  @override
  String get achTitle_wins_500 => 'Legendă vie';

  @override
  String get achTitle_played_10 => 'Primii pași';

  @override
  String get achTitle_played_100 => 'Jucător fidel';

  @override
  String get achTitle_played_500 => 'Pasionat';

  @override
  String get achTitle_streak_3 => 'Triplă';

  @override
  String get achTitle_streak_5 => 'În formă';

  @override
  String get achTitle_streak_10 => 'De neoprit';

  @override
  String get achTitle_draw3_first => 'Amenințare triplă';

  @override
  String get achTitle_draw3_25 => 'Veteran Câte 3';

  @override
  String get achTitle_no_hints => 'Pe cont propriu';

  @override
  String get achTitle_no_undo => 'Fără regrete';

  @override
  String get achTitle_purist_10 => 'Purist';

  @override
  String get achTitle_speed_5 => 'Mâini iuți';

  @override
  String get achTitle_speed_3 => 'Rapid';

  @override
  String get achTitle_speed_2 => 'Viteză';

  @override
  String get achTitle_moves_120 => 'Eficient';

  @override
  String get achTitle_moves_100 => 'Econom';

  @override
  String get achTitle_score_4000 => 'Scor mare';

  @override
  String get achTitle_score_6000 => 'Legenda scorului';

  @override
  String get achTitle_combo_5 => 'Început de combo';

  @override
  String get achTitle_combo_10 => 'Combo Expert';

  @override
  String get achTitle_daily_first => 'Debut zilnic';

  @override
  String get achTitle_daily_total_10 => 'Obișnuit zilnic';

  @override
  String get achTitle_daily_total_30 => 'Devotat zilnic';

  @override
  String get achTitle_daily_streak_7 => 'Jucător Zilnic';

  @override
  String get achTitle_winning_10 => 'Încheietor de împărțiri';

  @override
  String get achTitle_auto_finish => 'Final lin';

  @override
  String get achTitle_marathon => 'Maraton';

  @override
  String get achTitle_collector_5 => 'Colecționar';

  @override
  String get achTitle_stylist => 'Stilist';

  @override
  String get achTitle_level_10 => 'Experimentat';

  @override
  String achDescWins(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Câștigă $count de jocuri',
      few: 'Câștigă $count jocuri',
      one: 'Câștigă primul joc',
    );
    return '$_temp0';
  }

  @override
  String achDescPlayed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Joacă $count de jocuri',
      few: 'Joacă $count jocuri',
      one: 'Joacă 1 joc',
    );
    return '$_temp0';
  }

  @override
  String achDescStreak(int count) {
    return 'Câștigă $count jocuri la rând';
  }

  @override
  String achDescDraw3(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Câștigă $count de jocuri Câte 3',
      few: 'Câștigă $count jocuri Câte 3',
      one: 'Câștigă un joc Câte 3',
    );
    return '$_temp0';
  }

  @override
  String get achDescNoHints => 'Câștigă un joc fără indicii';

  @override
  String get achDescNoUndo => 'Câștigă un joc fără să anulezi';

  @override
  String achDescPurist(int count) {
    return 'Câștigă $count jocuri fără indicii sau anulări';
  }

  @override
  String achDescSpeed(int minutes) {
    return 'Câștigă un joc în mai puțin de $minutes minute';
  }

  @override
  String achDescMoves(int count) {
    return 'Câștigă un joc în cel mult $count de mutări';
  }

  @override
  String achDescScore(int score) {
    return 'Obține $score de puncte într-un joc';
  }

  @override
  String achDescCombo(int count) {
    return 'Atinge un combo de ${count}x';
  }

  @override
  String achDescDailyTotal(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Finalizează $count de provocări zilnice',
      few: 'Finalizează $count provocări zilnice',
      one: 'Finalizează o provocare zilnică',
    );
    return '$_temp0';
  }

  @override
  String achDescDailyStreak(int count) {
    return 'Finalizează provocări zilnice $count zile la rând';
  }

  @override
  String achDescWinning(int count) {
    return 'Câștigă $count împărțiri câștigătoare';
  }

  @override
  String get achDescAutoFinish => 'Termină un joc cu Auto';

  @override
  String achDescMarathon(int hours) {
    return 'Joacă $hours ore în total';
  }

  @override
  String achDescCollector(int count) {
    return 'Cumpără $count obiecte cosmetice';
  }

  @override
  String get achDescStylist => 'Aplică o temă nouă';

  @override
  String achDescLevel(int level) {
    return 'Atinge nivelul $level';
  }
}
