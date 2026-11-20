// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'Solitaire Nova';

  @override
  String splashLoading(int percent) {
    return 'Завантаження… $percent%';
  }

  @override
  String get navHome => 'Головна';

  @override
  String get navStats => 'Статистика';

  @override
  String get navShop => 'Крамниця';

  @override
  String get navSettings => 'Налаштування';

  @override
  String get back => 'Назад';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Скасувати';

  @override
  String get confirm => 'Підтвердити';

  @override
  String get close => 'Закрити';

  @override
  String levelLabel(int level) {
    return 'Рівень $level';
  }

  @override
  String coinsBalance(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins монети',
      many: '$coins монет',
      few: '$coins монети',
      one: '$coins монета',
    );
    return '$_temp0';
  }

  @override
  String get continueGame => 'Продовжити';

  @override
  String continueSubtitle(String mode, int moves, String time) {
    return '$mode · ходів: $moves · $time';
  }

  @override
  String get playClassic => 'Класична гра';

  @override
  String get drawOne => 'По 1';

  @override
  String get drawThree => 'По 3';

  @override
  String get dealRandom => 'Випадкова роздача';

  @override
  String get dealWinning => 'Виграшна роздача';

  @override
  String get dealWinningInfo =>
      'Виграшні роздачі перевірено нашим розв\'язувачем — вони мають розв\'язок. Випадкова роздача може не мати розв\'язку.';

  @override
  String get dailyChallenge => 'Завдання дня';

  @override
  String get achievements => 'Досягнення';

  @override
  String get themes => 'Теми';

  @override
  String get statistics => 'Статистика';

  @override
  String get shop => 'Крамниця';

  @override
  String get settings => 'Налаштування';

  @override
  String get modeRandom => 'Випадкова';

  @override
  String get modeWinning => 'Виграшна';

  @override
  String get modeDaily => 'Завдання дня';

  @override
  String get hudScore => 'Рахунок';

  @override
  String get hudTime => 'Час';

  @override
  String get hudMoves => 'Ходи';

  @override
  String get actionUndo => 'Скасувати';

  @override
  String get actionHint => 'Підказка';

  @override
  String get actionAuto => 'Авто';

  @override
  String get actionNew => 'Нова';

  @override
  String get actionPause => 'Пауза';

  @override
  String hintsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Залишилося $count підказки',
      many: 'Залишилося $count підказок',
      few: 'Залишилося $count підказки',
      one: 'Залишилася $count підказка',
      zero: 'Підказок не залишилося',
    );
    return '$_temp0';
  }

  @override
  String semStock(int count) {
    return 'Колода, карт: $count. Торкніться, щоб узяти.';
  }

  @override
  String get semStockRecycle =>
      'Колода порожня. Торкніться, щоб перевернути скид.';

  @override
  String get semStockEmpty => 'Колода порожня';

  @override
  String get semWaste => 'Відкриті карти';

  @override
  String semFoundation(String suit, int count) {
    return 'Основа, $suit, карт: $count';
  }

  @override
  String semEmptyColumn(int column) {
    return 'Порожня колонка $column';
  }

  @override
  String semCard(String rank, String suit) {
    return '$rank, $suit';
  }

  @override
  String get semFaceDown => 'Закрита карта';

  @override
  String get suitClubs => 'трефи';

  @override
  String get suitDiamonds => 'бубни';

  @override
  String get suitHearts => 'черви';

  @override
  String get suitSpades => 'піки';

  @override
  String get rankAce => 'Туз';

  @override
  String get rankJack => 'Валет';

  @override
  String get rankQueen => 'Дама';

  @override
  String get rankKing => 'Король';

  @override
  String get noMovesTitle => 'Корисних ходів немає';

  @override
  String get noMovesBody =>
      'Зараз немає продуктивних ходів. Можна скасувати хід, почати цю роздачу спочатку або почати нову гру.';

  @override
  String get noHintsTitle => 'Підказки скінчилися';

  @override
  String get noHintsBody =>
      'Отримайте підказки за монети або переглянувши коротку рекламу за бажанням.';

  @override
  String buyHints(int count, int price) {
    return 'Купити $count за $price';
  }

  @override
  String watchAdHints(int count) {
    return 'Реклама: +$count';
  }

  @override
  String get hintsDisabled => 'Підказки вимкнено в налаштуваннях.';

  @override
  String get actionShuffle => 'Перемішати';

  @override
  String get shuffleTitle => 'Перемішати карти?';

  @override
  String shuffleBody(int left) {
    return 'Усі карти, крім тих, що лежать в основах, буде перемішано й розкладено заново. Цю дію не можна скасувати. Залишилося перемішувань у цій грі: $left.';
  }

  @override
  String shufflePay(int price) {
    return 'Заплатити $price монет';
  }

  @override
  String get shuffleWatchAd => 'Переглянути рекламу';

  @override
  String get shuffleLimit => 'У цій грі перемішувань більше немає.';

  @override
  String get autoFinishing => 'Завершуємо…';

  @override
  String get skip => 'Пропустити';

  @override
  String get pauseTitle => 'Пауза';

  @override
  String get resume => 'Продовжити';

  @override
  String get restartDeal => 'Почати роздачу знову';

  @override
  String get newGame => 'Нова гра';

  @override
  String get home => 'Головна';

  @override
  String get restartTitle => 'Почати роздачу знову?';

  @override
  String get restartBody =>
      'Прогрес у цій грі буде втрачено. Ви зіграєте ту саму роздачу з початку.';

  @override
  String get newGameTitle => 'Почати нову гру?';

  @override
  String get newGameBody => 'Поточну гру буде зараховано як поразку.';

  @override
  String get victoryTitle => 'Перемога!';

  @override
  String get finalScore => 'Підсумковий рахунок';

  @override
  String get timeLabel => 'Час';

  @override
  String get movesLabel => 'Ходи';

  @override
  String get maxCombo => 'Макс. комбо';

  @override
  String get speedBonus => 'Бонус за швидкість';

  @override
  String get timeBonus => 'Бонус за час';

  @override
  String get bestScore => 'Найкращий рахунок';

  @override
  String get newRecord => 'Новий рекорд!';

  @override
  String coinsEarned(int coins) {
    return '+$coins';
  }

  @override
  String get doubleCoins => 'Подвоїти монети · реклама';

  @override
  String get coinsDoubled => 'Монети подвоєно!';

  @override
  String get playAgain => 'Нова гра';

  @override
  String get mainMenu => 'Головне меню';

  @override
  String achievementUnlocked(String name) {
    return 'Отримано досягнення: $name';
  }

  @override
  String get dailyTitle => 'Завдання дня';

  @override
  String get todaysChallenge => 'Сьогоднішнє завдання';

  @override
  String get dailyInfo => 'Виграшна роздача · По 1';

  @override
  String dailyReward(int coins) {
    return 'Нагорода: $coins';
  }

  @override
  String get play => 'Грати';

  @override
  String playDay(String date) {
    return 'Грати $date';
  }

  @override
  String get dailyCompleted => 'Виконано';

  @override
  String get dailyRewardClaimed => 'Нагороду отримано';

  @override
  String get dailyPastNoReward =>
      'За минулі дні ставиться позначка, але монети не нараховуються.';

  @override
  String dailyStreak(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Серія: $days дня',
      many: 'Серія: $days днів',
      few: 'Серія: $days дні',
      one: 'Серія: $days день',
      zero: 'Серії немає',
    );
    return '$_temp0';
  }

  @override
  String get dailyCalendarNote =>
      'Завдання прив\'язані до календарної дати на пристрої.';

  @override
  String get dailyFuture => 'Поки недоступно';

  @override
  String dailyCompletedCount(int count) {
    return 'Виконано: $count';
  }

  @override
  String get previousMonth => 'Попередній місяць';

  @override
  String get nextMonth => 'Наступний місяць';

  @override
  String get themesBackgrounds => 'Фони';

  @override
  String get themesCards => 'Карти';

  @override
  String get themesTables => 'Столи';

  @override
  String get apply => 'Застосувати';

  @override
  String get applied => 'Застосовано';

  @override
  String get locked => 'Заблоковано';

  @override
  String get restoreDefaults => 'Скинути до типових';

  @override
  String get getInShop => 'Отримати в крамниці';

  @override
  String get themesContrastNote =>
      'Попередній перегляд показує, як читаються карти на цьому столі.';

  @override
  String get cosmetic_cards_classic => 'Класика';

  @override
  String get cosmetic_cards_elegant => 'Елегант';

  @override
  String get cosmetic_cards_vintage => 'Вінтаж';

  @override
  String get cosmetic_cards_modern => 'Модерн';

  @override
  String get cosmetic_cards_neon => 'Неон';

  @override
  String get cosmetic_cards_gold => 'Золото';

  @override
  String get cosmetic_bg_lake => 'Гірське озеро';

  @override
  String get cosmetic_bg_autumn => 'Осіння стежка';

  @override
  String get cosmetic_bg_tropic => 'Тропічна затока';

  @override
  String get cosmetic_bg_alpine => 'Альпійські вершини';

  @override
  String get cosmetic_bg_aurora => 'Північне сяйво';

  @override
  String get cosmetic_bg_lavender => 'Лавандові сутінки';

  @override
  String get cosmetic_table_emerald => 'Смарагдове сукно';

  @override
  String get cosmetic_table_navy => 'Нічний синій';

  @override
  String get cosmetic_table_burgundy => 'Королівський бордо';

  @override
  String get cosmetic_table_walnut => 'Горіх';

  @override
  String get cosmetic_table_slate => 'Сланець';

  @override
  String get cosmetic_table_contrast => 'Високий контраст';

  @override
  String get statsTotal => 'Усього';

  @override
  String get statsPlayed => 'Зіграно ігор';

  @override
  String get statsWins => 'Перемоги';

  @override
  String get statsWinRate => 'Відсоток перемог';

  @override
  String get statsTotalTime => 'Загальний час';

  @override
  String get statsBestScore => 'Найкращий рахунок';

  @override
  String get statsFastest => 'Найшвидша перемога';

  @override
  String get statsCurrentStreak => 'Поточна серія';

  @override
  String get statsBestStreak => 'Найкраща серія';

  @override
  String get statsMaxCombo => 'Макс. комбо';

  @override
  String get statsFewestMoves => 'Найменше ходів';

  @override
  String get statsDailyDone => 'Завдання дня';

  @override
  String get statsEmpty => 'Зіграйте першу гру, щоб побачити тут статистику.';

  @override
  String get statsLocalLabel => 'Зберігається на цьому пристрої';

  @override
  String durationHm(int hours, int minutes) {
    return '$hours год $minutes хв';
  }

  @override
  String achievementsProgress(int done, int total) {
    return 'Отримано $done з $total';
  }

  @override
  String earnedOn(String date) {
    return 'Отримано $date';
  }

  @override
  String rewardCoins(int coins) {
    return '+$coins';
  }

  @override
  String get shopTitle => 'Крамниця';

  @override
  String get shopCardPacks => 'Колоди';

  @override
  String get shopBackgrounds => 'Фони';

  @override
  String get shopTables => 'Столи';

  @override
  String get shopHints => 'Підказки';

  @override
  String get buy => 'Купити';

  @override
  String get owned => 'Придбано';

  @override
  String get equip => 'Обрати';

  @override
  String get equipped => 'Обрано';

  @override
  String purchaseTitle(String item) {
    return 'Купити «$item»?';
  }

  @override
  String purchaseBody(int price, int after) {
    return 'Ціна: $price монет. Баланс після покупки: $after.';
  }

  @override
  String get insufficientTitle => 'Недостатньо монет';

  @override
  String insufficientBody(int missing) {
    return 'Бракує монет: $missing. Вигравайте партії, виконуйте завдання дня й отримуйте досягнення, щоб заробити більше.';
  }

  @override
  String purchaseDone(String item) {
    return '«$item» розблоковано!';
  }

  @override
  String get hintPackTitle => 'Набір підказок';

  @override
  String hintPackBody(int count, int price) {
    return 'Підказок: $count за $price монет';
  }

  @override
  String hintsOwned(int count) {
    return 'Ваші підказки: $count';
  }

  @override
  String get coinsDisclaimer =>
      'Монети — ігрова валюта без грошової цінності. Їх не можна купити, продати, вивести чи обміняти.';

  @override
  String get settingsGameplay => 'Гра';

  @override
  String get settingsAudio => 'Звук і вібрація';

  @override
  String get settingsDisplay => 'Відображення';

  @override
  String get settingsPrivacy => 'Конфіденційність';

  @override
  String get settingsData => 'Дані та обліковий запис';

  @override
  String get settingsAbout => 'Про застосунок';

  @override
  String get music => 'Музика';

  @override
  String get sound => 'Звукові ефекти';

  @override
  String get haptics => 'Вібрація';

  @override
  String get reducedMotion => 'Менше анімації';

  @override
  String get leftHanded => 'Режим для шульги';

  @override
  String get defaultDraw => 'Режим за замовчуванням';

  @override
  String get tapToFoundation => 'Дотик спершу надсилає карту в основу';

  @override
  String get hintsSetting => 'Підказки';

  @override
  String get showTimer => 'Показувати таймер';

  @override
  String get unlimitedPasses => 'Необмежені проходи колоди';

  @override
  String get limitedPassesNote =>
      'Якщо вимкнено: «По 1» — 2 перевороти, «По 3» — 3.';

  @override
  String get foundationMoves => 'Дозволити ходи з основ';

  @override
  String get rulesNextGame => 'Зміни правил набудуть чинності з наступної гри.';

  @override
  String get language => 'Мова';

  @override
  String get languageSystem => 'Як у системі';

  @override
  String get cloudBackup => 'Резервна копія в хмарі';

  @override
  String get cloudBackupUnavailable =>
      'Хмарне резервне копіювання не налаштовано в цій збірці. Прогрес зберігається на цьому пристрої.';

  @override
  String get signIn => 'Увійти';

  @override
  String get privacyChoices => 'Конфіденційність і реклама';

  @override
  String get analyticsSetting => 'Надсилати анонімну статистику використання';

  @override
  String get personalizedAds => 'Персоналізована реклама';

  @override
  String get privacyPolicy => 'Політика конфіденційності';

  @override
  String get privacyPolicyBody =>
      'Solitaire Nova зберігає ваші ігри, статистику й покупки лише на цьому пристрої. Обліковий запис не потрібен. З вашого дозволу може використовуватися анонімна статистика й реклама (через Google AdMob); рекламні партнери можуть обробляти ідентифікатори пристрою відповідно до вашої згоди. Відкликати згоду можна будь-коли в налаштуваннях.';

  @override
  String get deleteData => 'Видалити локальні дані';

  @override
  String get deleteDataTitle => 'Видалити всі локальні дані?';

  @override
  String get deleteDataBody =>
      'Збережену гру, статистику, досягнення, монети й предмети на цьому пристрої буде видалено назавжди. Цю дію не можна скасувати.';

  @override
  String get deleteDataDone => 'Локальні дані видалено';

  @override
  String get delete => 'Видалити';

  @override
  String get restorePurchases => 'Відновити покупки';

  @override
  String get restoreNone =>
      'Немає покупок із магазину застосунків для відновлення. Предмети, куплені за монети, зберігаються на цьому пристрої.';

  @override
  String get howToPlay => 'Як грати';

  @override
  String get rulesTableau =>
      'Будуйте сім колонок за спаданням, чергуючи кольори (червона на чорну, чорна на червону). У порожню колонку можна покласти лише короля.';

  @override
  String get rulesFoundation =>
      'Перекладіть усі карти в чотири основи за мастями — від туза до короля.';

  @override
  String get rulesStock =>
      'Торкніться колоди, щоб відкрити 1 або 3 карти. Коли вона спорожніє, торкніться знову, щоб перевернути скид.';

  @override
  String get rulesControls =>
      'Торкніться карти, щоб перекласти її автоматично, або перетягніть її. Будь-який хід можна скасувати, можна взяти підказку або доручити «Авто» завершення, коли всі карти відкрито.';

  @override
  String get rulesCombo =>
      'Комбо рахує поспіль корисні ходи. Це лише для задоволення — правил вони не змінюють.';

  @override
  String get about => 'Про гру';

  @override
  String version(String version) {
    return 'Версія $version';
  }

  @override
  String get licenses => 'Ліцензії відкритого ПЗ';

  @override
  String get aboutBody =>
      'Класичний пасьянс «Косинка». Без азартних ігор і грошових призів.';

  @override
  String get consentTitle => 'Ваша конфіденційність';

  @override
  String get consentBody =>
      'Solitaire Nova повністю працює офлайн. З вашого дозволу ми показуємо рекламу, завдяки якій гра лишається безкоштовною, і збираємо анонімну статистику для її покращення. Це можна змінити будь-коли в налаштуваннях.';

  @override
  String get consentAccept => 'Прийняти';

  @override
  String get consentEssential => 'Лише необхідне';

  @override
  String get offlineTitle => 'Немає з\'єднання';

  @override
  String get offlineBody =>
      'Для цієї функції потрібен інтернет. Сама гра працює офлайн.';

  @override
  String get adUnavailableTitle => 'Реклама недоступна';

  @override
  String get adUnavailableBody =>
      'Зараз немає реклами для показу. Спробуйте пізніше.';

  @override
  String get adNotCompleted => 'Рекламу закрито до отримання нагороди.';

  @override
  String get cloudConflictTitle => 'Знайдено дві збережені гри';

  @override
  String get cloudConflictBody =>
      'І на цьому пристрої, і в хмарі є незавершена гра. Яку зберегти?';

  @override
  String get keepThisDevice => 'З цього пристрою';

  @override
  String get keepCloud => 'З хмари';

  @override
  String get errorTitle => 'Щось пішло не так';

  @override
  String get errorBody => 'Ваш прогрес у безпеці. Спробуйте ще раз.';

  @override
  String get achTitle_first_win => 'Перша перемога';

  @override
  String get achTitle_wins_10 => 'Висхідна зірка';

  @override
  String get achTitle_wins_50 => 'Знавець карт';

  @override
  String get achTitle_wins_100 => 'Майстер пасьянсу';

  @override
  String get achTitle_wins_250 => 'Гросмейстер';

  @override
  String get achTitle_wins_500 => 'Жива легенда';

  @override
  String get achTitle_played_10 => 'Перші кроки';

  @override
  String get achTitle_played_100 => 'Завсідник';

  @override
  String get achTitle_played_500 => 'Відданий гравець';

  @override
  String get achTitle_streak_3 => 'Хет-трик';

  @override
  String get achTitle_streak_5 => 'У формі';

  @override
  String get achTitle_streak_10 => 'Нестримний';

  @override
  String get achTitle_draw3_first => 'Потрійна загроза';

  @override
  String get achTitle_draw3_25 => 'Ветеран «По 3»';

  @override
  String get achTitle_no_hints => 'Власним розумом';

  @override
  String get achTitle_no_undo => 'Без жалю';

  @override
  String get achTitle_purist_10 => 'Пурист';

  @override
  String get achTitle_speed_5 => 'Спритні руки';

  @override
  String get achTitle_speed_3 => 'Стрімкий';

  @override
  String get achTitle_speed_2 => 'Блискавка';

  @override
  String get achTitle_moves_120 => 'Ефективний';

  @override
  String get achTitle_moves_100 => 'Економіст';

  @override
  String get achTitle_score_4000 => 'Рекордсмен';

  @override
  String get achTitle_score_6000 => 'Легенда рахунку';

  @override
  String get achTitle_combo_5 => 'Початок комбо';

  @override
  String get achTitle_combo_10 => 'Майстер комбо';

  @override
  String get achTitle_daily_first => 'Дебют дня';

  @override
  String get achTitle_daily_total_10 => 'Постійний гравець';

  @override
  String get achTitle_daily_total_30 => 'Вірний щоденник';

  @override
  String get achTitle_daily_streak_7 => 'Гравець дня';

  @override
  String get achTitle_winning_10 => 'Доводить до кінця';

  @override
  String get achTitle_auto_finish => 'Плавний фініш';

  @override
  String get achTitle_marathon => 'Марафон';

  @override
  String get achTitle_collector_5 => 'Колекціонер';

  @override
  String get achTitle_stylist => 'Стиліст';

  @override
  String get achTitle_level_10 => 'Досвідчений';

  @override
  String achDescWins(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Виграйте $count гри',
      many: 'Виграйте $count ігор',
      few: 'Виграйте $count гри',
      one: 'Виграйте $count гру',
    );
    return '$_temp0';
  }

  @override
  String achDescPlayed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Зіграйте $count гри',
      many: 'Зіграйте $count ігор',
      few: 'Зіграйте $count гри',
      one: 'Зіграйте $count гру',
    );
    return '$_temp0';
  }

  @override
  String achDescStreak(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Виграйте $count гри поспіль',
      many: 'Виграйте $count ігор поспіль',
      few: 'Виграйте $count гри поспіль',
      one: 'Виграйте $count гру поспіль',
    );
    return '$_temp0';
  }

  @override
  String achDescDraw3(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Виграйте $count гри «По 3»',
      many: 'Виграйте $count ігор «По 3»',
      few: 'Виграйте $count гри «По 3»',
      one: 'Виграйте $count гру «По 3»',
    );
    return '$_temp0';
  }

  @override
  String get achDescNoHints => 'Виграйте гру без підказок';

  @override
  String get achDescNoUndo => 'Виграйте гру без скасування ходів';

  @override
  String achDescPurist(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Виграйте $count гри без підказок і скасувань',
      many: 'Виграйте $count ігор без підказок і скасувань',
      few: 'Виграйте $count гри без підказок і скасувань',
      one: 'Виграйте $count гру без підказок і скасувань',
    );
    return '$_temp0';
  }

  @override
  String achDescSpeed(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Виграйте гру швидше ніж за $minutes хвилини',
      many: 'Виграйте гру швидше ніж за $minutes хвилин',
      few: 'Виграйте гру швидше ніж за $minutes хвилини',
      one: 'Виграйте гру швидше ніж за $minutes хвилину',
    );
    return '$_temp0';
  }

  @override
  String achDescMoves(int count) {
    return 'Виграйте гру не більше ніж за $count ходів';
  }

  @override
  String achDescScore(int score) {
    return 'Наберіть $score очок за одну гру';
  }

  @override
  String achDescCombo(int count) {
    return 'Досягніть комбо ${count}x';
  }

  @override
  String achDescDailyTotal(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Виконайте $count завдання дня',
      many: 'Виконайте $count завдань дня',
      few: 'Виконайте $count завдання дня',
      one: 'Виконайте $count завдання дня',
    );
    return '$_temp0';
  }

  @override
  String achDescDailyStreak(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Виконуйте завдання дня $count дня поспіль',
      many: 'Виконуйте завдання дня $count днів поспіль',
      few: 'Виконуйте завдання дня $count дні поспіль',
      one: 'Виконуйте завдання дня $count день поспіль',
    );
    return '$_temp0';
  }

  @override
  String achDescWinning(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Виграйте $count виграшної роздачі',
      many: 'Виграйте $count виграшних роздач',
      few: 'Виграйте $count виграшні роздачі',
      one: 'Виграйте $count виграшну роздачу',
    );
    return '$_temp0';
  }

  @override
  String get achDescAutoFinish => 'Завершіть гру за допомогою «Авто»';

  @override
  String achDescMarathon(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Грайте загалом $hours години',
      many: 'Грайте загалом $hours годин',
      few: 'Грайте загалом $hours години',
      one: 'Грайте загалом $hours годину',
    );
    return '$_temp0';
  }

  @override
  String achDescCollector(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Купіть $count косметичного предмета',
      many: 'Купіть $count косметичних предметів',
      few: 'Купіть $count косметичні предмети',
      one: 'Купіть $count косметичний предмет',
    );
    return '$_temp0';
  }

  @override
  String get achDescStylist => 'Застосуйте нову тему';

  @override
  String achDescLevel(int level) {
    return 'Досягніть рівня $level';
  }
}
