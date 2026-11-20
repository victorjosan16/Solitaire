// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Solitaire Nova';

  @override
  String splashLoading(int percent) {
    return '加载中… $percent%';
  }

  @override
  String get navHome => '首页';

  @override
  String get navStats => '统计';

  @override
  String get navShop => '商店';

  @override
  String get navSettings => '设置';

  @override
  String get back => '返回';

  @override
  String get ok => '确定';

  @override
  String get cancel => '取消';

  @override
  String get confirm => '确认';

  @override
  String get close => '关闭';

  @override
  String levelLabel(int level) {
    return '等级 $level';
  }

  @override
  String coinsBalance(int coins) {
    return '$coins 金币';
  }

  @override
  String get continueGame => '继续';

  @override
  String continueSubtitle(String mode, int moves, String time) {
    return '$mode · $moves 步 · $time';
  }

  @override
  String get playClassic => '经典模式';

  @override
  String get drawOne => '翻 1 张';

  @override
  String get drawThree => '翻 3 张';

  @override
  String get dealRandom => '随机发牌';

  @override
  String get dealWinning => '必胜发牌';

  @override
  String get dealWinningInfo => '必胜发牌已经由我们的求解器验证可解。随机发牌可能无解。';

  @override
  String get dailyChallenge => '每日挑战';

  @override
  String get achievements => '成就';

  @override
  String get themes => '主题';

  @override
  String get statistics => '统计';

  @override
  String get shop => '商店';

  @override
  String get settings => '设置';

  @override
  String get modeRandom => '随机';

  @override
  String get modeWinning => '必胜';

  @override
  String get modeDaily => '每日';

  @override
  String get hudScore => '得分';

  @override
  String get hudTime => '时间';

  @override
  String get hudMoves => '步数';

  @override
  String get actionUndo => '撤销';

  @override
  String get actionHint => '提示';

  @override
  String get actionAuto => '自动';

  @override
  String get actionNew => '新局';

  @override
  String get actionPause => '暂停';

  @override
  String hintsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '剩余 $count 次提示',
      zero: '没有剩余提示',
    );
    return '$_temp0';
  }

  @override
  String semStock(int count) {
    return '牌堆，$count 张。点按翻牌。';
  }

  @override
  String get semStockRecycle => '牌堆已空。点按将弃牌翻回。';

  @override
  String get semStockEmpty => '牌堆已空';

  @override
  String get semWaste => '弃牌堆';

  @override
  String semFoundation(String suit, int count) {
    return '$suit收牌区，$count 张';
  }

  @override
  String semEmptyColumn(int column) {
    return '空列 $column';
  }

  @override
  String semCard(String rank, String suit) {
    return '$suit$rank';
  }

  @override
  String get semFaceDown => '背面朝上的牌';

  @override
  String get suitClubs => '梅花';

  @override
  String get suitDiamonds => '方块';

  @override
  String get suitHearts => '红桃';

  @override
  String get suitSpades => '黑桃';

  @override
  String get rankAce => 'A';

  @override
  String get rankJack => 'J';

  @override
  String get rankQueen => 'Q';

  @override
  String get rankKing => 'K';

  @override
  String get noMovesTitle => '没有可用的有效步';

  @override
  String get noMovesBody => '目前没有有效的移动。你可以撤销、重新开始本局或开始新的一局。';

  @override
  String get noHintsTitle => '提示已用完';

  @override
  String get noHintsBody => '可以用金币或观看一段可选的短广告来获得更多提示。';

  @override
  String buyHints(int count, int price) {
    return '$price 购买 $count 次';
  }

  @override
  String watchAdHints(int count) {
    return '看广告得 $count 次';
  }

  @override
  String get hintsDisabled => '提示已在设置中关闭。';

  @override
  String get autoFinishing => '正在完成…';

  @override
  String get skip => '跳过';

  @override
  String get pauseTitle => '已暂停';

  @override
  String get resume => '继续';

  @override
  String get restartDeal => '重新开始本局';

  @override
  String get newGame => '新游戏';

  @override
  String get home => '首页';

  @override
  String get restartTitle => '重新开始本局？';

  @override
  String get restartBody => '本局进度将丢失。你将从头开始玩同一副牌。';

  @override
  String get newGameTitle => '开始新游戏？';

  @override
  String get newGameBody => '当前游戏将记为失败。';

  @override
  String get victoryTitle => '胜利！';

  @override
  String get finalScore => '最终得分';

  @override
  String get timeLabel => '时间';

  @override
  String get movesLabel => '步数';

  @override
  String get maxCombo => '最高连击';

  @override
  String get timeBonus => '时间奖励';

  @override
  String get bestScore => '最高分';

  @override
  String get newRecord => '新纪录！';

  @override
  String coinsEarned(int coins) {
    return '+$coins';
  }

  @override
  String get doubleCoins => '金币翻倍 · 看广告';

  @override
  String get coinsDoubled => '金币已翻倍！';

  @override
  String get playAgain => '新游戏';

  @override
  String get mainMenu => '主菜单';

  @override
  String achievementUnlocked(String name) {
    return '解锁成就：$name';
  }

  @override
  String get dailyTitle => '每日挑战';

  @override
  String get todaysChallenge => '今日挑战';

  @override
  String get dailyInfo => '必胜发牌 · 翻 1 张';

  @override
  String dailyReward(int coins) {
    return '奖励：$coins';
  }

  @override
  String get play => '开始';

  @override
  String playDay(String date) {
    return '玩 $date';
  }

  @override
  String get dailyCompleted => '已完成';

  @override
  String get dailyRewardClaimed => '已领取奖励';

  @override
  String get dailyPastNoReward => '往日挑战只会获得勾选标记，不会获得金币。';

  @override
  String dailyStreak(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '连续 $days 天',
      zero: '暂无连续记录',
    );
    return '$_temp0';
  }

  @override
  String get dailyCalendarNote => '挑战以设备日历上的日期为准。';

  @override
  String get dailyFuture => '尚未开放';

  @override
  String dailyCompletedCount(int count) {
    return '已完成 $count 天';
  }

  @override
  String get previousMonth => '上个月';

  @override
  String get nextMonth => '下个月';

  @override
  String get themesBackgrounds => '背景';

  @override
  String get themesCards => '卡牌';

  @override
  String get themesTables => '牌桌';

  @override
  String get apply => '应用';

  @override
  String get applied => '已应用';

  @override
  String get locked => '未解锁';

  @override
  String get restoreDefaults => '恢复默认';

  @override
  String get getInShop => '去商店获取';

  @override
  String get themesContrastNote => '预览显示卡牌在此牌桌上的清晰度。';

  @override
  String get cosmetic_cards_classic => '经典';

  @override
  String get cosmetic_cards_elegant => '典雅';

  @override
  String get cosmetic_cards_vintage => '复古';

  @override
  String get cosmetic_cards_modern => '现代';

  @override
  String get cosmetic_cards_neon => '霓虹';

  @override
  String get cosmetic_cards_gold => '金色';

  @override
  String get cosmetic_bg_lake => '高山湖泊';

  @override
  String get cosmetic_bg_autumn => '秋日小径';

  @override
  String get cosmetic_bg_tropic => '热带海湾';

  @override
  String get cosmetic_bg_alpine => '阿尔卑斯山峰';

  @override
  String get cosmetic_bg_aurora => '北极光';

  @override
  String get cosmetic_bg_lavender => '薰衣草暮色';

  @override
  String get cosmetic_table_emerald => '翡翠绒布';

  @override
  String get cosmetic_table_navy => '午夜蓝';

  @override
  String get cosmetic_table_burgundy => '皇家酒红';

  @override
  String get cosmetic_table_walnut => '胡桃木';

  @override
  String get cosmetic_table_slate => '石板';

  @override
  String get cosmetic_table_contrast => '高对比度';

  @override
  String get statsTotal => '总计';

  @override
  String get statsPlayed => '已玩局数';

  @override
  String get statsWins => '胜局';

  @override
  String get statsWinRate => '胜率';

  @override
  String get statsTotalTime => '总时长';

  @override
  String get statsBestScore => '最高分';

  @override
  String get statsFastest => '最快胜利';

  @override
  String get statsCurrentStreak => '当前连胜';

  @override
  String get statsBestStreak => '最长连胜';

  @override
  String get statsMaxCombo => '最高连击';

  @override
  String get statsFewestMoves => '最少步数';

  @override
  String get statsDailyDone => '每日挑战';

  @override
  String get statsEmpty => '玩第一局后即可在这里查看统计数据。';

  @override
  String get statsLocalLabel => '保存在此设备上';

  @override
  String durationHm(int hours, int minutes) {
    return '$hours 小时 $minutes 分';
  }

  @override
  String achievementsProgress(int done, int total) {
    return '已解锁 $done/$total';
  }

  @override
  String earnedOn(String date) {
    return '$date 获得';
  }

  @override
  String rewardCoins(int coins) {
    return '+$coins';
  }

  @override
  String get shopTitle => '商店';

  @override
  String get shopCardPacks => '卡牌套装';

  @override
  String get shopBackgrounds => '背景';

  @override
  String get shopTables => '牌桌';

  @override
  String get shopHints => '提示';

  @override
  String get buy => '购买';

  @override
  String get owned => '已拥有';

  @override
  String get equip => '使用';

  @override
  String get equipped => '使用中';

  @override
  String purchaseTitle(String item) {
    return '购买「$item」？';
  }

  @override
  String purchaseBody(int price, int after) {
    return '价格为 $price 金币。购买后余额：$after。';
  }

  @override
  String get insufficientTitle => '金币不足';

  @override
  String insufficientBody(int missing) {
    return '还需要 $missing 金币。赢得对局、完成每日挑战和解锁成就都能获得更多金币。';
  }

  @override
  String purchaseDone(String item) {
    return '已解锁「$item」！';
  }

  @override
  String get hintPackTitle => '提示包';

  @override
  String hintPackBody(int count, int price) {
    return '$price 金币购买 $count 次提示';
  }

  @override
  String hintsOwned(int count) {
    return '你有 $count 次提示';
  }

  @override
  String get coinsDisclaimer => '金币是游戏内货币，没有现金价值，不能购买、出售、提现或兑换。';

  @override
  String get settingsGameplay => '玩法';

  @override
  String get settingsAudio => '声音与振动';

  @override
  String get settingsDisplay => '显示';

  @override
  String get settingsPrivacy => '隐私';

  @override
  String get settingsData => '数据与账户';

  @override
  String get settingsAbout => '关于';

  @override
  String get music => '音乐';

  @override
  String get sound => '音效';

  @override
  String get haptics => '振动';

  @override
  String get reducedMotion => '减少动画';

  @override
  String get leftHanded => '左手模式';

  @override
  String get defaultDraw => '默认翻牌模式';

  @override
  String get tapToFoundation => '点按时优先移到收牌区';

  @override
  String get hintsSetting => '提示';

  @override
  String get showTimer => '显示计时器';

  @override
  String get unlimitedPasses => '牌堆不限轮数';

  @override
  String get limitedPassesNote => '关闭时：翻 1 张可回收 2 次，翻 3 张可回收 3 次。';

  @override
  String get foundationMoves => '允许从收牌区移回';

  @override
  String get rulesNextGame => '规则更改将从下一局开始生效。';

  @override
  String get language => '语言';

  @override
  String get languageSystem => '跟随系统';

  @override
  String get cloudBackup => '云备份';

  @override
  String get cloudBackupUnavailable => '此版本未配置云备份。你的进度保存在此设备上。';

  @override
  String get signIn => '登录';

  @override
  String get privacyChoices => '隐私与广告选项';

  @override
  String get analyticsSetting => '分享匿名使用统计';

  @override
  String get personalizedAds => '个性化广告';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get privacyPolicyBody =>
      'Solitaire Nova 只会将你的对局、统计数据和已购物品保存在此设备上，无需账户。如果你允许，我们可能会使用匿名使用统计和广告（通过 Google AdMob）；广告合作伙伴可能会根据你的同意选择处理设备标识符。你可以随时在设置中撤回同意。';

  @override
  String get deleteData => '删除本地数据';

  @override
  String get deleteDataTitle => '删除所有本地数据？';

  @override
  String get deleteDataBody => '这将永久删除此设备上已保存的对局、统计、成就、金币和物品，且无法撤销。';

  @override
  String get deleteDataDone => '本地数据已删除';

  @override
  String get delete => '删除';

  @override
  String get restorePurchases => '恢复购买';

  @override
  String get restoreNone => '没有可恢复的商店购买记录。用金币购买的物品会保留在此设备上。';

  @override
  String get howToPlay => '玩法说明';

  @override
  String get rulesTableau =>
      '在七列中按从大到小的顺序、红黑交替叠放卡牌（黑牌上放红牌，红牌上放黑牌）。只有 K 可以放进空列。';

  @override
  String get rulesFoundation => '将所有卡牌按花色从 A 到 K 移到四个收牌区。';

  @override
  String get rulesStock => '点按牌堆翻开 1 张或 3 张牌。牌堆用完后再次点按即可将弃牌翻回。';

  @override
  String get rulesControls =>
      '点按卡牌可自动移动，也可以拖动。任何一步都能撤销，也可以使用提示；所有牌翻开后可以让「自动」完成游戏。';

  @override
  String get rulesCombo => '连击统计连续的有效步数，仅为增添乐趣，不会改变规则。';

  @override
  String get about => '关于';

  @override
  String version(String version) {
    return '版本 $version';
  }

  @override
  String get licenses => '开源许可';

  @override
  String get aboutBody => '经典克朗代克纸牌游戏。无赌博，无现金奖励。';

  @override
  String get consentTitle => '你的隐私';

  @override
  String get consentBody =>
      'Solitaire Nova 可完全离线游玩。经你允许，我们会展示广告以保持游戏免费，并收集匿名使用统计来改进游戏。你可以随时在设置中更改。';

  @override
  String get consentAccept => '同意';

  @override
  String get consentEssential => '仅必要项';

  @override
  String get offlineTitle => '你当前处于离线状态';

  @override
  String get offlineBody => '此功能需要联网。游戏本身可以离线游玩。';

  @override
  String get adUnavailableTitle => '暂无广告';

  @override
  String get adUnavailableBody => '目前没有可播放的广告，请稍后再试。';

  @override
  String get adNotCompleted => '广告在获得奖励前被关闭。';

  @override
  String get cloudConflictTitle => '发现两个存档';

  @override
  String get cloudConflictBody => '此设备和云备份中都有进行中的对局。你想保留哪一个？';

  @override
  String get keepThisDevice => '此设备';

  @override
  String get keepCloud => '云端';

  @override
  String get errorTitle => '出现问题';

  @override
  String get errorBody => '你的进度是安全的，请重试。';

  @override
  String get achTitle_first_win => '首胜';

  @override
  String get achTitle_wins_10 => '新星崛起';

  @override
  String get achTitle_wins_50 => '牌技高手';

  @override
  String get achTitle_wins_100 => '纸牌大师';

  @override
  String get achTitle_wins_250 => '特级大师';

  @override
  String get achTitle_wins_500 => '活着的传奇';

  @override
  String get achTitle_played_10 => '初来乍到';

  @override
  String get achTitle_played_100 => '常客';

  @override
  String get achTitle_played_500 => '忠实玩家';

  @override
  String get achTitle_streak_3 => '帽子戏法';

  @override
  String get achTitle_streak_5 => '状态火热';

  @override
  String get achTitle_streak_10 => '势不可挡';

  @override
  String get achTitle_draw3_first => '三重威胁';

  @override
  String get achTitle_draw3_25 => '翻三张老手';

  @override
  String get achTitle_no_hints => '自力更生';

  @override
  String get achTitle_no_undo => '落子无悔';

  @override
  String get achTitle_purist_10 => '纯粹主义者';

  @override
  String get achTitle_speed_5 => '手疾眼快';

  @override
  String get achTitle_speed_3 => '迅捷';

  @override
  String get achTitle_speed_2 => '闪电';

  @override
  String get achTitle_moves_120 => '高效';

  @override
  String get achTitle_moves_100 => '精打细算';

  @override
  String get achTitle_score_4000 => '高分达人';

  @override
  String get achTitle_score_6000 => '分数传奇';

  @override
  String get achTitle_combo_5 => '连击入门';

  @override
  String get achTitle_combo_10 => '连击专家';

  @override
  String get achTitle_daily_first => '每日首秀';

  @override
  String get achTitle_daily_total_10 => '每日常客';

  @override
  String get achTitle_daily_total_30 => '每日坚持';

  @override
  String get achTitle_daily_streak_7 => '每日玩家';

  @override
  String get achTitle_winning_10 => '终结者';

  @override
  String get achTitle_auto_finish => '顺利收官';

  @override
  String get achTitle_marathon => '马拉松';

  @override
  String get achTitle_collector_5 => '收藏家';

  @override
  String get achTitle_stylist => '造型师';

  @override
  String get achTitle_level_10 => '经验丰富';

  @override
  String achDescWins(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '赢得 $count 局',
      one: '赢得第一局',
    );
    return '$_temp0';
  }

  @override
  String achDescPlayed(int count) {
    return '玩 $count 局';
  }

  @override
  String achDescStreak(int count) {
    return '连胜 $count 局';
  }

  @override
  String achDescDraw3(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '赢得 $count 局翻 3 张',
      one: '赢得一局翻 3 张',
    );
    return '$_temp0';
  }

  @override
  String get achDescNoHints => '不使用提示赢得一局';

  @override
  String get achDescNoUndo => '不使用撤销赢得一局';

  @override
  String achDescPurist(int count) {
    return '不用提示和撤销赢得 $count 局';
  }

  @override
  String achDescSpeed(int minutes) {
    return '在 $minutes 分钟内赢得一局';
  }

  @override
  String achDescMoves(int count) {
    return '在 $count 步以内赢得一局';
  }

  @override
  String achDescScore(int score) {
    return '单局获得 $score 分';
  }

  @override
  String achDescCombo(int count) {
    return '达成 ${count}x 连击';
  }

  @override
  String achDescDailyTotal(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '完成 $count 次每日挑战',
      one: '完成一次每日挑战',
    );
    return '$_temp0';
  }

  @override
  String achDescDailyStreak(int count) {
    return '连续 $count 天完成每日挑战';
  }

  @override
  String achDescWinning(int count) {
    return '赢得 $count 局必胜发牌';
  }

  @override
  String get achDescAutoFinish => '使用「自动」完成一局';

  @override
  String achDescMarathon(int hours) {
    return '累计游玩 $hours 小时';
  }

  @override
  String achDescCollector(int count) {
    return '购买 $count 件装饰物品';
  }

  @override
  String get achDescStylist => '应用一个新主题';

  @override
  String achDescLevel(int level) {
    return '达到等级 $level';
  }
}
