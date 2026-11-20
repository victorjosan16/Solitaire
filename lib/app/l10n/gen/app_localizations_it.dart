// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Solitaire Nova';

  @override
  String splashLoading(int percent) {
    return 'Caricamento… $percent%';
  }

  @override
  String get navHome => 'Home';

  @override
  String get navStats => 'Statistiche';

  @override
  String get navShop => 'Negozio';

  @override
  String get navSettings => 'Impostazioni';

  @override
  String get back => 'Indietro';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Annulla';

  @override
  String get confirm => 'Conferma';

  @override
  String get close => 'Chiudi';

  @override
  String levelLabel(int level) {
    return 'Livello $level';
  }

  @override
  String coinsBalance(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins monete',
      one: '1 moneta',
    );
    return '$_temp0';
  }

  @override
  String get continueGame => 'Continua';

  @override
  String continueSubtitle(String mode, int moves, String time) {
    return '$mode · $moves mosse · $time';
  }

  @override
  String get playClassic => 'Partita classica';

  @override
  String get drawOne => 'Pesca 1';

  @override
  String get drawThree => 'Pesca 3';

  @override
  String get dealRandom => 'Smazzata casuale';

  @override
  String get dealWinning => 'Smazzata vincibile';

  @override
  String get dealWinningInfo =>
      'Le smazzate vincibili sono state verificate come risolvibili dal nostro risolutore. Una smazzata casuale potrebbe non avere soluzione.';

  @override
  String get dailyChallenge => 'Sfida del giorno';

  @override
  String get achievements => 'Obiettivi';

  @override
  String get themes => 'Temi';

  @override
  String get statistics => 'Statistiche';

  @override
  String get shop => 'Negozio';

  @override
  String get settings => 'Impostazioni';

  @override
  String get modeRandom => 'Casuale';

  @override
  String get modeWinning => 'Vincibile';

  @override
  String get modeDaily => 'Giornaliera';

  @override
  String get hudScore => 'Punti';

  @override
  String get hudTime => 'Tempo';

  @override
  String get hudMoves => 'Mosse';

  @override
  String get actionUndo => 'Annulla';

  @override
  String get actionHint => 'Suggerimento';

  @override
  String get actionAuto => 'Auto';

  @override
  String get actionNew => 'Nuova';

  @override
  String get actionPause => 'Pausa';

  @override
  String hintsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count suggerimenti rimasti',
      one: '1 suggerimento rimasto',
      zero: 'Nessun suggerimento rimasto',
    );
    return '$_temp0';
  }

  @override
  String semStock(int count) {
    return 'Mazzo, $count carte. Tocca per pescare.';
  }

  @override
  String get semStockRecycle => 'Mazzo vuoto. Tocca per girare gli scarti.';

  @override
  String get semStockEmpty => 'Mazzo vuoto';

  @override
  String get semWaste => 'Scarti';

  @override
  String semFoundation(String suit, int count) {
    return 'Base di $suit, $count carte';
  }

  @override
  String semEmptyColumn(int column) {
    return 'Colonna vuota $column';
  }

  @override
  String semCard(String rank, String suit) {
    return '$rank di $suit';
  }

  @override
  String get semFaceDown => 'Carta coperta';

  @override
  String get suitClubs => 'fiori';

  @override
  String get suitDiamonds => 'quadri';

  @override
  String get suitHearts => 'cuori';

  @override
  String get suitSpades => 'picche';

  @override
  String get rankAce => 'Asso';

  @override
  String get rankJack => 'Fante';

  @override
  String get rankQueen => 'Regina';

  @override
  String get rankKing => 'Re';

  @override
  String get noMovesTitle => 'Nessuna mossa utile';

  @override
  String get noMovesBody =>
      'Al momento non ci sono mosse produttive. Puoi annullare, ricominciare questa smazzata o iniziare una nuova partita.';

  @override
  String get noHintsTitle => 'Suggerimenti esauriti';

  @override
  String get noHintsBody =>
      'Ottieni altri suggerimenti con le monete o guardando un breve annuncio facoltativo.';

  @override
  String buyHints(int count, int price) {
    return 'Compra $count per $price';
  }

  @override
  String watchAdHints(int count) {
    return 'Annuncio per $count';
  }

  @override
  String get hintsDisabled =>
      'I suggerimenti sono disattivati nelle Impostazioni.';

  @override
  String get autoFinishing => 'Completamento…';

  @override
  String get skip => 'Salta';

  @override
  String get pauseTitle => 'In pausa';

  @override
  String get resume => 'Riprendi';

  @override
  String get restartDeal => 'Ricomincia smazzata';

  @override
  String get newGame => 'Nuova partita';

  @override
  String get home => 'Home';

  @override
  String get restartTitle => 'Ricominciare questa smazzata?';

  @override
  String get restartBody =>
      'I progressi di questa partita andranno persi. Giocherai la stessa smazzata dall\'inizio.';

  @override
  String get newGameTitle => 'Iniziare una nuova partita?';

  @override
  String get newGameBody => 'La partita in corso verrà contata come persa.';

  @override
  String get victoryTitle => 'Vittoria!';

  @override
  String get finalScore => 'Punteggio finale';

  @override
  String get timeLabel => 'Tempo';

  @override
  String get movesLabel => 'Mosse';

  @override
  String get maxCombo => 'Combo massima';

  @override
  String get speedBonus => 'Bonus velocità';

  @override
  String get timeBonus => 'Bonus tempo';

  @override
  String get bestScore => 'Miglior punteggio';

  @override
  String get newRecord => 'Nuovo record!';

  @override
  String coinsEarned(int coins) {
    return '+$coins';
  }

  @override
  String get doubleCoins => 'Raddoppia monete · annuncio';

  @override
  String get coinsDoubled => 'Monete raddoppiate!';

  @override
  String get playAgain => 'Nuova partita';

  @override
  String get mainMenu => 'Menu principale';

  @override
  String achievementUnlocked(String name) {
    return 'Obiettivo sbloccato: $name';
  }

  @override
  String get dailyTitle => 'Sfida del giorno';

  @override
  String get todaysChallenge => 'Sfida di oggi';

  @override
  String get dailyInfo => 'Smazzata vincibile · Pesca 1';

  @override
  String dailyReward(int coins) {
    return 'Ricompensa: $coins';
  }

  @override
  String get play => 'Gioca';

  @override
  String playDay(String date) {
    return 'Gioca $date';
  }

  @override
  String get dailyCompleted => 'Completata';

  @override
  String get dailyRewardClaimed => 'Ricompensa ricevuta';

  @override
  String get dailyPastNoReward =>
      'I giorni passati danno una spunta, non monete.';

  @override
  String dailyStreak(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Serie di $days giorni',
      one: 'Serie di 1 giorno',
      zero: 'Nessuna serie in corso',
    );
    return '$_temp0';
  }

  @override
  String get dailyCalendarNote =>
      'Le sfide seguono la data del calendario del dispositivo.';

  @override
  String get dailyFuture => 'Non ancora disponibile';

  @override
  String dailyCompletedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count completate',
      one: '1 completata',
    );
    return '$_temp0';
  }

  @override
  String get previousMonth => 'Mese precedente';

  @override
  String get nextMonth => 'Mese successivo';

  @override
  String get themesBackgrounds => 'Sfondi';

  @override
  String get themesCards => 'Carte';

  @override
  String get themesTables => 'Tavoli';

  @override
  String get apply => 'Applica';

  @override
  String get applied => 'Applicato';

  @override
  String get locked => 'Bloccato';

  @override
  String get restoreDefaults => 'Ripristina predefiniti';

  @override
  String get getInShop => 'Ottieni nel negozio';

  @override
  String get themesContrastNote =>
      'L\'anteprima mostra la leggibilità delle carte su questo tavolo.';

  @override
  String get cosmetic_cards_classic => 'Classico';

  @override
  String get cosmetic_cards_elegant => 'Elegante';

  @override
  String get cosmetic_cards_vintage => 'Vintage';

  @override
  String get cosmetic_cards_modern => 'Moderno';

  @override
  String get cosmetic_cards_neon => 'Neon';

  @override
  String get cosmetic_cards_gold => 'Dorato';

  @override
  String get cosmetic_bg_lake => 'Lago di montagna';

  @override
  String get cosmetic_bg_autumn => 'Sentiero d\'autunno';

  @override
  String get cosmetic_bg_tropic => 'Baia tropicale';

  @override
  String get cosmetic_bg_alpine => 'Vette alpine';

  @override
  String get cosmetic_bg_aurora => 'Aurora boreale';

  @override
  String get cosmetic_bg_lavender => 'Crepuscolo di lavanda';

  @override
  String get cosmetic_table_emerald => 'Panno smeraldo';

  @override
  String get cosmetic_table_navy => 'Blu notte';

  @override
  String get cosmetic_table_burgundy => 'Bordeaux reale';

  @override
  String get cosmetic_table_walnut => 'Noce';

  @override
  String get cosmetic_table_slate => 'Ardesia';

  @override
  String get cosmetic_table_contrast => 'Contrasto elevato';

  @override
  String get statsTotal => 'Totale';

  @override
  String get statsPlayed => 'Partite giocate';

  @override
  String get statsWins => 'Vittorie';

  @override
  String get statsWinRate => 'Percentuale vittorie';

  @override
  String get statsTotalTime => 'Tempo totale';

  @override
  String get statsBestScore => 'Miglior punteggio';

  @override
  String get statsFastest => 'Vittoria più veloce';

  @override
  String get statsCurrentStreak => 'Serie attuale';

  @override
  String get statsBestStreak => 'Serie migliore';

  @override
  String get statsMaxCombo => 'Combo massima';

  @override
  String get statsFewestMoves => 'Meno mosse';

  @override
  String get statsDailyDone => 'Sfide del giorno';

  @override
  String get statsEmpty =>
      'Gioca la tua prima partita per vedere qui le statistiche.';

  @override
  String get statsLocalLabel => 'Salvato su questo dispositivo';

  @override
  String durationHm(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String achievementsProgress(int done, int total) {
    return '$done di $total sbloccati';
  }

  @override
  String earnedOn(String date) {
    return 'Ottenuto il $date';
  }

  @override
  String rewardCoins(int coins) {
    return '+$coins';
  }

  @override
  String get shopTitle => 'Negozio';

  @override
  String get shopCardPacks => 'Mazzi';

  @override
  String get shopBackgrounds => 'Sfondi';

  @override
  String get shopTables => 'Tavoli';

  @override
  String get shopHints => 'Suggerimenti';

  @override
  String get buy => 'Compra';

  @override
  String get owned => 'Posseduto';

  @override
  String get equip => 'Usa';

  @override
  String get equipped => 'In uso';

  @override
  String purchaseTitle(String item) {
    return 'Comprare $item?';
  }

  @override
  String purchaseBody(int price, int after) {
    return 'Costa $price monete. Saldo dopo l\'acquisto: $after.';
  }

  @override
  String get insufficientTitle => 'Monete insufficienti';

  @override
  String insufficientBody(int missing) {
    return 'Ti mancano $missing monete. Vinci partite, completa le sfide del giorno e sblocca obiettivi per guadagnarne altre.';
  }

  @override
  String purchaseDone(String item) {
    return '$item sbloccato!';
  }

  @override
  String get hintPackTitle => 'Pacchetto suggerimenti';

  @override
  String hintPackBody(int count, int price) {
    return '$count suggerimenti per $price monete';
  }

  @override
  String hintsOwned(int count) {
    return 'Hai $count suggerimenti';
  }

  @override
  String get coinsDisclaimer =>
      'Le monete sono una valuta di gioco senza valore monetario. Non possono essere acquistate, vendute, prelevate o scambiate.';

  @override
  String get settingsGameplay => 'Gioco';

  @override
  String get settingsAudio => 'Audio e vibrazione';

  @override
  String get settingsDisplay => 'Schermo';

  @override
  String get settingsPrivacy => 'Privacy';

  @override
  String get settingsData => 'Dati e account';

  @override
  String get settingsAbout => 'Informazioni';

  @override
  String get music => 'Musica';

  @override
  String get sound => 'Effetti sonori';

  @override
  String get haptics => 'Vibrazione';

  @override
  String get reducedMotion => 'Riduci animazioni';

  @override
  String get leftHanded => 'Modalità mancini';

  @override
  String get defaultDraw => 'Modalità di pesca predefinita';

  @override
  String get tapToFoundation => 'Il tocco invia prima alle basi';

  @override
  String get hintsSetting => 'Suggerimenti';

  @override
  String get showTimer => 'Mostra cronometro';

  @override
  String get unlimitedPasses => 'Passaggi illimitati del mazzo';

  @override
  String get limitedPassesNote =>
      'Se disattivato: Pesca 1 consente 2 giri, Pesca 3 ne consente 3.';

  @override
  String get foundationMoves => 'Consenti mosse dalle basi';

  @override
  String get rulesNextGame =>
      'Le modifiche alle regole valgono dalla prossima partita.';

  @override
  String get language => 'Lingua';

  @override
  String get languageSystem => 'Predefinita di sistema';

  @override
  String get cloudBackup => 'Backup nel cloud';

  @override
  String get cloudBackupUnavailable =>
      'Il backup nel cloud non è configurato in questa versione. I tuoi progressi sono salvati su questo dispositivo.';

  @override
  String get signIn => 'Accedi';

  @override
  String get privacyChoices => 'Privacy e annunci';

  @override
  String get analyticsSetting => 'Condividi statistiche d\'uso anonime';

  @override
  String get personalizedAds => 'Annunci personalizzati';

  @override
  String get privacyPolicy => 'Informativa sulla privacy';

  @override
  String get privacyPolicyBody =>
      'Solitaire Nova conserva partite, statistiche e acquisti solo su questo dispositivo. Non serve un account. Se lo consenti, possono essere usati statistiche d\'uso anonime e annunci (tramite Google AdMob); i partner pubblicitari possono trattare gli identificatori del dispositivo secondo le tue scelte di consenso. Puoi revocare il consenso in qualsiasi momento nelle Impostazioni.';

  @override
  String get deleteData => 'Elimina dati locali';

  @override
  String get deleteDataTitle => 'Eliminare tutti i dati locali?';

  @override
  String get deleteDataBody =>
      'Verranno rimossi definitivamente la partita salvata, le statistiche, gli obiettivi, le monete e gli oggetti su questo dispositivo. L\'operazione non può essere annullata.';

  @override
  String get deleteDataDone => 'Dati locali eliminati';

  @override
  String get delete => 'Elimina';

  @override
  String get restorePurchases => 'Ripristina acquisti';

  @override
  String get restoreNone =>
      'Non ci sono acquisti dello store da ripristinare. Gli oggetti comprati con le monete restano su questo dispositivo.';

  @override
  String get howToPlay => 'Come si gioca';

  @override
  String get rulesTableau =>
      'Costruisci le sette colonne in ordine decrescente alternando i colori (rosso su nero, nero su rosso). Solo un Re può occupare una colonna vuota.';

  @override
  String get rulesFoundation =>
      'Sposta tutte le carte sulle quattro basi, per seme, dall\'Asso al Re.';

  @override
  String get rulesStock =>
      'Tocca il mazzo per scoprire 1 o 3 carte. Quando è vuoto, toccalo di nuovo per girare gli scarti.';

  @override
  String get rulesControls =>
      'Tocca una carta per spostarla automaticamente oppure trascinala. Annulla qualsiasi mossa, chiedi un suggerimento o lascia che Auto completi la partita quando tutte le carte sono scoperte.';

  @override
  String get rulesCombo =>
      'Le combo contano le mosse utili consecutive. Sono solo per divertimento e non cambiano le regole.';

  @override
  String get about => 'Informazioni';

  @override
  String version(String version) {
    return 'Versione $version';
  }

  @override
  String get licenses => 'Licenze open source';

  @override
  String get aboutBody =>
      'Un classico Solitario Klondike. Niente gioco d\'azzardo, niente premi in denaro.';

  @override
  String get consentTitle => 'La tua privacy';

  @override
  String get consentBody =>
      'Solitaire Nova funziona completamente offline. Con il tuo permesso mostriamo annunci che mantengono il gioco gratuito e raccogliamo statistiche d\'uso anonime per migliorarlo. Puoi cambiare idea in qualsiasi momento nelle Impostazioni.';

  @override
  String get consentAccept => 'Accetta';

  @override
  String get consentEssential => 'Solo essenziali';

  @override
  String get offlineTitle => 'Sei offline';

  @override
  String get offlineBody =>
      'Questa funzione richiede una connessione a Internet. Il gioco funziona anche offline.';

  @override
  String get adUnavailableTitle => 'Nessun annuncio disponibile';

  @override
  String get adUnavailableBody =>
      'Al momento non ci sono annunci da mostrare. Riprova più tardi.';

  @override
  String get adNotCompleted =>
      'L\'annuncio è stato chiuso prima di ottenere la ricompensa.';

  @override
  String get cloudConflictTitle => 'Trovate due partite salvate';

  @override
  String get cloudConflictBody =>
      'Sia questo dispositivo sia il backup nel cloud hanno una partita in corso. Quale vuoi tenere?';

  @override
  String get keepThisDevice => 'Questo dispositivo';

  @override
  String get keepCloud => 'Il cloud';

  @override
  String get errorTitle => 'Si è verificato un problema';

  @override
  String get errorBody => 'I tuoi progressi sono al sicuro. Riprova.';

  @override
  String get achTitle_first_win => 'Prima vittoria';

  @override
  String get achTitle_wins_10 => 'Stella nascente';

  @override
  String get achTitle_wins_50 => 'Asso delle carte';

  @override
  String get achTitle_wins_100 => 'Maestro del Solitario';

  @override
  String get achTitle_wins_250 => 'Gran maestro';

  @override
  String get achTitle_wins_500 => 'Leggenda vivente';

  @override
  String get achTitle_played_10 => 'Primi passi';

  @override
  String get achTitle_played_100 => 'Habitué';

  @override
  String get achTitle_played_500 => 'Appassionato';

  @override
  String get achTitle_streak_3 => 'Tripletta';

  @override
  String get achTitle_streak_5 => 'In forma';

  @override
  String get achTitle_streak_10 => 'Inarrestabile';

  @override
  String get achTitle_draw3_first => 'Tripla minaccia';

  @override
  String get achTitle_draw3_25 => 'Veterano di Pesca 3';

  @override
  String get achTitle_no_hints => 'Autonomo';

  @override
  String get achTitle_no_undo => 'Nessun rimpianto';

  @override
  String get achTitle_purist_10 => 'Purista';

  @override
  String get achTitle_speed_5 => 'Mani svelte';

  @override
  String get achTitle_speed_3 => 'Veloce';

  @override
  String get achTitle_speed_2 => 'Fulmine';

  @override
  String get achTitle_moves_120 => 'Efficiente';

  @override
  String get achTitle_moves_100 => 'Parsimonioso';

  @override
  String get achTitle_score_4000 => 'Punteggio alto';

  @override
  String get achTitle_score_6000 => 'Leggenda del punteggio';

  @override
  String get achTitle_combo_5 => 'Inizio combo';

  @override
  String get achTitle_combo_10 => 'Esperto di combo';

  @override
  String get achTitle_daily_first => 'Debutto quotidiano';

  @override
  String get achTitle_daily_total_10 => 'Habitué della sfida';

  @override
  String get achTitle_daily_total_30 => 'Fedelissimo';

  @override
  String get achTitle_daily_streak_7 => 'Giocatore quotidiano';

  @override
  String get achTitle_winning_10 => 'Finalizzatore';

  @override
  String get achTitle_auto_finish => 'Finale morbido';

  @override
  String get achTitle_marathon => 'Maratona';

  @override
  String get achTitle_collector_5 => 'Collezionista';

  @override
  String get achTitle_stylist => 'Stilista';

  @override
  String get achTitle_level_10 => 'Esperto';

  @override
  String achDescWins(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vinci $count partite',
      one: 'Vinci la tua prima partita',
    );
    return '$_temp0';
  }

  @override
  String achDescPlayed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Gioca $count partite',
      one: 'Gioca 1 partita',
    );
    return '$_temp0';
  }

  @override
  String achDescStreak(int count) {
    return 'Vinci $count partite di fila';
  }

  @override
  String achDescDraw3(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vinci $count partite a Pesca 3',
      one: 'Vinci una partita a Pesca 3',
    );
    return '$_temp0';
  }

  @override
  String get achDescNoHints => 'Vinci una partita senza suggerimenti';

  @override
  String get achDescNoUndo => 'Vinci una partita senza annullare';

  @override
  String achDescPurist(int count) {
    return 'Vinci $count partite senza suggerimenti né annullamenti';
  }

  @override
  String achDescSpeed(int minutes) {
    return 'Vinci una partita in meno di $minutes minuti';
  }

  @override
  String achDescMoves(int count) {
    return 'Vinci una partita in $count mosse o meno';
  }

  @override
  String achDescScore(int score) {
    return 'Ottieni $score punti in una partita';
  }

  @override
  String achDescCombo(int count) {
    return 'Raggiungi una combo x$count';
  }

  @override
  String achDescDailyTotal(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Completa $count sfide del giorno',
      one: 'Completa una sfida del giorno',
    );
    return '$_temp0';
  }

  @override
  String achDescDailyStreak(int count) {
    return 'Completa la sfida del giorno per $count giorni di fila';
  }

  @override
  String achDescWinning(int count) {
    return 'Vinci $count smazzate vincibili';
  }

  @override
  String get achDescAutoFinish => 'Completa una partita con Auto';

  @override
  String achDescMarathon(int hours) {
    return 'Gioca $hours ore in totale';
  }

  @override
  String achDescCollector(int count) {
    return 'Compra $count oggetti cosmetici';
  }

  @override
  String get achDescStylist => 'Applica un nuovo tema';

  @override
  String achDescLevel(int level) {
    return 'Raggiungi il livello $level';
  }
}
