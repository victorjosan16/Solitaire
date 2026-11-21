// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Solitaire Nova';

  @override
  String splashLoading(int percent) {
    return 'Загрузка… $percent%';
  }

  @override
  String get navHome => 'Главная';

  @override
  String get navStats => 'Статистика';

  @override
  String get navShop => 'Магазин';

  @override
  String get navProfile => 'Профиль';

  @override
  String get gameModeSetting => 'Режим игры';

  @override
  String get navSettings => 'Настройки';

  @override
  String get back => 'Назад';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Отмена';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get close => 'Закрыть';

  @override
  String levelLabel(int level) {
    return 'Уровень $level';
  }

  @override
  String coinsBalance(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins монеты',
      many: '$coins монет',
      few: '$coins монеты',
      one: '$coins монета',
    );
    return '$_temp0';
  }

  @override
  String get continueGame => 'Продолжить';

  @override
  String continueSubtitle(String mode, int moves, String time) {
    return '$mode · ходов: $moves · $time';
  }

  @override
  String get playClassic => 'Классическая игра';

  @override
  String get drawOne => 'По 1';

  @override
  String get drawThree => 'По 3';

  @override
  String get dealRandom => 'Случайная раздача';

  @override
  String get dealWinning => 'Выигрышная раздача';

  @override
  String get dealWinningInfo =>
      'Выигрышные раздачи проверены нашим решателем и имеют решение. У случайной раздачи решения может не быть.';

  @override
  String get dailyChallenge => 'Задание дня';

  @override
  String get achievements => 'Достижения';

  @override
  String get themes => 'Темы';

  @override
  String get statistics => 'Статистика';

  @override
  String get shop => 'Магазин';

  @override
  String get settings => 'Настройки';

  @override
  String get modeRandom => 'Случайная';

  @override
  String get modeWinning => 'Выигрышная';

  @override
  String get modeDaily => 'Задание дня';

  @override
  String get hudScore => 'Счёт';

  @override
  String get hudTime => 'Время';

  @override
  String get hudMoves => 'Ходы';

  @override
  String get actionUndo => 'Отменить';

  @override
  String get actionHint => 'Подсказка';

  @override
  String get actionAuto => 'Авто';

  @override
  String get actionNew => 'Новая';

  @override
  String get actionPause => 'Пауза';

  @override
  String hintsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Осталось $count подсказки',
      many: 'Осталось $count подсказок',
      few: 'Осталось $count подсказки',
      one: 'Осталась $count подсказка',
      zero: 'Подсказок не осталось',
    );
    return '$_temp0';
  }

  @override
  String semStock(int count) {
    return 'Колода, карт: $count. Нажмите, чтобы взять.';
  }

  @override
  String get semStockRecycle =>
      'Колода пуста. Нажмите, чтобы перевернуть сброс.';

  @override
  String get semStockEmpty => 'Колода пуста';

  @override
  String get semWaste => 'Открытые карты';

  @override
  String semFoundation(String suit, int count) {
    return 'Основание, $suit, карт: $count';
  }

  @override
  String semEmptyColumn(int column) {
    return 'Пустая колонка $column';
  }

  @override
  String semCard(String rank, String suit) {
    return '$rank, $suit';
  }

  @override
  String get semFaceDown => 'Закрытая карта';

  @override
  String get suitClubs => 'трефы';

  @override
  String get suitDiamonds => 'бубны';

  @override
  String get suitHearts => 'черви';

  @override
  String get suitSpades => 'пики';

  @override
  String get rankAce => 'Туз';

  @override
  String get rankJack => 'Валет';

  @override
  String get rankQueen => 'Дама';

  @override
  String get rankKing => 'Король';

  @override
  String get noMovesTitle => 'Полезных ходов нет';

  @override
  String get noMovesBody =>
      'Сейчас нет продуктивных ходов. Можно отменить ход, начать эту раздачу заново или начать новую игру.';

  @override
  String get noHintsTitle => 'Подсказки закончились';

  @override
  String get noHintsBody =>
      'Получите подсказки за монеты или посмотрев короткую рекламу по желанию.';

  @override
  String buyHints(int count, int price) {
    return 'Купить $count за $price';
  }

  @override
  String watchAdHints(int count) {
    return 'Реклама: +$count';
  }

  @override
  String get hintsDisabled => 'Подсказки отключены в настройках.';

  @override
  String get actionShuffle => 'Перемешать';

  @override
  String get shuffleTitle => 'Перемешать карты?';

  @override
  String shuffleBody(int left) {
    return 'Все карты, кроме лежащих в основаниях, будут перемешаны и разложены заново. Это действие нельзя отменить. Осталось перемешиваний в этой игре: $left.';
  }

  @override
  String shufflePay(int price) {
    return 'Заплатить $price монет';
  }

  @override
  String get shuffleWatchAd => 'Смотреть рекламу';

  @override
  String get shuffleLimit => 'В этой игре перемешиваний больше нет.';

  @override
  String get autoFinishing => 'Завершаем…';

  @override
  String get skip => 'Пропустить';

  @override
  String get pauseTitle => 'Пауза';

  @override
  String get resume => 'Продолжить';

  @override
  String get restartDeal => 'Начать раздачу заново';

  @override
  String get newGame => 'Новая игра';

  @override
  String get home => 'Главная';

  @override
  String get restartTitle => 'Начать раздачу заново?';

  @override
  String get restartBody =>
      'Прогресс в этой игре будет потерян. Вы сыграете ту же раздачу с начала.';

  @override
  String get newGameTitle => 'Начать новую игру?';

  @override
  String get newGameBody => 'Текущая игра будет засчитана как поражение.';

  @override
  String get victoryTitle => 'Победа!';

  @override
  String get finalScore => 'Итоговый счёт';

  @override
  String get timeLabel => 'Время';

  @override
  String get movesLabel => 'Ходы';

  @override
  String get maxCombo => 'Макс. комбо';

  @override
  String get speedBonus => 'Бонус за скорость';

  @override
  String get timeBonus => 'Бонус за время';

  @override
  String get bestScore => 'Лучший счёт';

  @override
  String get newRecord => 'Новый рекорд!';

  @override
  String coinsEarned(int coins) {
    return '+$coins';
  }

  @override
  String get doubleCoins => 'Удвоить монеты · реклама';

  @override
  String get coinsDoubled => 'Монеты удвоены!';

  @override
  String get playAgain => 'Новая игра';

  @override
  String get mainMenu => 'Главное меню';

  @override
  String achievementUnlocked(String name) {
    return 'Достижение получено: $name';
  }

  @override
  String get dailyTitle => 'Задание дня';

  @override
  String get todaysChallenge => 'Сегодняшнее задание';

  @override
  String get dailyInfo => 'Выигрышная раздача · По 1';

  @override
  String dailyReward(int coins) {
    return 'Награда: $coins';
  }

  @override
  String get play => 'Играть';

  @override
  String playDay(String date) {
    return 'Играть $date';
  }

  @override
  String get dailyCompleted => 'Выполнено';

  @override
  String get dailyRewardClaimed => 'Награда получена';

  @override
  String get dailyPastNoReward =>
      'За прошлые дни ставится отметка, но монеты не начисляются.';

  @override
  String dailyStreak(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Серия: $days дня',
      many: 'Серия: $days дней',
      few: 'Серия: $days дня',
      one: 'Серия: $days день',
      zero: 'Серии нет',
    );
    return '$_temp0';
  }

  @override
  String get dailyCalendarNote =>
      'Задания привязаны к календарной дате на устройстве.';

  @override
  String get dailyFuture => 'Пока недоступно';

  @override
  String dailyCompletedCount(int count) {
    return 'Выполнено: $count';
  }

  @override
  String get previousMonth => 'Предыдущий месяц';

  @override
  String get nextMonth => 'Следующий месяц';

  @override
  String get themesBackgrounds => 'Фоны';

  @override
  String get themesCards => 'Карты';

  @override
  String get themesTables => 'Столы';

  @override
  String get apply => 'Применить';

  @override
  String get applied => 'Применено';

  @override
  String get locked => 'Закрыто';

  @override
  String get restoreDefaults => 'Сбросить по умолчанию';

  @override
  String get getInShop => 'Получить в магазине';

  @override
  String get themesContrastNote =>
      'Превью показывает, как читаются карты на этом столе.';

  @override
  String get cosmetic_cards_classic => 'Классика';

  @override
  String get cosmetic_cards_elegant => 'Элегант';

  @override
  String get cosmetic_cards_vintage => 'Винтаж';

  @override
  String get cosmetic_cards_modern => 'Модерн';

  @override
  String get cosmetic_cards_neon => 'Неон';

  @override
  String get cosmetic_cards_gold => 'Золото';

  @override
  String get cosmetic_bg_lake => 'Горное озеро';

  @override
  String get cosmetic_bg_autumn => 'Осенняя тропа';

  @override
  String get cosmetic_bg_tropic => 'Тропическая бухта';

  @override
  String get cosmetic_bg_alpine => 'Альпийские вершины';

  @override
  String get cosmetic_bg_aurora => 'Северное сияние';

  @override
  String get cosmetic_bg_lavender => 'Лавандовые сумерки';

  @override
  String get cosmetic_table_emerald => 'Изумрудное сукно';

  @override
  String get cosmetic_table_navy => 'Ночной синий';

  @override
  String get cosmetic_table_burgundy => 'Королевский бордо';

  @override
  String get cosmetic_table_walnut => 'Орех';

  @override
  String get cosmetic_table_slate => 'Сланец';

  @override
  String get cosmetic_table_contrast => 'Высокий контраст';

  @override
  String get statsTotal => 'Всего';

  @override
  String get statsPlayed => 'Сыграно игр';

  @override
  String get statsWins => 'Победы';

  @override
  String get statsWinRate => 'Процент побед';

  @override
  String get statsTotalTime => 'Общее время';

  @override
  String get statsBestScore => 'Лучший счёт';

  @override
  String get statsFastest => 'Самая быстрая победа';

  @override
  String get statsCurrentStreak => 'Текущая серия';

  @override
  String get statsBestStreak => 'Лучшая серия';

  @override
  String get statsMaxCombo => 'Макс. комбо';

  @override
  String get statsFewestMoves => 'Меньше всего ходов';

  @override
  String get statsDailyDone => 'Задания дня';

  @override
  String get statsEmpty =>
      'Сыграйте первую игру, чтобы увидеть здесь статистику.';

  @override
  String get statsLocalLabel => 'Хранится на этом устройстве';

  @override
  String durationHm(int hours, int minutes) {
    return '$hours ч $minutes мин';
  }

  @override
  String achievementsProgress(int done, int total) {
    return 'Получено $done из $total';
  }

  @override
  String earnedOn(String date) {
    return 'Получено $date';
  }

  @override
  String rewardCoins(int coins) {
    return '+$coins';
  }

  @override
  String get shopTitle => 'Магазин';

  @override
  String get shopCardPacks => 'Колоды';

  @override
  String get shopBackgrounds => 'Фоны';

  @override
  String get shopTables => 'Столы';

  @override
  String get shopHints => 'Подсказки';

  @override
  String watchAdCoins(int coins) {
    return 'Реклама: +$coins монет';
  }

  @override
  String get buy => 'Купить';

  @override
  String get owned => 'Куплено';

  @override
  String get equip => 'Выбрать';

  @override
  String get equipped => 'Выбрано';

  @override
  String purchaseTitle(String item) {
    return 'Купить «$item»?';
  }

  @override
  String purchaseBody(int price, int after) {
    return 'Цена: $price монет. Баланс после покупки: $after.';
  }

  @override
  String get insufficientTitle => 'Недостаточно монет';

  @override
  String insufficientBody(int missing) {
    return 'Не хватает монет: $missing. Выигрывайте партии, выполняйте задания дня и получайте достижения, чтобы заработать больше.';
  }

  @override
  String purchaseDone(String item) {
    return '«$item» разблокировано!';
  }

  @override
  String get hintPackTitle => 'Набор подсказок';

  @override
  String hintPackBody(int count, int price) {
    return 'Подсказок: $count за $price монет';
  }

  @override
  String hintsOwned(int count) {
    return 'Ваши подсказки: $count';
  }

  @override
  String get coinsDisclaimer =>
      'Монеты — игровая валюта без денежной ценности. Их нельзя купить, продать, вывести или обменять.';

  @override
  String get settingsGameplay => 'Игра';

  @override
  String get settingsAudio => 'Звук и вибрация';

  @override
  String get settingsDisplay => 'Отображение';

  @override
  String get settingsPrivacy => 'Конфиденциальность';

  @override
  String get settingsData => 'Данные и аккаунт';

  @override
  String get settingsAbout => 'О приложении';

  @override
  String get music => 'Музыка';

  @override
  String get sound => 'Звуковые эффекты';

  @override
  String get haptics => 'Вибрация';

  @override
  String get reducedMotion => 'Меньше анимации';

  @override
  String get leftHanded => 'Режим для левши';

  @override
  String get defaultDraw => 'Режим по умолчанию';

  @override
  String get tapToFoundation => 'Нажатие сначала отправляет карту в основание';

  @override
  String get hintsSetting => 'Подсказки';

  @override
  String get showTimer => 'Показывать таймер';

  @override
  String get unlimitedPasses => 'Неограниченные проходы колоды';

  @override
  String get limitedPassesNote =>
      'Если выключено: «По 1» — 2 переворота, «По 3» — 3.';

  @override
  String get foundationMoves => 'Разрешить ходы из оснований';

  @override
  String get rulesNextGame =>
      'Изменения правил вступят в силу со следующей игры.';

  @override
  String get language => 'Язык';

  @override
  String get languageSystem => 'Как в системе';

  @override
  String get cloudBackup => 'Резервная копия в облаке';

  @override
  String get cloudBackupUnavailable =>
      'Облачное резервное копирование не настроено в этой сборке. Прогресс сохраняется на этом устройстве.';

  @override
  String get signIn => 'Войти';

  @override
  String get privacyChoices => 'Конфиденциальность и реклама';

  @override
  String get analyticsSetting =>
      'Отправлять анонимную статистику использования';

  @override
  String get personalizedAds => 'Персонализированная реклама';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get privacyPolicyBody =>
      'Solitaire Nova хранит ваши игры, статистику и покупки только на этом устройстве. Аккаунт не нужен. С вашего разрешения могут использоваться анонимная статистика и реклама (через Google AdMob); рекламные партнёры могут обрабатывать идентификаторы устройства в соответствии с вашим согласием. Отозвать согласие можно в любой момент в настройках.';

  @override
  String get deleteData => 'Удалить локальные данные';

  @override
  String get deleteDataTitle => 'Удалить все локальные данные?';

  @override
  String get deleteDataBody =>
      'Сохранённая игра, статистика, достижения, монеты и предметы на этом устройстве будут удалены навсегда. Это действие нельзя отменить.';

  @override
  String get deleteDataDone => 'Локальные данные удалены';

  @override
  String get delete => 'Удалить';

  @override
  String get restorePurchases => 'Восстановить покупки';

  @override
  String get restoreNone =>
      'Нет покупок из магазина приложений для восстановления. Предметы, купленные за монеты, хранятся на этом устройстве.';

  @override
  String get howToPlay => 'Как играть';

  @override
  String get rulesTableau =>
      'Стройте семь колонок по убыванию, чередуя цвета (красная на чёрную, чёрная на красную). В пустую колонку можно положить только короля.';

  @override
  String get rulesFoundation =>
      'Переложите все карты в четыре основания по мастям — от туза до короля.';

  @override
  String get rulesStock =>
      'Нажмите на колоду, чтобы открыть 1 или 3 карты. Когда она опустеет, нажмите снова, чтобы перевернуть сброс.';

  @override
  String get rulesControls =>
      'Нажмите на карту, чтобы переложить её автоматически, или перетащите её. Любой ход можно отменить, можно взять подсказку или доверить «Авто» завершение, когда все карты открыты.';

  @override
  String get rulesCombo =>
      'Комбо считает подряд идущие полезные ходы. Это просто для удовольствия — правила они не меняют.';

  @override
  String get about => 'О игре';

  @override
  String version(String version) {
    return 'Версия $version';
  }

  @override
  String get licenses => 'Лицензии открытого ПО';

  @override
  String get aboutBody =>
      'Классический пасьянс «Косынка». Без азартных игр и денежных призов.';

  @override
  String get consentTitle => 'Ваша конфиденциальность';

  @override
  String get consentBody =>
      'Solitaire Nova полностью работает офлайн. С вашего разрешения мы показываем рекламу, благодаря которой игра остаётся бесплатной, и собираем анонимную статистику для её улучшения. Это можно изменить в любой момент в настройках.';

  @override
  String get consentAccept => 'Принять';

  @override
  String get consentEssential => 'Только необходимое';

  @override
  String get offlineTitle => 'Нет подключения';

  @override
  String get offlineBody =>
      'Для этой функции нужен интернет. Сама игра работает офлайн.';

  @override
  String get adUnavailableTitle => 'Реклама недоступна';

  @override
  String get adUnavailableBody =>
      'Сейчас нет рекламы для показа. Попробуйте позже.';

  @override
  String get adNotCompleted => 'Реклама закрыта до получения награды.';

  @override
  String get cloudConflictTitle => 'Найдены две сохранённые игры';

  @override
  String get cloudConflictBody =>
      'И на этом устройстве, и в облаке есть незавершённая игра. Какую сохранить?';

  @override
  String get keepThisDevice => 'С этого устройства';

  @override
  String get keepCloud => 'Из облака';

  @override
  String get errorTitle => 'Что-то пошло не так';

  @override
  String get errorBody =>
      'Ваш прогресс в безопасности. Пожалуйста, попробуйте ещё раз.';

  @override
  String get achTitle_first_win => 'Первая победа';

  @override
  String get achTitle_wins_10 => 'Восходящая звезда';

  @override
  String get achTitle_wins_50 => 'Знаток карт';

  @override
  String get achTitle_wins_100 => 'Мастер пасьянса';

  @override
  String get achTitle_wins_250 => 'Гроссмейстер';

  @override
  String get achTitle_wins_500 => 'Живая легенда';

  @override
  String get achTitle_played_10 => 'Первые шаги';

  @override
  String get achTitle_played_100 => 'Завсегдатай';

  @override
  String get achTitle_played_500 => 'Преданный игрок';

  @override
  String get achTitle_streak_3 => 'Хет-трик';

  @override
  String get achTitle_streak_5 => 'В ударе';

  @override
  String get achTitle_streak_10 => 'Неудержимый';

  @override
  String get achTitle_draw3_first => 'Тройная угроза';

  @override
  String get achTitle_draw3_25 => 'Ветеран «По 3»';

  @override
  String get achTitle_no_hints => 'Сам с усам';

  @override
  String get achTitle_no_undo => 'Без сожалений';

  @override
  String get achTitle_purist_10 => 'Пурист';

  @override
  String get achTitle_speed_5 => 'Ловкие руки';

  @override
  String get achTitle_speed_3 => 'Стремительный';

  @override
  String get achTitle_speed_2 => 'Молния';

  @override
  String get achTitle_moves_120 => 'Эффективный';

  @override
  String get achTitle_moves_100 => 'Экономист';

  @override
  String get achTitle_score_4000 => 'Рекордсмен';

  @override
  String get achTitle_score_6000 => 'Легенда счёта';

  @override
  String get achTitle_combo_5 => 'Начало комбо';

  @override
  String get achTitle_combo_10 => 'Мастер комбо';

  @override
  String get achTitle_daily_first => 'Дебют дня';

  @override
  String get achTitle_daily_total_10 => 'Постоянный игрок';

  @override
  String get achTitle_daily_total_30 => 'Верный ежедневник';

  @override
  String get achTitle_daily_streak_7 => 'Игрок дня';

  @override
  String get achTitle_winning_10 => 'Доводящий до конца';

  @override
  String get achTitle_auto_finish => 'Плавный финиш';

  @override
  String get achTitle_marathon => 'Марафон';

  @override
  String get achTitle_collector_5 => 'Коллекционер';

  @override
  String get achTitle_stylist => 'Стилист';

  @override
  String get achTitle_level_10 => 'Опытный';

  @override
  String achDescWins(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Выиграйте $count игры',
      many: 'Выиграйте $count игр',
      few: 'Выиграйте $count игры',
      one: 'Выиграйте $count игру',
    );
    return '$_temp0';
  }

  @override
  String achDescPlayed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Сыграйте $count игры',
      many: 'Сыграйте $count игр',
      few: 'Сыграйте $count игры',
      one: 'Сыграйте $count игру',
    );
    return '$_temp0';
  }

  @override
  String achDescStreak(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Выиграйте $count игры подряд',
      many: 'Выиграйте $count игр подряд',
      few: 'Выиграйте $count игры подряд',
      one: 'Выиграйте $count игру подряд',
    );
    return '$_temp0';
  }

  @override
  String achDescDraw3(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Выиграйте $count игры «По 3»',
      many: 'Выиграйте $count игр «По 3»',
      few: 'Выиграйте $count игры «По 3»',
      one: 'Выиграйте $count игру «По 3»',
    );
    return '$_temp0';
  }

  @override
  String get achDescNoHints => 'Выиграйте игру без подсказок';

  @override
  String get achDescNoUndo => 'Выиграйте игру без отмены ходов';

  @override
  String achDescPurist(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Выиграйте $count игры без подсказок и отмен',
      many: 'Выиграйте $count игр без подсказок и отмен',
      few: 'Выиграйте $count игры без подсказок и отмен',
      one: 'Выиграйте $count игру без подсказок и отмен',
    );
    return '$_temp0';
  }

  @override
  String achDescSpeed(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Выиграйте игру быстрее чем за $minutes минуты',
      many: 'Выиграйте игру быстрее чем за $minutes минут',
      few: 'Выиграйте игру быстрее чем за $minutes минуты',
      one: 'Выиграйте игру быстрее чем за $minutes минуту',
    );
    return '$_temp0';
  }

  @override
  String achDescMoves(int count) {
    return 'Выиграйте игру не более чем за $count ходов';
  }

  @override
  String achDescScore(int score) {
    return 'Наберите $score очков за одну игру';
  }

  @override
  String achDescCombo(int count) {
    return 'Достигните комбо ${count}x';
  }

  @override
  String achDescDailyTotal(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Выполните $count задания дня',
      many: 'Выполните $count заданий дня',
      few: 'Выполните $count задания дня',
      one: 'Выполните $count задание дня',
    );
    return '$_temp0';
  }

  @override
  String achDescDailyStreak(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Выполняйте задания дня $count дня подряд',
      many: 'Выполняйте задания дня $count дней подряд',
      few: 'Выполняйте задания дня $count дня подряд',
      one: 'Выполняйте задания дня $count день подряд',
    );
    return '$_temp0';
  }

  @override
  String achDescWinning(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Выиграйте $count выигрышной раздачи',
      many: 'Выиграйте $count выигрышных раздач',
      few: 'Выиграйте $count выигрышные раздачи',
      one: 'Выиграйте $count выигрышную раздачу',
    );
    return '$_temp0';
  }

  @override
  String get achDescAutoFinish => 'Завершите игру с помощью «Авто»';

  @override
  String achDescMarathon(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Играйте в сумме $hours часа',
      many: 'Играйте в сумме $hours часов',
      few: 'Играйте в сумме $hours часа',
      one: 'Играйте в сумме $hours час',
    );
    return '$_temp0';
  }

  @override
  String achDescCollector(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Купите $count косметического предмета',
      many: 'Купите $count косметических предметов',
      few: 'Купите $count косметических предмета',
      one: 'Купите $count косметический предмет',
    );
    return '$_temp0';
  }

  @override
  String get achDescStylist => 'Примените новую тему';

  @override
  String achDescLevel(int level) {
    return 'Достигните уровня $level';
  }
}
