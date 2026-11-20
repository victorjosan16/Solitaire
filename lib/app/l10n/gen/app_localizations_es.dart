// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Solitaire Nova';

  @override
  String splashLoading(int percent) {
    return 'Cargando… $percent %';
  }

  @override
  String get navHome => 'Inicio';

  @override
  String get navStats => 'Estadísticas';

  @override
  String get navShop => 'Tienda';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get back => 'Atrás';

  @override
  String get ok => 'Aceptar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get close => 'Cerrar';

  @override
  String levelLabel(int level) {
    return 'Nivel $level';
  }

  @override
  String coinsBalance(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins monedas',
      one: '1 moneda',
    );
    return '$_temp0';
  }

  @override
  String get continueGame => 'Continuar';

  @override
  String continueSubtitle(String mode, int moves, String time) {
    return '$mode · $moves movimientos · $time';
  }

  @override
  String get playClassic => 'Partida clásica';

  @override
  String get drawOne => 'Robar 1';

  @override
  String get drawThree => 'Robar 3';

  @override
  String get dealRandom => 'Reparto aleatorio';

  @override
  String get dealWinning => 'Reparto ganable';

  @override
  String get dealWinningInfo =>
      'Los repartos ganables han sido verificados como resolubles por nuestro solucionador. Un reparto aleatorio puede no tener solución.';

  @override
  String get dailyChallenge => 'Desafío diario';

  @override
  String get achievements => 'Logros';

  @override
  String get themes => 'Temas';

  @override
  String get statistics => 'Estadísticas';

  @override
  String get shop => 'Tienda';

  @override
  String get settings => 'Ajustes';

  @override
  String get modeRandom => 'Aleatorio';

  @override
  String get modeWinning => 'Ganable';

  @override
  String get modeDaily => 'Diario';

  @override
  String get hudScore => 'Puntos';

  @override
  String get hudTime => 'Tiempo';

  @override
  String get hudMoves => 'Movs.';

  @override
  String get actionUndo => 'Deshacer';

  @override
  String get actionHint => 'Pista';

  @override
  String get actionAuto => 'Auto';

  @override
  String get actionNew => 'Nueva';

  @override
  String get actionPause => 'Pausa';

  @override
  String hintsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Quedan $count pistas',
      one: 'Queda 1 pista',
      zero: 'No quedan pistas',
    );
    return '$_temp0';
  }

  @override
  String semStock(int count) {
    return 'Mazo, $count cartas. Toca para robar.';
  }

  @override
  String get semStockRecycle =>
      'Mazo vacío. Toca para dar la vuelta al descarte.';

  @override
  String get semStockEmpty => 'Mazo vacío';

  @override
  String get semWaste => 'Descarte';

  @override
  String semFoundation(String suit, int count) {
    return 'Fundación de $suit, $count cartas';
  }

  @override
  String semEmptyColumn(int column) {
    return 'Columna vacía $column';
  }

  @override
  String semCard(String rank, String suit) {
    return '$rank de $suit';
  }

  @override
  String get semFaceDown => 'Carta boca abajo';

  @override
  String get suitClubs => 'tréboles';

  @override
  String get suitDiamonds => 'diamantes';

  @override
  String get suitHearts => 'corazones';

  @override
  String get suitSpades => 'picas';

  @override
  String get rankAce => 'As';

  @override
  String get rankJack => 'Jota';

  @override
  String get rankQueen => 'Reina';

  @override
  String get rankKing => 'Rey';

  @override
  String get noMovesTitle => 'No hay movimientos útiles';

  @override
  String get noMovesBody =>
      'Ahora mismo no hay movimientos productivos. Puedes deshacer, reiniciar este reparto o empezar una partida nueva.';

  @override
  String get noHintsTitle => 'Sin pistas';

  @override
  String get noHintsBody =>
      'Consigue más pistas con monedas o viendo un anuncio breve y opcional.';

  @override
  String buyHints(int count, int price) {
    return 'Comprar $count por $price';
  }

  @override
  String watchAdHints(int count) {
    return 'Anuncio por $count';
  }

  @override
  String get hintsDisabled => 'Las pistas están desactivadas en Ajustes.';

  @override
  String get autoFinishing => 'Terminando…';

  @override
  String get skip => 'Saltar';

  @override
  String get pauseTitle => 'En pausa';

  @override
  String get resume => 'Reanudar';

  @override
  String get restartDeal => 'Reiniciar reparto';

  @override
  String get newGame => 'Nueva partida';

  @override
  String get home => 'Inicio';

  @override
  String get restartTitle => '¿Reiniciar este reparto?';

  @override
  String get restartBody =>
      'Perderás el progreso de esta partida. Jugarás el mismo reparto desde el principio.';

  @override
  String get newGameTitle => '¿Empezar una partida nueva?';

  @override
  String get newGameBody => 'La partida actual contará como derrota.';

  @override
  String get victoryTitle => '¡Victoria!';

  @override
  String get finalScore => 'Puntuación final';

  @override
  String get timeLabel => 'Tiempo';

  @override
  String get movesLabel => 'Movimientos';

  @override
  String get maxCombo => 'Combo máx.';

  @override
  String get timeBonus => 'Bonus de tiempo';

  @override
  String get bestScore => 'Mejor puntuación';

  @override
  String get newRecord => '¡Nuevo récord!';

  @override
  String coinsEarned(int coins) {
    return '+$coins';
  }

  @override
  String get doubleCoins => 'Duplicar monedas · anuncio';

  @override
  String get coinsDoubled => '¡Monedas duplicadas!';

  @override
  String get playAgain => 'Nueva partida';

  @override
  String get mainMenu => 'Menú principal';

  @override
  String achievementUnlocked(String name) {
    return 'Logro desbloqueado: $name';
  }

  @override
  String get dailyTitle => 'Desafío diario';

  @override
  String get todaysChallenge => 'Desafío de hoy';

  @override
  String get dailyInfo => 'Reparto ganable · Robar 1';

  @override
  String dailyReward(int coins) {
    return 'Recompensa: $coins';
  }

  @override
  String get play => 'Jugar';

  @override
  String playDay(String date) {
    return 'Jugar $date';
  }

  @override
  String get dailyCompleted => 'Completado';

  @override
  String get dailyRewardClaimed => 'Recompensa recibida';

  @override
  String get dailyPastNoReward => 'Los días pasados dan una marca, no monedas.';

  @override
  String dailyStreak(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Racha de $days días',
      one: 'Racha de 1 día',
      zero: 'Sin racha actual',
    );
    return '$_temp0';
  }

  @override
  String get dailyCalendarNote =>
      'Los desafíos siguen la fecha del calendario de tu dispositivo.';

  @override
  String get dailyFuture => 'Aún no disponible';

  @override
  String dailyCompletedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count completados',
      one: '1 completado',
    );
    return '$_temp0';
  }

  @override
  String get previousMonth => 'Mes anterior';

  @override
  String get nextMonth => 'Mes siguiente';

  @override
  String get themesBackgrounds => 'Fondos';

  @override
  String get themesCards => 'Cartas';

  @override
  String get themesTables => 'Mesas';

  @override
  String get apply => 'Aplicar';

  @override
  String get applied => 'Aplicado';

  @override
  String get locked => 'Bloqueado';

  @override
  String get restoreDefaults => 'Restablecer predeterminados';

  @override
  String get getInShop => 'Conseguir en la tienda';

  @override
  String get themesContrastNote =>
      'La vista previa muestra la legibilidad de las cartas en esta mesa.';

  @override
  String get cosmetic_cards_classic => 'Clásico';

  @override
  String get cosmetic_cards_elegant => 'Elegante';

  @override
  String get cosmetic_cards_vintage => 'Vintage';

  @override
  String get cosmetic_cards_modern => 'Moderno';

  @override
  String get cosmetic_cards_neon => 'Neón';

  @override
  String get cosmetic_cards_gold => 'Dorado';

  @override
  String get cosmetic_bg_lake => 'Lago de montaña';

  @override
  String get cosmetic_bg_autumn => 'Sendero otoñal';

  @override
  String get cosmetic_bg_tropic => 'Bahía tropical';

  @override
  String get cosmetic_bg_alpine => 'Cumbres alpinas';

  @override
  String get cosmetic_bg_aurora => 'Aurora boreal';

  @override
  String get cosmetic_bg_lavender => 'Atardecer de lavanda';

  @override
  String get cosmetic_table_emerald => 'Tapete esmeralda';

  @override
  String get cosmetic_table_navy => 'Azul medianoche';

  @override
  String get cosmetic_table_burgundy => 'Burdeos real';

  @override
  String get cosmetic_table_walnut => 'Nogal';

  @override
  String get cosmetic_table_slate => 'Pizarra';

  @override
  String get cosmetic_table_contrast => 'Alto contraste';

  @override
  String get statsTotal => 'Total';

  @override
  String get statsPlayed => 'Partidas jugadas';

  @override
  String get statsWins => 'Victorias';

  @override
  String get statsWinRate => 'Porcentaje de victorias';

  @override
  String get statsTotalTime => 'Tiempo total';

  @override
  String get statsBestScore => 'Mejor puntuación';

  @override
  String get statsFastest => 'Victoria más rápida';

  @override
  String get statsCurrentStreak => 'Racha actual';

  @override
  String get statsBestStreak => 'Mejor racha';

  @override
  String get statsMaxCombo => 'Combo máx.';

  @override
  String get statsFewestMoves => 'Menos movimientos';

  @override
  String get statsDailyDone => 'Desafíos diarios';

  @override
  String get statsEmpty =>
      'Juega tu primera partida para ver aquí tus estadísticas.';

  @override
  String get statsLocalLabel => 'Guardado en este dispositivo';

  @override
  String durationHm(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String achievementsProgress(int done, int total) {
    return '$done de $total desbloqueados';
  }

  @override
  String earnedOn(String date) {
    return 'Conseguido el $date';
  }

  @override
  String rewardCoins(int coins) {
    return '+$coins';
  }

  @override
  String get shopTitle => 'Tienda';

  @override
  String get shopCardPacks => 'Barajas';

  @override
  String get shopBackgrounds => 'Fondos';

  @override
  String get shopTables => 'Mesas';

  @override
  String get shopHints => 'Pistas';

  @override
  String get buy => 'Comprar';

  @override
  String get owned => 'Adquirido';

  @override
  String get equip => 'Usar';

  @override
  String get equipped => 'En uso';

  @override
  String purchaseTitle(String item) {
    return '¿Comprar $item?';
  }

  @override
  String purchaseBody(int price, int after) {
    return 'Cuesta $price monedas. Saldo tras la compra: $after.';
  }

  @override
  String get insufficientTitle => 'Monedas insuficientes';

  @override
  String insufficientBody(int missing) {
    return 'Te faltan $missing monedas. Gana partidas, completa desafíos diarios y desbloquea logros para conseguir más.';
  }

  @override
  String purchaseDone(String item) {
    return '¡$item desbloqueado!';
  }

  @override
  String get hintPackTitle => 'Paquete de pistas';

  @override
  String hintPackBody(int count, int price) {
    return '$count pistas por $price monedas';
  }

  @override
  String hintsOwned(int count) {
    return 'Tienes $count pistas';
  }

  @override
  String get coinsDisclaimer =>
      'Las monedas son una divisa del juego sin valor monetario. No se pueden comprar, vender, retirar ni canjear.';

  @override
  String get settingsGameplay => 'Juego';

  @override
  String get settingsAudio => 'Sonido y vibración';

  @override
  String get settingsDisplay => 'Pantalla';

  @override
  String get settingsPrivacy => 'Privacidad';

  @override
  String get settingsData => 'Datos y cuenta';

  @override
  String get settingsAbout => 'Acerca de';

  @override
  String get music => 'Música';

  @override
  String get sound => 'Efectos de sonido';

  @override
  String get haptics => 'Vibración';

  @override
  String get reducedMotion => 'Reducir animaciones';

  @override
  String get leftHanded => 'Modo zurdo';

  @override
  String get defaultDraw => 'Modo de robo predeterminado';

  @override
  String get tapToFoundation => 'Tocar envía primero a las fundaciones';

  @override
  String get hintsSetting => 'Pistas';

  @override
  String get showTimer => 'Mostrar cronómetro';

  @override
  String get unlimitedPasses => 'Pasadas ilimitadas del mazo';

  @override
  String get limitedPassesNote =>
      'Desactivado: Robar 1 permite 2 vueltas y Robar 3 permite 3.';

  @override
  String get foundationMoves => 'Permitir mover desde las fundaciones';

  @override
  String get rulesNextGame =>
      'Los cambios de reglas se aplican desde la próxima partida.';

  @override
  String get language => 'Idioma';

  @override
  String get languageSystem => 'Predeterminado del sistema';

  @override
  String get cloudBackup => 'Copia en la nube';

  @override
  String get cloudBackupUnavailable =>
      'La copia en la nube no está configurada en esta versión. Tu progreso se guarda en este dispositivo.';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get privacyChoices => 'Privacidad y anuncios';

  @override
  String get analyticsSetting => 'Compartir estadísticas de uso anónimas';

  @override
  String get personalizedAds => 'Anuncios personalizados';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get privacyPolicyBody =>
      'Solitaire Nova guarda tus partidas, estadísticas y compras solo en este dispositivo. No necesitas una cuenta. Si lo permites, pueden usarse estadísticas de uso anónimas y anuncios (a través de Google AdMob); los socios publicitarios pueden tratar identificadores del dispositivo según tus opciones de consentimiento. Puedes retirar tu consentimiento en cualquier momento en Ajustes.';

  @override
  String get deleteData => 'Borrar datos locales';

  @override
  String get deleteDataTitle => '¿Borrar todos los datos locales?';

  @override
  String get deleteDataBody =>
      'Se eliminarán de forma permanente tu partida guardada, estadísticas, logros, monedas y objetos de este dispositivo. No se puede deshacer.';

  @override
  String get deleteDataDone => 'Datos locales borrados';

  @override
  String get delete => 'Borrar';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get restoreNone =>
      'No hay compras de la tienda que restaurar. Los objetos comprados con monedas permanecen en este dispositivo.';

  @override
  String get howToPlay => 'Cómo jugar';

  @override
  String get rulesTableau =>
      'Construye las siete columnas en orden descendente alternando colores (rojo sobre negro, negro sobre rojo). Solo un Rey puede ocupar una columna vacía.';

  @override
  String get rulesFoundation =>
      'Lleva todas las cartas a las cuatro fundaciones, por palo, del As al Rey.';

  @override
  String get rulesStock =>
      'Toca el mazo para descubrir 1 o 3 cartas. Cuando se vacíe, vuelve a tocarlo para dar la vuelta al descarte.';

  @override
  String get rulesControls =>
      'Toca una carta para moverla automáticamente o arrástrala. Deshaz cualquier movimiento, pide una pista o deja que Auto termine la partida cuando todas las cartas estén descubiertas.';

  @override
  String get rulesCombo =>
      'Los combos cuentan movimientos útiles seguidos. Son solo por diversión y nunca cambian las reglas.';

  @override
  String get about => 'Acerca de';

  @override
  String version(String version) {
    return 'Versión $version';
  }

  @override
  String get licenses => 'Licencias de código abierto';

  @override
  String get aboutBody =>
      'Un Solitario Klondike clásico. Sin apuestas ni premios en dinero.';

  @override
  String get consentTitle => 'Tu privacidad';

  @override
  String get consentBody =>
      'Solitaire Nova funciona totalmente sin conexión. Con tu permiso, mostramos anuncios que mantienen el juego gratis y recopilamos estadísticas de uso anónimas para mejorarlo. Puedes cambiarlo en cualquier momento en Ajustes.';

  @override
  String get consentAccept => 'Aceptar';

  @override
  String get consentEssential => 'Solo lo esencial';

  @override
  String get offlineTitle => 'Sin conexión';

  @override
  String get offlineBody =>
      'Esta función necesita conexión a Internet. El juego en sí funciona sin conexión.';

  @override
  String get adUnavailableTitle => 'No hay anuncios disponibles';

  @override
  String get adUnavailableBody =>
      'Ahora mismo no hay ningún anuncio. Inténtalo más tarde.';

  @override
  String get adNotCompleted =>
      'El anuncio se cerró antes de conseguir la recompensa.';

  @override
  String get cloudConflictTitle => 'Se encontraron dos partidas guardadas';

  @override
  String get cloudConflictBody =>
      'Este dispositivo y tu copia en la nube tienen una partida en curso. ¿Cuál quieres conservar?';

  @override
  String get keepThisDevice => 'Este dispositivo';

  @override
  String get keepCloud => 'La nube';

  @override
  String get errorTitle => 'Algo salió mal';

  @override
  String get errorBody => 'Tu progreso está a salvo. Inténtalo de nuevo.';

  @override
  String get achTitle_first_win => 'Primera victoria';

  @override
  String get achTitle_wins_10 => 'Estrella en ascenso';

  @override
  String get achTitle_wins_50 => 'As de las cartas';

  @override
  String get achTitle_wins_100 => 'Maestro del Solitario';

  @override
  String get achTitle_wins_250 => 'Gran maestro';

  @override
  String get achTitle_wins_500 => 'Leyenda viva';

  @override
  String get achTitle_played_10 => 'Primeros pasos';

  @override
  String get achTitle_played_100 => 'Habitual';

  @override
  String get achTitle_played_500 => 'Apasionado';

  @override
  String get achTitle_streak_3 => 'Triplete';

  @override
  String get achTitle_streak_5 => 'En racha';

  @override
  String get achTitle_streak_10 => 'Imparable';

  @override
  String get achTitle_draw3_first => 'Triple amenaza';

  @override
  String get achTitle_draw3_25 => 'Veterano de Robar 3';

  @override
  String get achTitle_no_hints => 'Autosuficiente';

  @override
  String get achTitle_no_undo => 'Sin arrepentimientos';

  @override
  String get achTitle_purist_10 => 'Purista';

  @override
  String get achTitle_speed_5 => 'Manos rápidas';

  @override
  String get achTitle_speed_3 => 'Veloz';

  @override
  String get achTitle_speed_2 => 'Relámpago';

  @override
  String get achTitle_moves_120 => 'Eficiente';

  @override
  String get achTitle_moves_100 => 'Ahorrador';

  @override
  String get achTitle_score_4000 => 'Gran puntuación';

  @override
  String get achTitle_score_6000 => 'Leyenda de la puntuación';

  @override
  String get achTitle_combo_5 => 'Inicio de combo';

  @override
  String get achTitle_combo_10 => 'Experto en combos';

  @override
  String get achTitle_daily_first => 'Debut diario';

  @override
  String get achTitle_daily_total_10 => 'Habitual diario';

  @override
  String get achTitle_daily_total_30 => 'Fiel diario';

  @override
  String get achTitle_daily_streak_7 => 'Jugador diario';

  @override
  String get achTitle_winning_10 => 'Rematador';

  @override
  String get achTitle_auto_finish => 'Final suave';

  @override
  String get achTitle_marathon => 'Maratón';

  @override
  String get achTitle_collector_5 => 'Coleccionista';

  @override
  String get achTitle_stylist => 'Estilista';

  @override
  String get achTitle_level_10 => 'Curtido';

  @override
  String achDescWins(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Gana $count partidas',
      one: 'Gana tu primera partida',
    );
    return '$_temp0';
  }

  @override
  String achDescPlayed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Juega $count partidas',
      one: 'Juega 1 partida',
    );
    return '$_temp0';
  }

  @override
  String achDescStreak(int count) {
    return 'Gana $count partidas seguidas';
  }

  @override
  String achDescDraw3(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Gana $count partidas de Robar 3',
      one: 'Gana una partida de Robar 3',
    );
    return '$_temp0';
  }

  @override
  String get achDescNoHints => 'Gana una partida sin pistas';

  @override
  String get achDescNoUndo => 'Gana una partida sin deshacer';

  @override
  String achDescPurist(int count) {
    return 'Gana $count partidas sin pistas ni deshacer';
  }

  @override
  String achDescSpeed(int minutes) {
    return 'Gana una partida en menos de $minutes minutos';
  }

  @override
  String achDescMoves(int count) {
    return 'Gana una partida en $count movimientos o menos';
  }

  @override
  String achDescScore(int score) {
    return 'Consigue $score puntos en una partida';
  }

  @override
  String achDescCombo(int count) {
    return 'Alcanza un combo x$count';
  }

  @override
  String achDescDailyTotal(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Completa $count desafíos diarios',
      one: 'Completa un desafío diario',
    );
    return '$_temp0';
  }

  @override
  String achDescDailyStreak(int count) {
    return 'Completa desafíos diarios $count días seguidos';
  }

  @override
  String achDescWinning(int count) {
    return 'Gana $count repartos ganables';
  }

  @override
  String get achDescAutoFinish => 'Termina una partida con Auto';

  @override
  String achDescMarathon(int hours) {
    return 'Juega $hours horas en total';
  }

  @override
  String achDescCollector(int count) {
    return 'Compra $count objetos cosméticos';
  }

  @override
  String get achDescStylist => 'Aplica un tema nuevo';

  @override
  String achDescLevel(int level) {
    return 'Alcanza el nivel $level';
  }
}
