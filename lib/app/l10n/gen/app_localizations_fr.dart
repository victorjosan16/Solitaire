// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Solitaire Nova';

  @override
  String splashLoading(int percent) {
    return 'Chargement… $percent %';
  }

  @override
  String get navHome => 'Accueil';

  @override
  String get navStats => 'Stats';

  @override
  String get navShop => 'Boutique';

  @override
  String get navProfile => 'Profil';

  @override
  String get gameModeSetting => 'Mode de jeu';

  @override
  String get navSettings => 'Réglages';

  @override
  String get back => 'Retour';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Annuler';

  @override
  String get confirm => 'Confirmer';

  @override
  String get close => 'Fermer';

  @override
  String levelLabel(int level) {
    return 'Niveau $level';
  }

  @override
  String coinsBalance(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins pièces',
      one: '1 pièce',
      zero: '0 pièce',
    );
    return '$_temp0';
  }

  @override
  String get continueGame => 'Continuer';

  @override
  String continueSubtitle(String mode, int moves, String time) {
    return '$mode · $moves coups · $time';
  }

  @override
  String get playClassic => 'Partie classique';

  @override
  String get drawOne => 'Tirer 1';

  @override
  String get drawThree => 'Tirer 3';

  @override
  String get dealRandom => 'Donne aléatoire';

  @override
  String get dealWinning => 'Donne gagnable';

  @override
  String get dealWinningInfo =>
      'Les donnes gagnables ont été vérifiées comme résolubles par notre solveur. Une donne aléatoire peut n\'avoir aucune solution.';

  @override
  String get dailyChallenge => 'Défi du jour';

  @override
  String get achievements => 'Succès';

  @override
  String get themes => 'Thèmes';

  @override
  String get statistics => 'Statistiques';

  @override
  String get shop => 'Boutique';

  @override
  String get settings => 'Réglages';

  @override
  String get modeRandom => 'Aléatoire';

  @override
  String get modeWinning => 'Gagnable';

  @override
  String get modeDaily => 'Défi du jour';

  @override
  String get hudScore => 'Score';

  @override
  String get hudTime => 'Temps';

  @override
  String get hudMoves => 'Coups';

  @override
  String get actionUndo => 'Annuler';

  @override
  String get actionHint => 'Indice';

  @override
  String get actionAuto => 'Auto';

  @override
  String get actionNew => 'Nouvelle';

  @override
  String get actionPause => 'Pause';

  @override
  String hintsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count indices restants',
      one: '1 indice restant',
      zero: 'Plus d\'indice',
    );
    return '$_temp0';
  }

  @override
  String semStock(int count) {
    return 'Talon, $count cartes. Touchez pour piocher.';
  }

  @override
  String get semStockRecycle =>
      'Talon vide. Touchez pour retourner la défausse.';

  @override
  String get semStockEmpty => 'Talon vide';

  @override
  String get semWaste => 'Défausse';

  @override
  String semFoundation(String suit, int count) {
    return 'Fondation $suit, $count cartes';
  }

  @override
  String semEmptyColumn(int column) {
    return 'Colonne vide $column';
  }

  @override
  String semCard(String rank, String suit) {
    return '$rank de $suit';
  }

  @override
  String get semFaceDown => 'Carte face cachée';

  @override
  String get suitClubs => 'trèfle';

  @override
  String get suitDiamonds => 'carreau';

  @override
  String get suitHearts => 'cœur';

  @override
  String get suitSpades => 'pique';

  @override
  String get rankAce => 'As';

  @override
  String get rankJack => 'Valet';

  @override
  String get rankQueen => 'Dame';

  @override
  String get rankKing => 'Roi';

  @override
  String get noMovesTitle => 'Aucun coup utile';

  @override
  String get noMovesBody =>
      'Il n\'y a aucun coup productif pour le moment. Vous pouvez annuler, recommencer cette donne ou lancer une nouvelle partie.';

  @override
  String get noHintsTitle => 'Plus d\'indices';

  @override
  String get noHintsBody =>
      'Obtenez d\'autres indices avec des pièces ou en regardant une courte publicité facultative.';

  @override
  String buyHints(int count, int price) {
    return 'Acheter $count pour $price';
  }

  @override
  String watchAdHints(int count) {
    return 'Pub pour $count';
  }

  @override
  String get hintsDisabled => 'Les indices sont désactivés dans les réglages.';

  @override
  String get actionShuffle => 'Mélanger';

  @override
  String get shuffleTitle => 'Mélanger les cartes ?';

  @override
  String shuffleBody(int left) {
    return 'Toutes les cartes, sauf celles des fondations, seront mélangées et redistribuées. Cette action est irréversible. Mélanges restants dans cette partie : $left.';
  }

  @override
  String shufflePay(int price) {
    return 'Payer $price pièces';
  }

  @override
  String get shuffleWatchAd => 'Regarder une pub';

  @override
  String get shuffleLimit => 'Plus aucun mélange disponible dans cette partie.';

  @override
  String get autoFinishing => 'Fin en cours…';

  @override
  String get skip => 'Passer';

  @override
  String get pauseTitle => 'Pause';

  @override
  String get resume => 'Reprendre';

  @override
  String get restartDeal => 'Recommencer la donne';

  @override
  String get newGame => 'Nouvelle partie';

  @override
  String get home => 'Accueil';

  @override
  String get restartTitle => 'Recommencer cette donne ?';

  @override
  String get restartBody =>
      'Votre progression dans cette partie sera perdue. Vous rejouerez la même donne depuis le début.';

  @override
  String get newGameTitle => 'Lancer une nouvelle partie ?';

  @override
  String get newGameBody => 'La partie en cours sera comptée comme perdue.';

  @override
  String get victoryTitle => 'Victoire !';

  @override
  String get finalScore => 'Score final';

  @override
  String get timeLabel => 'Temps';

  @override
  String get movesLabel => 'Coups';

  @override
  String get maxCombo => 'Combo max';

  @override
  String get speedBonus => 'Bonus de rapidité';

  @override
  String get timeBonus => 'Bonus de temps';

  @override
  String get bestScore => 'Meilleur score';

  @override
  String get newRecord => 'Nouveau record !';

  @override
  String coinsEarned(int coins) {
    return '+$coins';
  }

  @override
  String get doubleCoins => 'Doubler les pièces · pub';

  @override
  String get coinsDoubled => 'Pièces doublées !';

  @override
  String get playAgain => 'Nouvelle partie';

  @override
  String get mainMenu => 'Menu principal';

  @override
  String achievementUnlocked(String name) {
    return 'Succès débloqué : $name';
  }

  @override
  String get dailyTitle => 'Défi du jour';

  @override
  String get todaysChallenge => 'Défi d\'aujourd\'hui';

  @override
  String get dailyInfo => 'Donne gagnable · Tirer 1';

  @override
  String dailyReward(int coins) {
    return 'Récompense : $coins';
  }

  @override
  String get play => 'Jouer';

  @override
  String playDay(String date) {
    return 'Jouer le $date';
  }

  @override
  String get dailyCompleted => 'Terminé';

  @override
  String get dailyRewardClaimed => 'Récompense obtenue';

  @override
  String get dailyPastNoReward =>
      'Les jours passés donnent une coche, pas de pièces.';

  @override
  String dailyStreak(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Série de $days jours',
      one: 'Série de 1 jour',
      zero: 'Aucune série en cours',
    );
    return '$_temp0';
  }

  @override
  String get dailyCalendarNote =>
      'Les défis suivent la date du calendrier de votre appareil.';

  @override
  String get dailyFuture => 'Pas encore disponible';

  @override
  String dailyCompletedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count terminés',
      one: '1 terminé',
      zero: 'Aucun terminé',
    );
    return '$_temp0';
  }

  @override
  String get previousMonth => 'Mois précédent';

  @override
  String get nextMonth => 'Mois suivant';

  @override
  String get themesBackgrounds => 'Fonds';

  @override
  String get themesCards => 'Cartes';

  @override
  String get themesTables => 'Tables';

  @override
  String get apply => 'Appliquer';

  @override
  String get applied => 'Appliqué';

  @override
  String get locked => 'Verrouillé';

  @override
  String get restoreDefaults => 'Rétablir par défaut';

  @override
  String get getInShop => 'Obtenir en boutique';

  @override
  String get themesContrastNote =>
      'L\'aperçu montre la lisibilité des cartes sur cette table.';

  @override
  String get cosmetic_cards_classic => 'Classique';

  @override
  String get cosmetic_cards_elegant => 'Élégant';

  @override
  String get cosmetic_cards_vintage => 'Vintage';

  @override
  String get cosmetic_cards_modern => 'Moderne';

  @override
  String get cosmetic_cards_neon => 'Néon';

  @override
  String get cosmetic_cards_gold => 'Doré';

  @override
  String get cosmetic_bg_lake => 'Lac de montagne';

  @override
  String get cosmetic_bg_autumn => 'Sentier d\'automne';

  @override
  String get cosmetic_bg_tropic => 'Baie tropicale';

  @override
  String get cosmetic_bg_alpine => 'Sommets alpins';

  @override
  String get cosmetic_bg_aurora => 'Aurore boréale';

  @override
  String get cosmetic_bg_lavender => 'Crépuscule lavande';

  @override
  String get cosmetic_table_emerald => 'Feutre émeraude';

  @override
  String get cosmetic_table_navy => 'Bleu nuit';

  @override
  String get cosmetic_table_burgundy => 'Bordeaux royal';

  @override
  String get cosmetic_table_walnut => 'Noyer';

  @override
  String get cosmetic_table_slate => 'Ardoise';

  @override
  String get cosmetic_table_contrast => 'Contraste élevé';

  @override
  String get statsTotal => 'Total';

  @override
  String get statsPlayed => 'Parties jouées';

  @override
  String get statsWins => 'Victoires';

  @override
  String get statsWinRate => 'Taux de victoire';

  @override
  String get statsTotalTime => 'Temps total';

  @override
  String get statsBestScore => 'Meilleur score';

  @override
  String get statsFastest => 'Victoire la plus rapide';

  @override
  String get statsCurrentStreak => 'Série actuelle';

  @override
  String get statsBestStreak => 'Meilleure série';

  @override
  String get statsMaxCombo => 'Combo max';

  @override
  String get statsFewestMoves => 'Moins de coups';

  @override
  String get statsDailyDone => 'Défis du jour';

  @override
  String get statsEmpty =>
      'Jouez votre première partie pour voir vos statistiques ici.';

  @override
  String get statsLocalLabel => 'Enregistré sur cet appareil';

  @override
  String durationHm(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String achievementsProgress(int done, int total) {
    return '$done sur $total débloqués';
  }

  @override
  String earnedOn(String date) {
    return 'Obtenu le $date';
  }

  @override
  String rewardCoins(int coins) {
    return '+$coins';
  }

  @override
  String get shopTitle => 'Boutique';

  @override
  String get shopCardPacks => 'Jeux de cartes';

  @override
  String get shopBackgrounds => 'Fonds';

  @override
  String get shopTables => 'Tables';

  @override
  String get shopHints => 'Indices';

  @override
  String watchAdCoins(int coins) {
    return 'Regarder une pub : +$coins pièces';
  }

  @override
  String get buy => 'Acheter';

  @override
  String get owned => 'Possédé';

  @override
  String get equip => 'Utiliser';

  @override
  String get equipped => 'Utilisé';

  @override
  String purchaseTitle(String item) {
    return 'Acheter $item ?';
  }

  @override
  String purchaseBody(int price, int after) {
    return 'Coût : $price pièces. Solde après l\'achat : $after.';
  }

  @override
  String get insufficientTitle => 'Pas assez de pièces';

  @override
  String insufficientBody(int missing) {
    return 'Il vous manque $missing pièces. Gagnez des parties, réussissez les défis du jour et débloquez des succès pour en obtenir davantage.';
  }

  @override
  String purchaseDone(String item) {
    return '$item débloqué !';
  }

  @override
  String get hintPackTitle => 'Pack d\'indices';

  @override
  String hintPackBody(int count, int price) {
    return '$count indices pour $price pièces';
  }

  @override
  String hintsOwned(int count) {
    return 'Vous avez $count indices';
  }

  @override
  String get coinsDisclaimer =>
      'Les pièces sont une monnaie de jeu sans valeur monétaire. Elles ne peuvent être ni achetées, ni vendues, ni retirées, ni échangées.';

  @override
  String get settingsGameplay => 'Jeu';

  @override
  String get settingsAudio => 'Son et vibrations';

  @override
  String get settingsDisplay => 'Affichage';

  @override
  String get settingsPrivacy => 'Confidentialité';

  @override
  String get settingsData => 'Données et compte';

  @override
  String get settingsAbout => 'À propos';

  @override
  String get music => 'Musique';

  @override
  String get sound => 'Effets sonores';

  @override
  String get haptics => 'Vibrations';

  @override
  String get reducedMotion => 'Réduire les animations';

  @override
  String get leftHanded => 'Mode gaucher';

  @override
  String get defaultDraw => 'Mode de pioche par défaut';

  @override
  String get tapToFoundation => 'Toucher envoie d\'abord vers les fondations';

  @override
  String get hintsSetting => 'Indices';

  @override
  String get showTimer => 'Afficher le chronomètre';

  @override
  String get unlimitedPasses => 'Passages illimités du talon';

  @override
  String get limitedPassesNote =>
      'Désactivé : Tirer 1 permet 2 retournements, Tirer 3 en permet 3.';

  @override
  String get foundationMoves => 'Autoriser les coups depuis les fondations';

  @override
  String get rulesNextGame =>
      'Les changements de règles s\'appliquent à la prochaine partie.';

  @override
  String get language => 'Langue';

  @override
  String get languageSystem => 'Langue du système';

  @override
  String get cloudBackup => 'Sauvegarde cloud';

  @override
  String get cloudBackupUnavailable =>
      'La sauvegarde cloud n\'est pas configurée dans cette version. Votre progression est enregistrée sur cet appareil.';

  @override
  String get signIn => 'Se connecter';

  @override
  String get privacyChoices => 'Confidentialité et publicités';

  @override
  String get analyticsSetting =>
      'Partager des statistiques d\'utilisation anonymes';

  @override
  String get personalizedAds => 'Publicités personnalisées';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get privacyPolicyBody =>
      'Solitaire Nova conserve vos parties, statistiques et achats uniquement sur cet appareil. Aucun compte n\'est nécessaire. Si vous l\'autorisez, des statistiques d\'utilisation anonymes et des publicités (via Google AdMob) peuvent être utilisées ; les partenaires publicitaires peuvent traiter des identifiants de l\'appareil selon vos choix de consentement. Vous pouvez retirer votre consentement à tout moment dans les réglages.';

  @override
  String get deleteData => 'Supprimer les données locales';

  @override
  String get deleteDataTitle => 'Supprimer toutes les données locales ?';

  @override
  String get deleteDataBody =>
      'Cela supprime définitivement votre partie enregistrée, vos statistiques, succès, pièces et objets sur cet appareil. Cette action est irréversible.';

  @override
  String get deleteDataDone => 'Données locales supprimées';

  @override
  String get delete => 'Supprimer';

  @override
  String get restorePurchases => 'Restaurer les achats';

  @override
  String get restoreNone =>
      'Aucun achat en magasin à restaurer. Les objets achetés avec des pièces restent sur cet appareil.';

  @override
  String get howToPlay => 'Comment jouer';

  @override
  String get rulesTableau =>
      'Construisez les sept colonnes en ordre décroissant, en alternant les couleurs (rouge sur noir, noir sur rouge). Seul un Roi peut occuper une colonne vide.';

  @override
  String get rulesFoundation =>
      'Placez toutes les cartes sur les quatre fondations, par couleur, de l\'As au Roi.';

  @override
  String get rulesStock =>
      'Touchez le talon pour retourner 1 ou 3 cartes. Quand il est vide, touchez-le de nouveau pour retourner la défausse.';

  @override
  String get rulesControls =>
      'Touchez une carte pour la déplacer automatiquement, ou faites-la glisser. Annulez n\'importe quel coup, demandez un indice ou laissez Auto terminer la partie quand toutes les cartes sont révélées.';

  @override
  String get rulesCombo =>
      'Les combos comptent les coups utiles consécutifs. Ils sont juste pour le plaisir et ne changent jamais les règles.';

  @override
  String get about => 'À propos';

  @override
  String version(String version) {
    return 'Version $version';
  }

  @override
  String get licenses => 'Licences open source';

  @override
  String get aboutBody =>
      'Un Solitaire Klondike classique. Pas de jeu d\'argent, pas de gains en argent.';

  @override
  String get consentTitle => 'Votre vie privée';

  @override
  String get consentBody =>
      'Solitaire Nova fonctionne entièrement hors ligne. Avec votre accord, nous affichons des publicités qui gardent le jeu gratuit et recueillons des statistiques d\'utilisation anonymes pour l\'améliorer. Vous pouvez modifier ce choix à tout moment dans les réglages.';

  @override
  String get consentAccept => 'Accepter';

  @override
  String get consentEssential => 'Essentiel uniquement';

  @override
  String get offlineTitle => 'Vous êtes hors ligne';

  @override
  String get offlineBody =>
      'Cette fonctionnalité nécessite une connexion Internet. Le jeu lui-même fonctionne hors ligne.';

  @override
  String get adUnavailableTitle => 'Aucune publicité disponible';

  @override
  String get adUnavailableBody =>
      'Aucune publicité n\'est disponible pour le moment. Réessayez plus tard.';

  @override
  String get adNotCompleted =>
      'La publicité a été fermée avant l\'obtention de la récompense.';

  @override
  String get cloudConflictTitle => 'Deux parties enregistrées trouvées';

  @override
  String get cloudConflictBody =>
      'Cet appareil et votre sauvegarde cloud ont chacun une partie en cours. Laquelle voulez-vous garder ?';

  @override
  String get keepThisDevice => 'Cet appareil';

  @override
  String get keepCloud => 'Le cloud';

  @override
  String get errorTitle => 'Un problème est survenu';

  @override
  String get errorBody =>
      'Votre progression est en sécurité. Veuillez réessayer.';

  @override
  String get achTitle_first_win => 'Première victoire';

  @override
  String get achTitle_wins_10 => 'Étoile montante';

  @override
  String get achTitle_wins_50 => 'As des cartes';

  @override
  String get achTitle_wins_100 => 'Maître du Solitaire';

  @override
  String get achTitle_wins_250 => 'Grand maître';

  @override
  String get achTitle_wins_500 => 'Légende vivante';

  @override
  String get achTitle_played_10 => 'Premiers pas';

  @override
  String get achTitle_played_100 => 'Habitué';

  @override
  String get achTitle_played_500 => 'Passionné';

  @override
  String get achTitle_streak_3 => 'Coup du chapeau';

  @override
  String get achTitle_streak_5 => 'En feu';

  @override
  String get achTitle_streak_10 => 'Inarrêtable';

  @override
  String get achTitle_draw3_first => 'Triple menace';

  @override
  String get achTitle_draw3_25 => 'Vétéran du Tirer 3';

  @override
  String get achTitle_no_hints => 'Autonome';

  @override
  String get achTitle_no_undo => 'Sans regret';

  @override
  String get achTitle_purist_10 => 'Puriste';

  @override
  String get achTitle_speed_5 => 'Mains agiles';

  @override
  String get achTitle_speed_3 => 'Rapide';

  @override
  String get achTitle_speed_2 => 'Éclair';

  @override
  String get achTitle_moves_120 => 'Efficace';

  @override
  String get achTitle_moves_100 => 'Économe';

  @override
  String get achTitle_score_4000 => 'Gros score';

  @override
  String get achTitle_score_6000 => 'Légende du score';

  @override
  String get achTitle_combo_5 => 'Début de combo';

  @override
  String get achTitle_combo_10 => 'Expert en combos';

  @override
  String get achTitle_daily_first => 'Premier défi';

  @override
  String get achTitle_daily_total_10 => 'Habitué du défi';

  @override
  String get achTitle_daily_total_30 => 'Fidèle au défi';

  @override
  String get achTitle_daily_streak_7 => 'Joueur quotidien';

  @override
  String get achTitle_winning_10 => 'Finisseur';

  @override
  String get achTitle_auto_finish => 'Fin en douceur';

  @override
  String get achTitle_marathon => 'Marathon';

  @override
  String get achTitle_collector_5 => 'Collectionneur';

  @override
  String get achTitle_stylist => 'Styliste';

  @override
  String get achTitle_level_10 => 'Aguerri';

  @override
  String achDescWins(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Gagnez $count parties',
      one: 'Gagnez votre première partie',
    );
    return '$_temp0';
  }

  @override
  String achDescPlayed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Jouez $count parties',
      one: 'Jouez 1 partie',
    );
    return '$_temp0';
  }

  @override
  String achDescStreak(int count) {
    return 'Gagnez $count parties d\'affilée';
  }

  @override
  String achDescDraw3(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Gagnez $count parties en Tirer 3',
      one: 'Gagnez une partie en Tirer 3',
    );
    return '$_temp0';
  }

  @override
  String get achDescNoHints => 'Gagnez une partie sans indice';

  @override
  String get achDescNoUndo => 'Gagnez une partie sans annuler';

  @override
  String achDescPurist(int count) {
    return 'Gagnez $count parties sans indice ni annulation';
  }

  @override
  String achDescSpeed(int minutes) {
    return 'Gagnez une partie en moins de $minutes minutes';
  }

  @override
  String achDescMoves(int count) {
    return 'Gagnez une partie en $count coups ou moins';
  }

  @override
  String achDescScore(int score) {
    return 'Marquez $score points en une partie';
  }

  @override
  String achDescCombo(int count) {
    return 'Atteignez un combo x$count';
  }

  @override
  String achDescDailyTotal(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Réussissez $count défis du jour',
      one: 'Réussissez un défi du jour',
    );
    return '$_temp0';
  }

  @override
  String achDescDailyStreak(int count) {
    return 'Réussissez le défi du jour $count jours d\'affilée';
  }

  @override
  String achDescWinning(int count) {
    return 'Gagnez $count donnes gagnables';
  }

  @override
  String get achDescAutoFinish => 'Terminez une partie avec Auto';

  @override
  String achDescMarathon(int hours) {
    return 'Jouez $hours heures au total';
  }

  @override
  String achDescCollector(int count) {
    return 'Achetez $count objets cosmétiques';
  }

  @override
  String get achDescStylist => 'Appliquez un nouveau thème';

  @override
  String achDescLevel(int level) {
    return 'Atteignez le niveau $level';
  }
}
