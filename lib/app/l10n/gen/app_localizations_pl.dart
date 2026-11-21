// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Solitaire Nova';

  @override
  String splashLoading(int percent) {
    return 'Wczytywanie… $percent%';
  }

  @override
  String get navHome => 'Start';

  @override
  String get navStats => 'Statystyki';

  @override
  String get navShop => 'Sklep';

  @override
  String get navProfile => 'Profil';

  @override
  String get gameModeSetting => 'Tryb gry';

  @override
  String get navSettings => 'Ustawienia';

  @override
  String get back => 'Wstecz';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Anuluj';

  @override
  String get confirm => 'Potwierdź';

  @override
  String get close => 'Zamknij';

  @override
  String levelLabel(int level) {
    return 'Poziom $level';
  }

  @override
  String coinsBalance(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins monety',
      many: '$coins monet',
      few: '$coins monety',
      one: '$coins moneta',
    );
    return '$_temp0';
  }

  @override
  String get continueGame => 'Kontynuuj';

  @override
  String continueSubtitle(String mode, int moves, String time) {
    return '$mode · ruchy: $moves · $time';
  }

  @override
  String get playClassic => 'Gra klasyczna';

  @override
  String get drawOne => 'Dobierz 1';

  @override
  String get drawThree => 'Dobierz 3';

  @override
  String get dealRandom => 'Losowe rozdanie';

  @override
  String get dealWinning => 'Wygrywalne rozdanie';

  @override
  String get dealWinningInfo =>
      'Wygrywalne rozdania zostały sprawdzone przez nasz solwer jako rozwiązywalne. Losowe rozdanie może nie mieć rozwiązania.';

  @override
  String get dailyChallenge => 'Wyzwanie dnia';

  @override
  String get achievements => 'Osiągnięcia';

  @override
  String get themes => 'Motywy';

  @override
  String get statistics => 'Statystyki';

  @override
  String get shop => 'Sklep';

  @override
  String get settings => 'Ustawienia';

  @override
  String get modeRandom => 'Losowe';

  @override
  String get modeWinning => 'Wygrywalne';

  @override
  String get modeDaily => 'Dzienne';

  @override
  String get hudScore => 'Wynik';

  @override
  String get hudTime => 'Czas';

  @override
  String get hudMoves => 'Ruchy';

  @override
  String get actionUndo => 'Cofnij';

  @override
  String get actionHint => 'Podpowiedź';

  @override
  String get actionAuto => 'Auto';

  @override
  String get actionNew => 'Nowa';

  @override
  String get actionPause => 'Pauza';

  @override
  String hintsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Zostało $count podpowiedzi',
      many: 'Zostało $count podpowiedzi',
      few: 'Zostały $count podpowiedzi',
      one: 'Została $count podpowiedź',
      zero: 'Brak podpowiedzi',
    );
    return '$_temp0';
  }

  @override
  String semStock(int count) {
    return 'Talia, kart: $count. Dotknij, aby dobrać.';
  }

  @override
  String get semStockRecycle =>
      'Talia pusta. Dotknij, aby odwrócić odrzucone karty.';

  @override
  String get semStockEmpty => 'Talia pusta';

  @override
  String get semWaste => 'Odkryte karty';

  @override
  String semFoundation(String suit, int count) {
    return 'Stos bazowy, $suit, kart: $count';
  }

  @override
  String semEmptyColumn(int column) {
    return 'Pusta kolumna $column';
  }

  @override
  String semCard(String rank, String suit) {
    return '$rank $suit';
  }

  @override
  String get semFaceDown => 'Zakryta karta';

  @override
  String get suitClubs => 'trefl';

  @override
  String get suitDiamonds => 'karo';

  @override
  String get suitHearts => 'kier';

  @override
  String get suitSpades => 'pik';

  @override
  String get rankAce => 'As';

  @override
  String get rankJack => 'Walet';

  @override
  String get rankQueen => 'Dama';

  @override
  String get rankKing => 'Król';

  @override
  String get noMovesTitle => 'Brak przydatnych ruchów';

  @override
  String get noMovesBody =>
      'W tej chwili nie ma przydatnych ruchów. Możesz cofnąć ruch, zacząć to rozdanie od nowa lub rozpocząć nową grę.';

  @override
  String get noHintsTitle => 'Brak podpowiedzi';

  @override
  String get noHintsBody =>
      'Zdobądź więcej podpowiedzi za monety lub oglądając krótką, opcjonalną reklamę.';

  @override
  String buyHints(int count, int price) {
    return 'Kup $count za $price';
  }

  @override
  String watchAdHints(int count) {
    return 'Reklama: +$count';
  }

  @override
  String get hintsDisabled => 'Podpowiedzi są wyłączone w ustawieniach.';

  @override
  String get actionShuffle => 'Tasuj';

  @override
  String get shuffleTitle => 'Potasować karty?';

  @override
  String shuffleBody(int left) {
    return 'Wszystkie karty poza tymi na stosach bazowych zostaną potasowane i rozdane od nowa. Tej operacji nie można cofnąć. Pozostałe tasowania w tej grze: $left.';
  }

  @override
  String get shuffleInfo =>
      'Wszystkie karty poza tymi na stosach bazowych zostaną potasowane i rozdane od nowa. Tej operacji nie można cofnąć.';

  @override
  String get shufflesLeftLabel => 'Pozostałe tasowania w tej grze';

  @override
  String shufflePay(int price) {
    return 'Zapłać $price monet';
  }

  @override
  String get shuffleWatchAd => 'Obejrzyj reklamę';

  @override
  String get shuffleLimit => 'W tej grze nie zostały już tasowania.';

  @override
  String get autoFinishing => 'Kończenie…';

  @override
  String get skip => 'Pomiń';

  @override
  String get pauseTitle => 'Pauza';

  @override
  String get resume => 'Wznów';

  @override
  String get restartDeal => 'Zacznij rozdanie od nowa';

  @override
  String get newGame => 'Nowa gra';

  @override
  String get home => 'Start';

  @override
  String get restartTitle => 'Zacząć to rozdanie od nowa?';

  @override
  String get restartBody =>
      'Postęp w tej grze zostanie utracony. Zagrasz to samo rozdanie od początku.';

  @override
  String get newGameTitle => 'Rozpocząć nową grę?';

  @override
  String get newGameBody => 'Bieżąca gra zostanie policzona jako przegrana.';

  @override
  String get victoryTitle => 'Zwycięstwo!';

  @override
  String get finalScore => 'Wynik końcowy';

  @override
  String get timeLabel => 'Czas';

  @override
  String get movesLabel => 'Ruchy';

  @override
  String get maxCombo => 'Maks. kombo';

  @override
  String get speedBonus => 'Premia za szybkość';

  @override
  String get timeBonus => 'Premia za czas';

  @override
  String get bestScore => 'Najlepszy wynik';

  @override
  String get newRecord => 'Nowy rekord!';

  @override
  String coinsEarned(int coins) {
    return '+$coins';
  }

  @override
  String get doubleCoins => 'Podwój monety · reklama';

  @override
  String get coinsDoubled => 'Monety podwojone!';

  @override
  String get playAgain => 'Nowa gra';

  @override
  String get mainMenu => 'Menu główne';

  @override
  String achievementUnlocked(String name) {
    return 'Odblokowano osiągnięcie: $name';
  }

  @override
  String get dailyTitle => 'Wyzwanie dnia';

  @override
  String get todaysChallenge => 'Dzisiejsze wyzwanie';

  @override
  String get dailyInfo => 'Wygrywalne rozdanie · Dobierz 1';

  @override
  String dailyReward(int coins) {
    return 'Nagroda: $coins';
  }

  @override
  String get play => 'Graj';

  @override
  String playDay(String date) {
    return 'Graj $date';
  }

  @override
  String get dailyCompleted => 'Ukończone';

  @override
  String get dailyRewardClaimed => 'Nagroda odebrana';

  @override
  String get dailyPastNoReward =>
      'Za minione dni dostajesz znacznik, ale nie monety.';

  @override
  String dailyStreak(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Seria: $days dni',
      one: 'Seria: 1 dzień',
      zero: 'Brak aktualnej serii',
    );
    return '$_temp0';
  }

  @override
  String get dailyCalendarNote =>
      'Wyzwania są zgodne z datą w kalendarzu urządzenia.';

  @override
  String get dailyFuture => 'Jeszcze niedostępne';

  @override
  String dailyCompletedCount(int count) {
    return 'Ukończono: $count';
  }

  @override
  String get previousMonth => 'Poprzedni miesiąc';

  @override
  String get nextMonth => 'Następny miesiąc';

  @override
  String get themesBackgrounds => 'Tła';

  @override
  String get themesCards => 'Karty';

  @override
  String get themesTables => 'Stoły';

  @override
  String get apply => 'Zastosuj';

  @override
  String get applied => 'Zastosowano';

  @override
  String get locked => 'Zablokowane';

  @override
  String get restoreDefaults => 'Przywróć domyślne';

  @override
  String get getInShop => 'Zdobądź w sklepie';

  @override
  String get themesContrastNote =>
      'Podgląd pokazuje czytelność kart na tym stole.';

  @override
  String get cosmetic_cards_classic => 'Klasyczne';

  @override
  String get cosmetic_cards_elegant => 'Eleganckie';

  @override
  String get cosmetic_cards_vintage => 'Vintage';

  @override
  String get cosmetic_cards_modern => 'Nowoczesne';

  @override
  String get cosmetic_cards_neon => 'Neon';

  @override
  String get cosmetic_cards_gold => 'Złote';

  @override
  String get cosmetic_bg_lake => 'Górskie jezioro';

  @override
  String get cosmetic_bg_autumn => 'Jesienna ścieżka';

  @override
  String get cosmetic_bg_tropic => 'Tropikalna zatoka';

  @override
  String get cosmetic_bg_alpine => 'Alpejskie szczyty';

  @override
  String get cosmetic_bg_aurora => 'Zorza polarna';

  @override
  String get cosmetic_bg_lavender => 'Lawendowy zmierzch';

  @override
  String get cosmetic_table_emerald => 'Szmaragdowe sukno';

  @override
  String get cosmetic_table_navy => 'Nocny granat';

  @override
  String get cosmetic_table_burgundy => 'Królewski burgund';

  @override
  String get cosmetic_table_walnut => 'Orzech';

  @override
  String get cosmetic_table_slate => 'Łupek';

  @override
  String get cosmetic_table_contrast => 'Wysoki kontrast';

  @override
  String get statsTotal => 'Łącznie';

  @override
  String get statsPlayed => 'Rozegrane gry';

  @override
  String get statsWins => 'Zwycięstwa';

  @override
  String get statsWinRate => 'Odsetek zwycięstw';

  @override
  String get statsTotalTime => 'Łączny czas';

  @override
  String get statsBestScore => 'Najlepszy wynik';

  @override
  String get statsFastest => 'Najszybsze zwycięstwo';

  @override
  String get statsCurrentStreak => 'Obecna seria';

  @override
  String get statsBestStreak => 'Najlepsza seria';

  @override
  String get statsMaxCombo => 'Maks. kombo';

  @override
  String get statsFewestMoves => 'Najmniej ruchów';

  @override
  String get statsDailyDone => 'Wyzwania dnia';

  @override
  String get statsEmpty =>
      'Zagraj pierwszą grę, aby zobaczyć tutaj statystyki.';

  @override
  String get statsLocalLabel => 'Zapisane na tym urządzeniu';

  @override
  String durationHm(int hours, int minutes) {
    return '$hours godz. $minutes min';
  }

  @override
  String achievementsProgress(int done, int total) {
    return 'Odblokowano $done z $total';
  }

  @override
  String earnedOn(String date) {
    return 'Zdobyto $date';
  }

  @override
  String rewardCoins(int coins) {
    return '+$coins';
  }

  @override
  String get shopTitle => 'Sklep';

  @override
  String get shopCardPacks => 'Talie';

  @override
  String get shopBackgrounds => 'Tła';

  @override
  String get shopTables => 'Stoły';

  @override
  String get shopHints => 'Podpowiedzi';

  @override
  String watchAdCoins(int coins) {
    return 'Obejrzyj reklamę: +$coins monet';
  }

  @override
  String get buy => 'Kup';

  @override
  String get owned => 'Posiadane';

  @override
  String get equip => 'Użyj';

  @override
  String get equipped => 'W użyciu';

  @override
  String purchaseTitle(String item) {
    return 'Kupić „$item”?';
  }

  @override
  String purchaseBody(int price, int after) {
    return 'Koszt: $price monet. Saldo po zakupie: $after.';
  }

  @override
  String get insufficientTitle => 'Za mało monet';

  @override
  String insufficientBody(int missing) {
    return 'Brakuje ci monet: $missing. Wygrywaj gry, kończ wyzwania dnia i odblokowuj osiągnięcia, aby zdobyć więcej.';
  }

  @override
  String purchaseDone(String item) {
    return 'Odblokowano „$item”!';
  }

  @override
  String get hintPackTitle => 'Pakiet podpowiedzi';

  @override
  String hintPackBody(int count, int price) {
    return 'Podpowiedzi: $count za $price monet';
  }

  @override
  String hintsOwned(int count) {
    return 'Twoje podpowiedzi: $count';
  }

  @override
  String get coinsDisclaimer =>
      'Monety to waluta w grze bez wartości pieniężnej. Nie można ich kupić, sprzedać, wypłacić ani wymienić.';

  @override
  String get settingsGameplay => 'Rozgrywka';

  @override
  String get settingsAudio => 'Dźwięk i wibracje';

  @override
  String get settingsDisplay => 'Wyświetlanie';

  @override
  String get settingsPrivacy => 'Prywatność';

  @override
  String get settingsData => 'Dane i konto';

  @override
  String get settingsAbout => 'Informacje';

  @override
  String get music => 'Muzyka';

  @override
  String get sound => 'Efekty dźwiękowe';

  @override
  String get haptics => 'Wibracje';

  @override
  String get reducedMotion => 'Ogranicz animacje';

  @override
  String get leftHanded => 'Tryb dla leworęcznych';

  @override
  String get defaultDraw => 'Domyślny tryb dobierania';

  @override
  String get tapToFoundation => 'Dotknięcie najpierw przenosi na stosy bazowe';

  @override
  String get hintsSetting => 'Podpowiedzi';

  @override
  String get showTimer => 'Pokaż czas';

  @override
  String get unlimitedPasses => 'Nieograniczone przejścia talii';

  @override
  String get limitedPassesNote =>
      'Wyłączone: Dobierz 1 pozwala na 2 odwrócenia, Dobierz 3 na 3.';

  @override
  String get foundationMoves => 'Zezwalaj na ruchy ze stosów bazowych';

  @override
  String get rulesNextGame => 'Zmiany zasad obowiązują od następnej gry.';

  @override
  String get language => 'Język';

  @override
  String get languageSystem => 'Domyślny systemu';

  @override
  String get cloudBackup => 'Kopia w chmurze';

  @override
  String get cloudBackupUnavailable =>
      'Kopia w chmurze nie jest skonfigurowana w tej wersji. Twój postęp jest zapisywany na tym urządzeniu.';

  @override
  String get signIn => 'Zaloguj się';

  @override
  String get privacyChoices => 'Prywatność i reklamy';

  @override
  String get analyticsSetting => 'Udostępniaj anonimowe statystyki użycia';

  @override
  String get personalizedAds => 'Spersonalizowane reklamy';

  @override
  String get privacyPolicy => 'Polityka prywatności';

  @override
  String get privacyPolicyBody =>
      'Solitaire Nova przechowuje twoje gry, statystyki i zakupy wyłącznie na tym urządzeniu. Konto nie jest potrzebne. Jeśli wyrazisz zgodę, mogą być używane anonimowe statystyki użycia i reklamy (przez Google AdMob); partnerzy reklamowi mogą przetwarzać identyfikatory urządzenia zgodnie z twoimi wyborami. Zgodę możesz w każdej chwili wycofać w ustawieniach.';

  @override
  String get deleteData => 'Usuń dane lokalne';

  @override
  String get deleteDataTitle => 'Usunąć wszystkie dane lokalne?';

  @override
  String get deleteDataBody =>
      'Spowoduje to trwałe usunięcie zapisanej gry, statystyk, osiągnięć, monet i przedmiotów z tego urządzenia. Tej operacji nie można cofnąć.';

  @override
  String get deleteDataDone => 'Dane lokalne usunięte';

  @override
  String get delete => 'Usuń';

  @override
  String get restorePurchases => 'Przywróć zakupy';

  @override
  String get restoreNone =>
      'Brak zakupów ze sklepu do przywrócenia. Przedmioty kupione za monety pozostają na tym urządzeniu.';

  @override
  String get howToPlay => 'Jak grać';

  @override
  String get rulesTableau =>
      'Układaj siedem kolumn malejąco, naprzemiennie kolorami (czerwona na czarnej, czarna na czerwonej). Tylko król może zająć pustą kolumnę.';

  @override
  String get rulesFoundation =>
      'Przenieś wszystkie karty na cztery stosy bazowe, według kolorów, od asa do króla.';

  @override
  String get rulesStock =>
      'Dotknij talii, aby odkryć 1 lub 3 karty. Gdy się skończy, dotknij ponownie, aby odwrócić odkryte karty.';

  @override
  String get rulesControls =>
      'Dotknij karty, aby wysłać ją na stos bazowy, albo przeciągnij ją na dowolną kolumnę. Cofaj ruchy, proś o podpowiedź lub pozwól, by Auto dokończyło grę, gdy wszystkie karty są odkryte.';

  @override
  String get rulesCombo =>
      'Kombo liczy kolejne przydatne ruchy. To tylko dla zabawy — zasady się nie zmieniają.';

  @override
  String get about => 'O grze';

  @override
  String version(String version) {
    return 'Wersja $version';
  }

  @override
  String get licenses => 'Licencje open source';

  @override
  String get aboutBody =>
      'Klasyczny pasjans Klondike. Bez hazardu i nagród pieniężnych.';

  @override
  String get consentTitle => 'Twoja prywatność';

  @override
  String get consentBody =>
      'Solitaire Nova działa w pełni offline. Za twoją zgodą wyświetlamy reklamy, dzięki którym gra jest darmowa, i zbieramy anonimowe statystyki użycia, aby ją ulepszać. Możesz to zmienić w każdej chwili w ustawieniach.';

  @override
  String get consentAccept => 'Akceptuję';

  @override
  String get consentEssential => 'Tylko niezbędne';

  @override
  String get offlineTitle => 'Jesteś offline';

  @override
  String get offlineBody =>
      'Ta funkcja wymaga połączenia z internetem. Sama gra działa offline.';

  @override
  String get adUnavailableTitle => 'Brak dostępnej reklamy';

  @override
  String get adUnavailableBody =>
      'W tej chwili nie ma reklamy do wyświetlenia. Spróbuj później.';

  @override
  String get adNotCompleted =>
      'Reklama została zamknięta przed zdobyciem nagrody.';

  @override
  String get cloudConflictTitle => 'Znaleziono dwie zapisane gry';

  @override
  String get cloudConflictBody =>
      'Zarówno to urządzenie, jak i kopia w chmurze mają rozpoczętą grę. Którą zachować?';

  @override
  String get keepThisDevice => 'To urządzenie';

  @override
  String get keepCloud => 'Chmura';

  @override
  String get errorTitle => 'Coś poszło nie tak';

  @override
  String get errorBody => 'Twój postęp jest bezpieczny. Spróbuj ponownie.';

  @override
  String get achTitle_first_win => 'Pierwsze zwycięstwo';

  @override
  String get achTitle_wins_10 => 'Wschodząca gwiazda';

  @override
  String get achTitle_wins_50 => 'Karciany wyjadacz';

  @override
  String get achTitle_wins_100 => 'Mistrz pasjansa';

  @override
  String get achTitle_wins_250 => 'Arcymistrz';

  @override
  String get achTitle_wins_500 => 'Żywa legenda';

  @override
  String get achTitle_played_10 => 'Pierwsze kroki';

  @override
  String get achTitle_played_100 => 'Stały bywalec';

  @override
  String get achTitle_played_500 => 'Pasjonat';

  @override
  String get achTitle_streak_3 => 'Hat-trick';

  @override
  String get achTitle_streak_5 => 'W formie';

  @override
  String get achTitle_streak_10 => 'Nie do zatrzymania';

  @override
  String get achTitle_draw3_first => 'Potrójne zagrożenie';

  @override
  String get achTitle_draw3_25 => 'Weteran „Dobierz 3”';

  @override
  String get achTitle_no_hints => 'Samodzielny';

  @override
  String get achTitle_no_undo => 'Bez żalu';

  @override
  String get achTitle_purist_10 => 'Purysta';

  @override
  String get achTitle_speed_5 => 'Zwinne dłonie';

  @override
  String get achTitle_speed_3 => 'Szybki';

  @override
  String get achTitle_speed_2 => 'Błyskawica';

  @override
  String get achTitle_moves_120 => 'Wydajny';

  @override
  String get achTitle_moves_100 => 'Oszczędny';

  @override
  String get achTitle_score_4000 => 'Wysoki wynik';

  @override
  String get achTitle_score_6000 => 'Legenda wyników';

  @override
  String get achTitle_combo_5 => 'Początek kombo';

  @override
  String get achTitle_combo_10 => 'Ekspert kombo';

  @override
  String get achTitle_daily_first => 'Dzienny debiut';

  @override
  String get achTitle_daily_total_10 => 'Codzienny gracz';

  @override
  String get achTitle_daily_total_30 => 'Wierny wyzwaniom';

  @override
  String get achTitle_daily_streak_7 => 'Gracz dnia';

  @override
  String get achTitle_winning_10 => 'Finiszer';

  @override
  String get achTitle_auto_finish => 'Płynny finisz';

  @override
  String get achTitle_marathon => 'Maraton';

  @override
  String get achTitle_collector_5 => 'Kolekcjoner';

  @override
  String get achTitle_stylist => 'Stylista';

  @override
  String get achTitle_level_10 => 'Doświadczony';

  @override
  String achDescWins(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Wygraj $count gry',
      many: 'Wygraj $count gier',
      few: 'Wygraj $count gry',
      one: 'Wygraj $count grę',
    );
    return '$_temp0';
  }

  @override
  String achDescPlayed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Zagraj $count gry',
      many: 'Zagraj $count gier',
      few: 'Zagraj $count gry',
      one: 'Zagraj $count grę',
    );
    return '$_temp0';
  }

  @override
  String achDescStreak(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Wygraj $count gry z rzędu',
      many: 'Wygraj $count gier z rzędu',
      few: 'Wygraj $count gry z rzędu',
      one: 'Wygraj $count grę z rzędu',
    );
    return '$_temp0';
  }

  @override
  String achDescDraw3(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Wygraj $count gry „Dobierz 3”',
      many: 'Wygraj $count gier „Dobierz 3”',
      few: 'Wygraj $count gry „Dobierz 3”',
      one: 'Wygraj $count grę „Dobierz 3”',
    );
    return '$_temp0';
  }

  @override
  String get achDescNoHints => 'Wygraj grę bez podpowiedzi';

  @override
  String get achDescNoUndo => 'Wygraj grę bez cofania ruchów';

  @override
  String achDescPurist(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Wygraj $count gry bez podpowiedzi i cofania',
      many: 'Wygraj $count gier bez podpowiedzi i cofania',
      few: 'Wygraj $count gry bez podpowiedzi i cofania',
      one: 'Wygraj $count grę bez podpowiedzi i cofania',
    );
    return '$_temp0';
  }

  @override
  String achDescSpeed(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Wygraj grę w mniej niż $minutes minuty',
      many: 'Wygraj grę w mniej niż $minutes minut',
      few: 'Wygraj grę w mniej niż $minutes minuty',
      one: 'Wygraj grę w mniej niż $minutes minutę',
    );
    return '$_temp0';
  }

  @override
  String achDescMoves(int count) {
    return 'Wygraj grę w maksymalnie $count ruchach';
  }

  @override
  String achDescScore(int score) {
    return 'Zdobądź $score punktów w jednej grze';
  }

  @override
  String achDescCombo(int count) {
    return 'Osiągnij kombo ${count}x';
  }

  @override
  String achDescDailyTotal(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ukończ $count wyzwania dnia',
      many: 'Ukończ $count wyzwań dnia',
      few: 'Ukończ $count wyzwania dnia',
      one: 'Ukończ $count wyzwanie dnia',
    );
    return '$_temp0';
  }

  @override
  String achDescDailyStreak(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ukończ wyzwania dnia $count dni z rzędu',
      one: 'Ukończ wyzwanie dnia $count dzień z rzędu',
    );
    return '$_temp0';
  }

  @override
  String achDescWinning(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Wygraj $count wygrywalnego rozdania',
      many: 'Wygraj $count wygrywalnych rozdań',
      few: 'Wygraj $count wygrywalne rozdania',
      one: 'Wygraj $count wygrywalne rozdanie',
    );
    return '$_temp0';
  }

  @override
  String get achDescAutoFinish => 'Zakończ grę za pomocą Auto';

  @override
  String achDescMarathon(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Graj łącznie $hours godziny',
      many: 'Graj łącznie $hours godzin',
      few: 'Graj łącznie $hours godziny',
      one: 'Graj łącznie $hours godzinę',
    );
    return '$_temp0';
  }

  @override
  String achDescCollector(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Kup $count przedmiotu kosmetycznego',
      many: 'Kup $count przedmiotów kosmetycznych',
      few: 'Kup $count przedmioty kosmetyczne',
      one: 'Kup $count przedmiot kosmetyczny',
    );
    return '$_temp0';
  }

  @override
  String get achDescStylist => 'Zastosuj nowy motyw';

  @override
  String achDescLevel(int level) {
    return 'Osiągnij poziom $level';
  }
}
