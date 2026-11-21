// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'Solitaire Nova';

  @override
  String splashLoading(int percent) {
    return '불러오는 중… $percent%';
  }

  @override
  String get navHome => '홈';

  @override
  String get navStats => '통계';

  @override
  String get navShop => '상점';

  @override
  String get navProfile => '프로필';

  @override
  String get gameModeSetting => '게임 모드';

  @override
  String get navSettings => '설정';

  @override
  String get back => '뒤로';

  @override
  String get ok => '확인';

  @override
  String get cancel => '취소';

  @override
  String get confirm => '확인';

  @override
  String get close => '닫기';

  @override
  String levelLabel(int level) {
    return '레벨 $level';
  }

  @override
  String coinsBalance(int coins) {
    return '코인 $coins개';
  }

  @override
  String get continueGame => '이어하기';

  @override
  String continueSubtitle(String mode, int moves, String time) {
    return '$mode · $moves수 · $time';
  }

  @override
  String get playClassic => '클래식 게임';

  @override
  String get drawOne => '1장 뽑기';

  @override
  String get drawThree => '3장 뽑기';

  @override
  String get dealRandom => '무작위 배분';

  @override
  String get dealWinning => '승리 가능 배분';

  @override
  String get dealWinningInfo =>
      '승리 가능 배분은 해법 프로그램으로 풀 수 있음이 확인된 배분입니다. 무작위 배분은 해법이 없을 수도 있습니다.';

  @override
  String get dailyChallenge => '일일 도전';

  @override
  String get achievements => '업적';

  @override
  String get themes => '테마';

  @override
  String get statistics => '통계';

  @override
  String get shop => '상점';

  @override
  String get settings => '설정';

  @override
  String get modeRandom => '무작위';

  @override
  String get modeWinning => '승리 가능';

  @override
  String get modeDaily => '일일';

  @override
  String get hudScore => '점수';

  @override
  String get hudTime => '시간';

  @override
  String get hudMoves => '이동';

  @override
  String get actionUndo => '되돌리기';

  @override
  String get actionHint => '힌트';

  @override
  String get actionAuto => '자동';

  @override
  String get actionNew => '새 게임';

  @override
  String get actionPause => '일시정지';

  @override
  String hintsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '남은 힌트 $count개',
      zero: '남은 힌트 없음',
    );
    return '$_temp0';
  }

  @override
  String semStock(int count) {
    return '덱, 카드 $count장. 탭하여 뽑기.';
  }

  @override
  String get semStockRecycle => '덱이 비었습니다. 탭하여 버린 카드를 되돌립니다.';

  @override
  String get semStockEmpty => '덱이 비었습니다';

  @override
  String get semWaste => '버린 카드';

  @override
  String semFoundation(String suit, int count) {
    return '$suit 파운데이션, 카드 $count장';
  }

  @override
  String semEmptyColumn(int column) {
    return '빈 열 $column';
  }

  @override
  String semCard(String rank, String suit) {
    return '$suit $rank';
  }

  @override
  String get semFaceDown => '뒤집힌 카드';

  @override
  String get suitClubs => '클로버';

  @override
  String get suitDiamonds => '다이아몬드';

  @override
  String get suitHearts => '하트';

  @override
  String get suitSpades => '스페이드';

  @override
  String get rankAce => '에이스';

  @override
  String get rankJack => '잭';

  @override
  String get rankQueen => '퀸';

  @override
  String get rankKing => '킹';

  @override
  String get noMovesTitle => '유효한 이동이 없습니다';

  @override
  String get noMovesBody =>
      '지금은 도움이 되는 이동이 없습니다. 되돌리거나, 이 배분을 다시 시작하거나, 새 게임을 시작할 수 있습니다.';

  @override
  String get noHintsTitle => '힌트가 없습니다';

  @override
  String get noHintsBody => '코인을 사용하거나 선택형 짧은 광고를 시청하여 힌트를 받으세요.';

  @override
  String buyHints(int count, int price) {
    return '$price로 $count개 구매';
  }

  @override
  String watchAdHints(int count) {
    return '광고 보고 $count개';
  }

  @override
  String get hintsDisabled => '설정에서 힌트가 꺼져 있습니다.';

  @override
  String get actionShuffle => '섞기';

  @override
  String get shuffleTitle => '카드를 섞을까요?';

  @override
  String shuffleBody(int left) {
    return '파운데이션에 있는 카드를 제외한 모든 카드를 섞어 다시 배분합니다. 되돌릴 수 없습니다. 이번 게임에서 남은 섞기 횟수: $left';
  }

  @override
  String get shuffleInfo => '파운데이션에 있는 카드를 제외한 모든 카드를 섞어 다시 배분합니다. 되돌릴 수 없습니다.';

  @override
  String get shufflesLeftLabel => '이번 게임에서 남은 섞기 횟수';

  @override
  String shufflePay(int price) {
    return '$price 코인 지불';
  }

  @override
  String get shuffleWatchAd => '광고 보기';

  @override
  String get shuffleLimit => '이번 게임에서는 더 이상 섞을 수 없습니다.';

  @override
  String get autoFinishing => '마무리 중…';

  @override
  String get skip => '건너뛰기';

  @override
  String get pauseTitle => '일시정지';

  @override
  String get resume => '계속하기';

  @override
  String get restartDeal => '배분 다시 시작';

  @override
  String get newGame => '새 게임';

  @override
  String get home => '홈';

  @override
  String get restartTitle => '이 배분을 다시 시작할까요?';

  @override
  String get restartBody => '이번 게임의 진행 상황이 사라집니다. 같은 배분을 처음부터 플레이합니다.';

  @override
  String get newGameTitle => '새 게임을 시작할까요?';

  @override
  String get newGameBody => '현재 게임은 패배로 기록됩니다.';

  @override
  String get victoryTitle => '승리!';

  @override
  String get finalScore => '최종 점수';

  @override
  String get timeLabel => '시간';

  @override
  String get movesLabel => '이동';

  @override
  String get maxCombo => '최대 콤보';

  @override
  String get speedBonus => '속도 보너스';

  @override
  String get timeBonus => '시간 보너스';

  @override
  String get bestScore => '최고 점수';

  @override
  String get newRecord => '신기록!';

  @override
  String coinsEarned(int coins) {
    return '+$coins';
  }

  @override
  String get doubleCoins => '코인 2배 · 광고 보기';

  @override
  String get coinsDoubled => '코인이 2배가 되었습니다!';

  @override
  String get playAgain => '새 게임';

  @override
  String get mainMenu => '메인 메뉴';

  @override
  String achievementUnlocked(String name) {
    return '업적 달성: $name';
  }

  @override
  String get dailyTitle => '일일 도전';

  @override
  String get todaysChallenge => '오늘의 도전';

  @override
  String get dailyInfo => '승리 가능 배분 · 1장 뽑기';

  @override
  String dailyReward(int coins) {
    return '보상: $coins';
  }

  @override
  String get play => '플레이';

  @override
  String playDay(String date) {
    return '$date 플레이';
  }

  @override
  String get dailyCompleted => '완료';

  @override
  String get dailyRewardClaimed => '보상 수령 완료';

  @override
  String get dailyPastNoReward => '지난 날짜는 체크 표시만 받고 코인은 받지 않습니다.';

  @override
  String dailyStreak(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days일 연속',
      zero: '진행 중인 연속 기록 없음',
    );
    return '$_temp0';
  }

  @override
  String get dailyCalendarNote => '도전은 기기의 달력 날짜를 따릅니다.';

  @override
  String get dailyFuture => '아직 열리지 않음';

  @override
  String dailyCompletedCount(int count) {
    return '$count일 완료';
  }

  @override
  String get previousMonth => '이전 달';

  @override
  String get nextMonth => '다음 달';

  @override
  String get themesBackgrounds => '배경';

  @override
  String get themesCards => '카드';

  @override
  String get themesTables => '테이블';

  @override
  String get apply => '적용';

  @override
  String get applied => '적용됨';

  @override
  String get locked => '잠김';

  @override
  String get restoreDefaults => '기본값 복원';

  @override
  String get getInShop => '상점에서 받기';

  @override
  String get themesContrastNote => '이 테이블에서 카드가 얼마나 잘 보이는지 미리 볼 수 있습니다.';

  @override
  String get cosmetic_cards_classic => '클래식';

  @override
  String get cosmetic_cards_elegant => '엘레강트';

  @override
  String get cosmetic_cards_vintage => '빈티지';

  @override
  String get cosmetic_cards_modern => '모던';

  @override
  String get cosmetic_cards_neon => '네온';

  @override
  String get cosmetic_cards_gold => '골드';

  @override
  String get cosmetic_bg_lake => '산속 호수';

  @override
  String get cosmetic_bg_autumn => '가을 오솔길';

  @override
  String get cosmetic_bg_tropic => '열대 해변';

  @override
  String get cosmetic_bg_alpine => '알프스 봉우리';

  @override
  String get cosmetic_bg_aurora => '오로라';

  @override
  String get cosmetic_bg_lavender => '라벤더 황혼';

  @override
  String get cosmetic_table_emerald => '에메랄드 펠트';

  @override
  String get cosmetic_table_navy => '미드나이트 네이비';

  @override
  String get cosmetic_table_burgundy => '로열 버건디';

  @override
  String get cosmetic_table_walnut => '월넛';

  @override
  String get cosmetic_table_slate => '슬레이트';

  @override
  String get cosmetic_table_contrast => '고대비';

  @override
  String get statsTotal => '전체';

  @override
  String get statsPlayed => '플레이한 게임';

  @override
  String get statsWins => '승리';

  @override
  String get statsWinRate => '승률';

  @override
  String get statsTotalTime => '총 플레이 시간';

  @override
  String get statsBestScore => '최고 점수';

  @override
  String get statsFastest => '최단 시간 승리';

  @override
  String get statsCurrentStreak => '현재 연승';

  @override
  String get statsBestStreak => '최고 연승';

  @override
  String get statsMaxCombo => '최대 콤보';

  @override
  String get statsFewestMoves => '최소 이동';

  @override
  String get statsDailyDone => '일일 도전';

  @override
  String get statsEmpty => '첫 게임을 플레이하면 여기에 통계가 표시됩니다.';

  @override
  String get statsLocalLabel => '이 기기에 저장됨';

  @override
  String durationHm(int hours, int minutes) {
    return '$hours시간 $minutes분';
  }

  @override
  String achievementsProgress(int done, int total) {
    return '$total개 중 $done개 달성';
  }

  @override
  String earnedOn(String date) {
    return '$date 달성';
  }

  @override
  String rewardCoins(int coins) {
    return '+$coins';
  }

  @override
  String get shopTitle => '상점';

  @override
  String get shopCardPacks => '카드 세트';

  @override
  String get shopBackgrounds => '배경';

  @override
  String get shopTables => '테이블';

  @override
  String get shopHints => '힌트';

  @override
  String watchAdCoins(int coins) {
    return '광고 보기: +$coins 코인';
  }

  @override
  String get buy => '구매';

  @override
  String get owned => '보유 중';

  @override
  String get equip => '사용';

  @override
  String get equipped => '사용 중';

  @override
  String purchaseTitle(String item) {
    return '$item을(를) 구매할까요?';
  }

  @override
  String purchaseBody(int price, int after) {
    return '가격은 $price 코인입니다. 구매 후 잔액: $after';
  }

  @override
  String get insufficientTitle => '코인이 부족합니다';

  @override
  String insufficientBody(int missing) {
    return '코인 $missing개가 더 필요합니다. 게임에서 이기고, 일일 도전을 완료하고, 업적을 달성해 코인을 모으세요.';
  }

  @override
  String purchaseDone(String item) {
    return '$item 잠금 해제!';
  }

  @override
  String get hintPackTitle => '힌트 팩';

  @override
  String hintPackBody(int count, int price) {
    return '$price 코인으로 힌트 $count개';
  }

  @override
  String hintsOwned(int count) {
    return '보유 힌트: $count개';
  }

  @override
  String get coinsDisclaimer =>
      '코인은 현금 가치가 없는 게임 내 화폐입니다. 구매, 판매, 출금, 교환할 수 없습니다.';

  @override
  String get settingsGameplay => '게임플레이';

  @override
  String get settingsAudio => '소리 및 진동';

  @override
  String get settingsDisplay => '화면';

  @override
  String get settingsPrivacy => '개인정보';

  @override
  String get settingsData => '데이터 및 계정';

  @override
  String get settingsAbout => '정보';

  @override
  String get music => '음악';

  @override
  String get sound => '효과음';

  @override
  String get haptics => '진동';

  @override
  String get reducedMotion => '동작 줄이기';

  @override
  String get leftHanded => '왼손 모드';

  @override
  String get defaultDraw => '기본 뽑기 방식';

  @override
  String get tapToFoundation => '탭하면 파운데이션으로 먼저 이동';

  @override
  String get hintsSetting => '힌트';

  @override
  String get showTimer => '타이머 표시';

  @override
  String get unlimitedPasses => '덱 무제한 순환';

  @override
  String get limitedPassesNote => '끄면: 1장 뽑기는 2회, 3장 뽑기는 3회까지 덱을 되돌릴 수 있습니다.';

  @override
  String get foundationMoves => '파운데이션에서 이동 허용';

  @override
  String get rulesNextGame => '규칙 변경은 다음 게임부터 적용됩니다.';

  @override
  String get language => '언어';

  @override
  String get languageSystem => '시스템 기본값';

  @override
  String get cloudBackup => '클라우드 백업';

  @override
  String get cloudBackupUnavailable =>
      '이 버전에서는 클라우드 백업이 설정되어 있지 않습니다. 진행 상황은 이 기기에 저장됩니다.';

  @override
  String get signIn => '로그인';

  @override
  String get privacyChoices => '개인정보 및 광고 선택';

  @override
  String get analyticsSetting => '익명 사용 통계 공유';

  @override
  String get personalizedAds => '맞춤형 광고';

  @override
  String get privacyPolicy => '개인정보 처리방침';

  @override
  String get privacyPolicyBody =>
      'Solitaire Nova는 게임, 통계, 구매 아이템을 이 기기에만 저장합니다. 계정이 필요하지 않습니다. 허용하면 익명 사용 통계와 광고(Google AdMob 사용)가 이용될 수 있으며, 광고 파트너는 사용자의 동의 선택에 따라 기기 식별자를 처리할 수 있습니다. 동의는 설정에서 언제든지 철회할 수 있습니다.';

  @override
  String get deleteData => '로컬 데이터 삭제';

  @override
  String get deleteDataTitle => '모든 로컬 데이터를 삭제할까요?';

  @override
  String get deleteDataBody =>
      '이 기기에 저장된 게임, 통계, 업적, 코인, 아이템이 영구적으로 삭제됩니다. 되돌릴 수 없습니다.';

  @override
  String get deleteDataDone => '로컬 데이터가 삭제되었습니다';

  @override
  String get delete => '삭제';

  @override
  String get restorePurchases => '구매 복원';

  @override
  String get restoreNone =>
      '복원할 스토어 구매 내역이 없습니다. 코인으로 산 아이템은 이 기기에 그대로 남아 있습니다.';

  @override
  String get howToPlay => '게임 방법';

  @override
  String get rulesTableau =>
      '일곱 개의 열에 색을 번갈아 가며 내림차순으로 카드를 쌓으세요(검은색 위에 빨간색, 빨간색 위에 검은색). 빈 열에는 킹만 놓을 수 있습니다.';

  @override
  String get rulesFoundation => '모든 카드를 무늬별로 에이스부터 킹까지 네 개의 파운데이션으로 옮기세요.';

  @override
  String get rulesStock =>
      '덱을 탭하면 카드 1장 또는 3장을 뒤집습니다. 덱이 비면 다시 탭해 버린 카드를 되돌립니다.';

  @override
  String get rulesControls =>
      '카드를 탭하면 파운데이션으로 올라가고, 원하는 열로는 드래그해서 옮깁니다. 이동을 되돌리거나 힌트를 받거나, 모든 카드가 공개되면 \'자동\'으로 게임을 끝낼 수 있습니다.';

  @override
  String get rulesCombo => '콤보는 연속으로 이어진 유효한 이동을 셉니다. 재미를 위한 것이며 규칙은 바뀌지 않습니다.';

  @override
  String get about => '정보';

  @override
  String version(String version) {
    return '버전 $version';
  }

  @override
  String get licenses => '오픈소스 라이선스';

  @override
  String get aboutBody => '클래식 클론다이크 솔리테어입니다. 도박도, 현금 상금도 없습니다.';

  @override
  String get consentTitle => '개인정보 보호';

  @override
  String get consentBody =>
      'Solitaire Nova는 완전히 오프라인으로 작동합니다. 허용하시면 게임을 무료로 유지하기 위한 광고를 표시하고, 개선을 위해 익명 사용 통계를 수집합니다. 설정에서 언제든지 변경할 수 있습니다.';

  @override
  String get consentAccept => '동의';

  @override
  String get consentEssential => '필수 항목만';

  @override
  String get offlineTitle => '오프라인 상태입니다';

  @override
  String get offlineBody => '이 기능은 인터넷 연결이 필요합니다. 게임 자체는 오프라인에서도 플레이할 수 있습니다.';

  @override
  String get adUnavailableTitle => '광고 없음';

  @override
  String get adUnavailableBody => '지금은 표시할 광고가 없습니다. 잠시 후 다시 시도하세요.';

  @override
  String get adNotCompleted => '보상을 받기 전에 광고가 닫혔습니다.';

  @override
  String get cloudConflictTitle => '저장된 게임 두 개를 찾았습니다';

  @override
  String get cloudConflictBody =>
      '이 기기와 클라우드 백업 모두에 진행 중인 게임이 있습니다. 어느 쪽을 유지할까요?';

  @override
  String get keepThisDevice => '이 기기';

  @override
  String get keepCloud => '클라우드';

  @override
  String get errorTitle => '문제가 발생했습니다';

  @override
  String get errorBody => '진행 상황은 안전합니다. 다시 시도해 주세요.';

  @override
  String get achTitle_first_win => '첫 승리';

  @override
  String get achTitle_wins_10 => '떠오르는 별';

  @override
  String get achTitle_wins_50 => '카드 고수';

  @override
  String get achTitle_wins_100 => '솔리테어 마스터';

  @override
  String get achTitle_wins_250 => '그랜드마스터';

  @override
  String get achTitle_wins_500 => '살아 있는 전설';

  @override
  String get achTitle_played_10 => '첫걸음';

  @override
  String get achTitle_played_100 => '단골';

  @override
  String get achTitle_played_500 => '열성 팬';

  @override
  String get achTitle_streak_3 => '해트트릭';

  @override
  String get achTitle_streak_5 => '절정의 기세';

  @override
  String get achTitle_streak_10 => '멈출 수 없는';

  @override
  String get achTitle_draw3_first => '트리플 위협';

  @override
  String get achTitle_draw3_25 => '3장 뽑기 베테랑';

  @override
  String get achTitle_no_hints => '자력으로';

  @override
  String get achTitle_no_undo => '후회 없음';

  @override
  String get achTitle_purist_10 => '순수주의자';

  @override
  String get achTitle_speed_5 => '날렵한 손';

  @override
  String get achTitle_speed_3 => '신속';

  @override
  String get achTitle_speed_2 => '번개';

  @override
  String get achTitle_moves_120 => '효율적';

  @override
  String get achTitle_moves_100 => '알뜰한 수';

  @override
  String get achTitle_score_4000 => '고득점';

  @override
  String get achTitle_score_6000 => '점수의 전설';

  @override
  String get achTitle_combo_5 => '콤보 시작';

  @override
  String get achTitle_combo_10 => '콤보 전문가';

  @override
  String get achTitle_daily_first => '일일 데뷔';

  @override
  String get achTitle_daily_total_10 => '일일 단골';

  @override
  String get achTitle_daily_total_30 => '일일 개근';

  @override
  String get achTitle_daily_streak_7 => '매일 플레이어';

  @override
  String get achTitle_winning_10 => '해결사';

  @override
  String get achTitle_auto_finish => '부드러운 마무리';

  @override
  String get achTitle_marathon => '마라톤';

  @override
  String get achTitle_collector_5 => '수집가';

  @override
  String get achTitle_stylist => '스타일리스트';

  @override
  String get achTitle_level_10 => '숙련자';

  @override
  String achDescWins(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count번 승리하기',
      one: '첫 게임에서 승리하기',
    );
    return '$_temp0';
  }

  @override
  String achDescPlayed(int count) {
    return '게임 $count번 플레이하기';
  }

  @override
  String achDescStreak(int count) {
    return '$count연승하기';
  }

  @override
  String achDescDraw3(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '3장 뽑기 게임에서 $count번 승리하기',
      one: '3장 뽑기 게임에서 승리하기',
    );
    return '$_temp0';
  }

  @override
  String get achDescNoHints => '힌트 없이 승리하기';

  @override
  String get achDescNoUndo => '되돌리기 없이 승리하기';

  @override
  String achDescPurist(int count) {
    return '힌트와 되돌리기 없이 $count번 승리하기';
  }

  @override
  String achDescSpeed(int minutes) {
    return '$minutes분 안에 승리하기';
  }

  @override
  String achDescMoves(int count) {
    return '$count수 이내로 승리하기';
  }

  @override
  String achDescScore(int score) {
    return '한 게임에서 $score점 얻기';
  }

  @override
  String achDescCombo(int count) {
    return '${count}x 콤보 달성하기';
  }

  @override
  String achDescDailyTotal(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '일일 도전 $count번 완료하기',
      one: '일일 도전 완료하기',
    );
    return '$_temp0';
  }

  @override
  String achDescDailyStreak(int count) {
    return '$count일 연속 일일 도전 완료하기';
  }

  @override
  String achDescWinning(int count) {
    return '승리 가능 배분에서 $count번 승리하기';
  }

  @override
  String get achDescAutoFinish => '자동으로 게임 마무리하기';

  @override
  String achDescMarathon(int hours) {
    return '총 $hours시간 플레이하기';
  }

  @override
  String achDescCollector(int count) {
    return '꾸미기 아이템 $count개 구매하기';
  }

  @override
  String get achDescStylist => '새 테마 적용하기';

  @override
  String achDescLevel(int level) {
    return '레벨 $level 달성하기';
  }
}
