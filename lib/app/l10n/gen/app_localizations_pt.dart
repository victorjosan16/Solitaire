// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Solitaire Nova';

  @override
  String splashLoading(int percent) {
    return 'Carregando… $percent%';
  }

  @override
  String get navHome => 'Início';

  @override
  String get navStats => 'Estatísticas';

  @override
  String get navShop => 'Loja';

  @override
  String get navProfile => 'Perfil';

  @override
  String get gameModeSetting => 'Modo de jogo';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get back => 'Voltar';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get close => 'Fechar';

  @override
  String levelLabel(int level) {
    return 'Nível $level';
  }

  @override
  String coinsBalance(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins moedas',
      one: '1 moeda',
    );
    return '$_temp0';
  }

  @override
  String get continueGame => 'Continuar';

  @override
  String continueSubtitle(String mode, int moves, String time) {
    return '$mode · $moves jogadas · $time';
  }

  @override
  String get playClassic => 'Jogo clássico';

  @override
  String get drawOne => 'Comprar 1';

  @override
  String get drawThree => 'Comprar 3';

  @override
  String get dealRandom => 'Distribuição aleatória';

  @override
  String get dealWinning => 'Distribuição vencível';

  @override
  String get dealWinningInfo =>
      'As distribuições vencíveis foram verificadas como solucionáveis pelo nosso solucionador. Uma distribuição aleatória pode não ter solução.';

  @override
  String get dailyChallenge => 'Desafio diário';

  @override
  String get achievements => 'Conquistas';

  @override
  String get themes => 'Temas';

  @override
  String get statistics => 'Estatísticas';

  @override
  String get shop => 'Loja';

  @override
  String get settings => 'Ajustes';

  @override
  String get modeRandom => 'Aleatória';

  @override
  String get modeWinning => 'Vencível';

  @override
  String get modeDaily => 'Diário';

  @override
  String get hudScore => 'Pontos';

  @override
  String get hudTime => 'Tempo';

  @override
  String get hudMoves => 'Jogadas';

  @override
  String get actionUndo => 'Desfazer';

  @override
  String get actionHint => 'Dica';

  @override
  String get actionAuto => 'Auto';

  @override
  String get actionNew => 'Novo';

  @override
  String get actionPause => 'Pausa';

  @override
  String hintsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dicas restantes',
      one: '1 dica restante',
      zero: 'Sem dicas restantes',
    );
    return '$_temp0';
  }

  @override
  String semStock(int count) {
    return 'Monte, $count cartas. Toque para comprar.';
  }

  @override
  String get semStockRecycle => 'Monte vazio. Toque para virar o descarte.';

  @override
  String get semStockEmpty => 'Monte vazio';

  @override
  String get semWaste => 'Descarte';

  @override
  String semFoundation(String suit, int count) {
    return 'Fundação de $suit, $count cartas';
  }

  @override
  String semEmptyColumn(int column) {
    return 'Coluna vazia $column';
  }

  @override
  String semCard(String rank, String suit) {
    return '$rank de $suit';
  }

  @override
  String get semFaceDown => 'Carta virada para baixo';

  @override
  String get suitClubs => 'paus';

  @override
  String get suitDiamonds => 'ouros';

  @override
  String get suitHearts => 'copas';

  @override
  String get suitSpades => 'espadas';

  @override
  String get rankAce => 'Ás';

  @override
  String get rankJack => 'Valete';

  @override
  String get rankQueen => 'Dama';

  @override
  String get rankKing => 'Rei';

  @override
  String get noMovesTitle => 'Nenhuma jogada útil';

  @override
  String get noMovesBody =>
      'No momento não há jogadas produtivas. Você pode desfazer, reiniciar esta distribuição ou começar um novo jogo.';

  @override
  String get noHintsTitle => 'Sem dicas';

  @override
  String get noHintsBody =>
      'Ganhe mais dicas com moedas ou assistindo a um anúncio curto e opcional.';

  @override
  String buyHints(int count, int price) {
    return 'Comprar $count por $price';
  }

  @override
  String watchAdHints(int count) {
    return 'Anúncio por $count';
  }

  @override
  String get hintsDisabled => 'As dicas estão desativadas nos Ajustes.';

  @override
  String get actionShuffle => 'Embaralhar';

  @override
  String get shuffleTitle => 'Embaralhar as cartas?';

  @override
  String shuffleBody(int left) {
    return 'Todas as cartas, exceto as das fundações, serão embaralhadas e distribuídas de novo. Não é possível desfazer. Embaralhadas restantes neste jogo: $left.';
  }

  @override
  String shufflePay(int price) {
    return 'Pagar $price moedas';
  }

  @override
  String get shuffleWatchAd => 'Ver anúncio';

  @override
  String get shuffleLimit => 'Não há mais embaralhadas neste jogo.';

  @override
  String get autoFinishing => 'Finalizando…';

  @override
  String get skip => 'Pular';

  @override
  String get pauseTitle => 'Pausado';

  @override
  String get resume => 'Retomar';

  @override
  String get restartDeal => 'Reiniciar distribuição';

  @override
  String get newGame => 'Novo jogo';

  @override
  String get home => 'Início';

  @override
  String get restartTitle => 'Reiniciar esta distribuição?';

  @override
  String get restartBody =>
      'O progresso deste jogo será perdido. Você jogará a mesma distribuição desde o início.';

  @override
  String get newGameTitle => 'Começar um novo jogo?';

  @override
  String get newGameBody => 'O jogo atual contará como derrota.';

  @override
  String get victoryTitle => 'Vitória!';

  @override
  String get finalScore => 'Pontuação final';

  @override
  String get timeLabel => 'Tempo';

  @override
  String get movesLabel => 'Jogadas';

  @override
  String get maxCombo => 'Combo máximo';

  @override
  String get speedBonus => 'Bônus de velocidade';

  @override
  String get timeBonus => 'Bônus de tempo';

  @override
  String get bestScore => 'Melhor pontuação';

  @override
  String get newRecord => 'Novo recorde!';

  @override
  String coinsEarned(int coins) {
    return '+$coins';
  }

  @override
  String get doubleCoins => 'Dobrar moedas · anúncio';

  @override
  String get coinsDoubled => 'Moedas dobradas!';

  @override
  String get playAgain => 'Novo jogo';

  @override
  String get mainMenu => 'Menu principal';

  @override
  String achievementUnlocked(String name) {
    return 'Conquista desbloqueada: $name';
  }

  @override
  String get dailyTitle => 'Desafio diário';

  @override
  String get todaysChallenge => 'Desafio de hoje';

  @override
  String get dailyInfo => 'Distribuição vencível · Comprar 1';

  @override
  String dailyReward(int coins) {
    return 'Recompensa: $coins';
  }

  @override
  String get play => 'Jogar';

  @override
  String playDay(String date) {
    return 'Jogar $date';
  }

  @override
  String get dailyCompleted => 'Concluído';

  @override
  String get dailyRewardClaimed => 'Recompensa recebida';

  @override
  String get dailyPastNoReward =>
      'Dias anteriores rendem uma marca, não moedas.';

  @override
  String dailyStreak(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Sequência de $days dias',
      one: 'Sequência de 1 dia',
      zero: 'Nenhuma sequência atual',
    );
    return '$_temp0';
  }

  @override
  String get dailyCalendarNote =>
      'Os desafios seguem a data do calendário do seu dispositivo.';

  @override
  String get dailyFuture => 'Ainda não disponível';

  @override
  String dailyCompletedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count concluídos',
      one: '1 concluído',
    );
    return '$_temp0';
  }

  @override
  String get previousMonth => 'Mês anterior';

  @override
  String get nextMonth => 'Próximo mês';

  @override
  String get themesBackgrounds => 'Fundos';

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
  String get restoreDefaults => 'Restaurar padrão';

  @override
  String get getInShop => 'Obter na loja';

  @override
  String get themesContrastNote =>
      'A prévia mostra a legibilidade das cartas nesta mesa.';

  @override
  String get cosmetic_cards_classic => 'Clássico';

  @override
  String get cosmetic_cards_elegant => 'Elegante';

  @override
  String get cosmetic_cards_vintage => 'Vintage';

  @override
  String get cosmetic_cards_modern => 'Moderno';

  @override
  String get cosmetic_cards_neon => 'Neon';

  @override
  String get cosmetic_cards_gold => 'Dourado';

  @override
  String get cosmetic_bg_lake => 'Lago da montanha';

  @override
  String get cosmetic_bg_autumn => 'Trilha de outono';

  @override
  String get cosmetic_bg_tropic => 'Baía tropical';

  @override
  String get cosmetic_bg_alpine => 'Picos alpinos';

  @override
  String get cosmetic_bg_aurora => 'Aurora boreal';

  @override
  String get cosmetic_bg_lavender => 'Crepúsculo de lavanda';

  @override
  String get cosmetic_table_emerald => 'Feltro esmeralda';

  @override
  String get cosmetic_table_navy => 'Azul meia-noite';

  @override
  String get cosmetic_table_burgundy => 'Bordô real';

  @override
  String get cosmetic_table_walnut => 'Nogueira';

  @override
  String get cosmetic_table_slate => 'Ardósia';

  @override
  String get cosmetic_table_contrast => 'Alto contraste';

  @override
  String get statsTotal => 'Total';

  @override
  String get statsPlayed => 'Jogos jogados';

  @override
  String get statsWins => 'Vitórias';

  @override
  String get statsWinRate => 'Taxa de vitórias';

  @override
  String get statsTotalTime => 'Tempo total';

  @override
  String get statsBestScore => 'Melhor pontuação';

  @override
  String get statsFastest => 'Vitória mais rápida';

  @override
  String get statsCurrentStreak => 'Sequência atual';

  @override
  String get statsBestStreak => 'Melhor sequência';

  @override
  String get statsMaxCombo => 'Combo máximo';

  @override
  String get statsFewestMoves => 'Menos jogadas';

  @override
  String get statsDailyDone => 'Desafios diários';

  @override
  String get statsEmpty =>
      'Jogue sua primeira partida para ver suas estatísticas aqui.';

  @override
  String get statsLocalLabel => 'Armazenado neste dispositivo';

  @override
  String durationHm(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String achievementsProgress(int done, int total) {
    return '$done de $total desbloqueadas';
  }

  @override
  String earnedOn(String date) {
    return 'Obtida em $date';
  }

  @override
  String rewardCoins(int coins) {
    return '+$coins';
  }

  @override
  String get shopTitle => 'Loja';

  @override
  String get shopCardPacks => 'Baralhos';

  @override
  String get shopBackgrounds => 'Fundos';

  @override
  String get shopTables => 'Mesas';

  @override
  String get shopHints => 'Dicas';

  @override
  String watchAdCoins(int coins) {
    return 'Ver anúncio: +$coins moedas';
  }

  @override
  String get buy => 'Comprar';

  @override
  String get owned => 'Adquirido';

  @override
  String get equip => 'Usar';

  @override
  String get equipped => 'Em uso';

  @override
  String purchaseTitle(String item) {
    return 'Comprar $item?';
  }

  @override
  String purchaseBody(int price, int after) {
    return 'Custa $price moedas. Saldo após a compra: $after.';
  }

  @override
  String get insufficientTitle => 'Moedas insuficientes';

  @override
  String insufficientBody(int missing) {
    return 'Faltam $missing moedas. Vença jogos, conclua desafios diários e desbloqueie conquistas para ganhar mais.';
  }

  @override
  String purchaseDone(String item) {
    return '$item desbloqueado!';
  }

  @override
  String get hintPackTitle => 'Pacote de dicas';

  @override
  String hintPackBody(int count, int price) {
    return '$count dicas por $price moedas';
  }

  @override
  String hintsOwned(int count) {
    return 'Você tem $count dicas';
  }

  @override
  String get coinsDisclaimer =>
      'As moedas são uma moeda do jogo sem valor monetário. Não podem ser compradas, vendidas, sacadas nem trocadas.';

  @override
  String get settingsGameplay => 'Jogo';

  @override
  String get settingsAudio => 'Som e vibração';

  @override
  String get settingsDisplay => 'Tela';

  @override
  String get settingsPrivacy => 'Privacidade';

  @override
  String get settingsData => 'Dados e conta';

  @override
  String get settingsAbout => 'Sobre';

  @override
  String get music => 'Música';

  @override
  String get sound => 'Efeitos sonoros';

  @override
  String get haptics => 'Vibração';

  @override
  String get reducedMotion => 'Reduzir animações';

  @override
  String get leftHanded => 'Modo canhoto';

  @override
  String get defaultDraw => 'Modo de compra padrão';

  @override
  String get tapToFoundation => 'Tocar envia primeiro às fundações';

  @override
  String get hintsSetting => 'Dicas';

  @override
  String get showTimer => 'Mostrar cronômetro';

  @override
  String get unlimitedPasses => 'Passagens ilimitadas pelo monte';

  @override
  String get limitedPassesNote =>
      'Desativado: Comprar 1 permite 2 voltas e Comprar 3 permite 3.';

  @override
  String get foundationMoves => 'Permitir mover das fundações';

  @override
  String get rulesNextGame =>
      'As mudanças de regras valem a partir do próximo jogo.';

  @override
  String get language => 'Idioma';

  @override
  String get languageSystem => 'Padrão do sistema';

  @override
  String get cloudBackup => 'Backup na nuvem';

  @override
  String get cloudBackupUnavailable =>
      'O backup na nuvem não está configurado nesta versão. Seu progresso é salvo neste dispositivo.';

  @override
  String get signIn => 'Entrar';

  @override
  String get privacyChoices => 'Privacidade e anúncios';

  @override
  String get analyticsSetting => 'Compartilhar estatísticas de uso anônimas';

  @override
  String get personalizedAds => 'Anúncios personalizados';

  @override
  String get privacyPolicy => 'Política de privacidade';

  @override
  String get privacyPolicyBody =>
      'O Solitaire Nova guarda seus jogos, estatísticas e compras apenas neste dispositivo. Não é preciso ter conta. Se você permitir, estatísticas de uso anônimas e anúncios (via Google AdMob) podem ser usados; parceiros de anúncios podem tratar identificadores do dispositivo de acordo com suas escolhas de consentimento. Você pode retirar o consentimento a qualquer momento nos Ajustes.';

  @override
  String get deleteData => 'Apagar dados locais';

  @override
  String get deleteDataTitle => 'Apagar todos os dados locais?';

  @override
  String get deleteDataBody =>
      'Isso remove permanentemente o jogo salvo, estatísticas, conquistas, moedas e itens deste dispositivo. Não é possível desfazer.';

  @override
  String get deleteDataDone => 'Dados locais apagados';

  @override
  String get delete => 'Apagar';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get restoreNone =>
      'Não há compras da loja para restaurar. Itens comprados com moedas permanecem neste dispositivo.';

  @override
  String get howToPlay => 'Como jogar';

  @override
  String get rulesTableau =>
      'Monte as sete colunas em ordem decrescente alternando cores (vermelho sobre preto, preto sobre vermelho). Só um Rei pode ocupar uma coluna vazia.';

  @override
  String get rulesFoundation =>
      'Leve todas as cartas para as quatro fundações, por naipe, do Ás ao Rei.';

  @override
  String get rulesStock =>
      'Toque no monte para virar 1 ou 3 cartas. Quando ele esvaziar, toque de novo para virar o descarte.';

  @override
  String get rulesControls =>
      'Toque numa carta para movê-la automaticamente ou arraste-a. Desfaça qualquer jogada, peça uma dica ou deixe o Auto terminar o jogo quando todas as cartas estiverem viradas.';

  @override
  String get rulesCombo =>
      'Combos contam jogadas úteis seguidas. São só por diversão e nunca mudam as regras.';

  @override
  String get about => 'Sobre';

  @override
  String version(String version) {
    return 'Versão $version';
  }

  @override
  String get licenses => 'Licenças de código aberto';

  @override
  String get aboutBody =>
      'Um Paciência Klondike clássico. Sem apostas, sem prêmios em dinheiro.';

  @override
  String get consentTitle => 'Sua privacidade';

  @override
  String get consentBody =>
      'O Solitaire Nova funciona totalmente offline. Com sua permissão, exibimos anúncios que mantêm o jogo gratuito e coletamos estatísticas de uso anônimas para melhorá-lo. Você pode mudar isso a qualquer momento nos Ajustes.';

  @override
  String get consentAccept => 'Aceitar';

  @override
  String get consentEssential => 'Somente o essencial';

  @override
  String get offlineTitle => 'Você está offline';

  @override
  String get offlineBody =>
      'Este recurso precisa de conexão com a internet. O jogo em si funciona offline.';

  @override
  String get adUnavailableTitle => 'Nenhum anúncio disponível';

  @override
  String get adUnavailableBody =>
      'Não há anúncios para exibir agora. Tente novamente mais tarde.';

  @override
  String get adNotCompleted =>
      'O anúncio foi fechado antes de a recompensa ser obtida.';

  @override
  String get cloudConflictTitle => 'Dois jogos salvos encontrados';

  @override
  String get cloudConflictBody =>
      'Este dispositivo e seu backup na nuvem têm um jogo em andamento. Qual você quer manter?';

  @override
  String get keepThisDevice => 'Este dispositivo';

  @override
  String get keepCloud => 'A nuvem';

  @override
  String get errorTitle => 'Algo deu errado';

  @override
  String get errorBody => 'Seu progresso está seguro. Tente novamente.';

  @override
  String get achTitle_first_win => 'Primeira vitória';

  @override
  String get achTitle_wins_10 => 'Estrela em ascensão';

  @override
  String get achTitle_wins_50 => 'Ás das cartas';

  @override
  String get achTitle_wins_100 => 'Mestre da Paciência';

  @override
  String get achTitle_wins_250 => 'Grão-mestre';

  @override
  String get achTitle_wins_500 => 'Lenda viva';

  @override
  String get achTitle_played_10 => 'Primeiros passos';

  @override
  String get achTitle_played_100 => 'Frequentador';

  @override
  String get achTitle_played_500 => 'Apaixonado';

  @override
  String get achTitle_streak_3 => 'Trinca';

  @override
  String get achTitle_streak_5 => 'Embalado';

  @override
  String get achTitle_streak_10 => 'Imparável';

  @override
  String get achTitle_draw3_first => 'Ameaça tripla';

  @override
  String get achTitle_draw3_25 => 'Veterano do Comprar 3';

  @override
  String get achTitle_no_hints => 'Por conta própria';

  @override
  String get achTitle_no_undo => 'Sem arrependimentos';

  @override
  String get achTitle_purist_10 => 'Purista';

  @override
  String get achTitle_speed_5 => 'Mãos ágeis';

  @override
  String get achTitle_speed_3 => 'Veloz';

  @override
  String get achTitle_speed_2 => 'Relâmpago';

  @override
  String get achTitle_moves_120 => 'Eficiente';

  @override
  String get achTitle_moves_100 => 'Econômico';

  @override
  String get achTitle_score_4000 => 'Pontuação alta';

  @override
  String get achTitle_score_6000 => 'Lenda da pontuação';

  @override
  String get achTitle_combo_5 => 'Início de combo';

  @override
  String get achTitle_combo_10 => 'Especialista em combos';

  @override
  String get achTitle_daily_first => 'Estreia diária';

  @override
  String get achTitle_daily_total_10 => 'Frequentador diário';

  @override
  String get achTitle_daily_total_30 => 'Fiel diário';

  @override
  String get achTitle_daily_streak_7 => 'Jogador diário';

  @override
  String get achTitle_winning_10 => 'Finalizador';

  @override
  String get achTitle_auto_finish => 'Final suave';

  @override
  String get achTitle_marathon => 'Maratona';

  @override
  String get achTitle_collector_5 => 'Colecionador';

  @override
  String get achTitle_stylist => 'Estilista';

  @override
  String get achTitle_level_10 => 'Experiente';

  @override
  String achDescWins(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vença $count jogos',
      one: 'Vença seu primeiro jogo',
    );
    return '$_temp0';
  }

  @override
  String achDescPlayed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Jogue $count partidas',
      one: 'Jogue 1 partida',
    );
    return '$_temp0';
  }

  @override
  String achDescStreak(int count) {
    return 'Vença $count jogos seguidos';
  }

  @override
  String achDescDraw3(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vença $count jogos de Comprar 3',
      one: 'Vença um jogo de Comprar 3',
    );
    return '$_temp0';
  }

  @override
  String get achDescNoHints => 'Vença um jogo sem dicas';

  @override
  String get achDescNoUndo => 'Vença um jogo sem desfazer';

  @override
  String achDescPurist(int count) {
    return 'Vença $count jogos sem dicas nem desfazer';
  }

  @override
  String achDescSpeed(int minutes) {
    return 'Vença um jogo em menos de $minutes minutos';
  }

  @override
  String achDescMoves(int count) {
    return 'Vença um jogo com $count jogadas ou menos';
  }

  @override
  String achDescScore(int score) {
    return 'Faça $score pontos em um jogo';
  }

  @override
  String achDescCombo(int count) {
    return 'Alcance um combo de ${count}x';
  }

  @override
  String achDescDailyTotal(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Conclua $count desafios diários',
      one: 'Conclua um desafio diário',
    );
    return '$_temp0';
  }

  @override
  String achDescDailyStreak(int count) {
    return 'Conclua desafios diários por $count dias seguidos';
  }

  @override
  String achDescWinning(int count) {
    return 'Vença $count distribuições vencíveis';
  }

  @override
  String get achDescAutoFinish => 'Termine um jogo com o Auto';

  @override
  String achDescMarathon(int hours) {
    return 'Jogue $hours horas no total';
  }

  @override
  String achDescCollector(int count) {
    return 'Compre $count itens cosméticos';
  }

  @override
  String get achDescStylist => 'Aplique um novo tema';

  @override
  String achDescLevel(int level) {
    return 'Alcance o nível $level';
  }
}
