// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Solitaire Nova';

  @override
  String splashLoading(int percent) {
    return 'Đang tải… $percent%';
  }

  @override
  String get navHome => 'Trang chủ';

  @override
  String get navStats => 'Thống kê';

  @override
  String get navShop => 'Cửa hàng';

  @override
  String get navSettings => 'Cài đặt';

  @override
  String get back => 'Quay lại';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Hủy';

  @override
  String get confirm => 'Xác nhận';

  @override
  String get close => 'Đóng';

  @override
  String levelLabel(int level) {
    return 'Cấp $level';
  }

  @override
  String coinsBalance(int coins) {
    return '$coins xu';
  }

  @override
  String get continueGame => 'Tiếp tục';

  @override
  String continueSubtitle(String mode, int moves, String time) {
    return '$mode · $moves nước · $time';
  }

  @override
  String get playClassic => 'Chơi cổ điển';

  @override
  String get drawOne => 'Rút 1';

  @override
  String get drawThree => 'Rút 3';

  @override
  String get dealRandom => 'Ván ngẫu nhiên';

  @override
  String get dealWinning => 'Ván có thể thắng';

  @override
  String get dealWinningInfo =>
      'Các ván có thể thắng đã được bộ giải của chúng tôi xác minh là có lời giải. Ván ngẫu nhiên có thể không có lời giải.';

  @override
  String get dailyChallenge => 'Thử thách hằng ngày';

  @override
  String get achievements => 'Thành tích';

  @override
  String get themes => 'Giao diện';

  @override
  String get statistics => 'Thống kê';

  @override
  String get shop => 'Cửa hàng';

  @override
  String get settings => 'Cài đặt';

  @override
  String get modeRandom => 'Ngẫu nhiên';

  @override
  String get modeWinning => 'Có thể thắng';

  @override
  String get modeDaily => 'Hằng ngày';

  @override
  String get hudScore => 'Điểm';

  @override
  String get hudTime => 'Thời gian';

  @override
  String get hudMoves => 'Nước đi';

  @override
  String get actionUndo => 'Hoàn tác';

  @override
  String get actionHint => 'Gợi ý';

  @override
  String get actionAuto => 'Tự động';

  @override
  String get actionNew => 'Mới';

  @override
  String get actionPause => 'Tạm dừng';

  @override
  String hintsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Còn $count gợi ý',
      zero: 'Đã hết gợi ý',
    );
    return '$_temp0';
  }

  @override
  String semStock(int count) {
    return 'Chồng bài, $count lá. Chạm để rút.';
  }

  @override
  String get semStockRecycle => 'Chồng bài trống. Chạm để lật lại bài đã rút.';

  @override
  String get semStockEmpty => 'Chồng bài trống';

  @override
  String get semWaste => 'Bài đã rút';

  @override
  String semFoundation(String suit, int count) {
    return 'Chồng đích $suit, $count lá';
  }

  @override
  String semEmptyColumn(int column) {
    return 'Cột trống $column';
  }

  @override
  String semCard(String rank, String suit) {
    return '$rank $suit';
  }

  @override
  String get semFaceDown => 'Lá bài úp';

  @override
  String get suitClubs => 'Nhép';

  @override
  String get suitDiamonds => 'Rô';

  @override
  String get suitHearts => 'Cơ';

  @override
  String get suitSpades => 'Bích';

  @override
  String get rankAce => 'Át';

  @override
  String get rankJack => 'J';

  @override
  String get rankQueen => 'Q';

  @override
  String get rankKing => 'K';

  @override
  String get noMovesTitle => 'Không còn nước đi hữu ích';

  @override
  String get noMovesBody =>
      'Hiện không có nước đi hiệu quả nào. Bạn có thể hoàn tác, chơi lại ván này hoặc bắt đầu ván mới.';

  @override
  String get noHintsTitle => 'Hết gợi ý';

  @override
  String get noHintsBody =>
      'Nhận thêm gợi ý bằng xu hoặc xem một quảng cáo ngắn tùy chọn.';

  @override
  String buyHints(int count, int price) {
    return 'Mua $count với $price';
  }

  @override
  String watchAdHints(int count) {
    return 'Quảng cáo đổi $count';
  }

  @override
  String get hintsDisabled => 'Gợi ý đang tắt trong Cài đặt.';

  @override
  String get autoFinishing => 'Đang hoàn thành…';

  @override
  String get skip => 'Bỏ qua';

  @override
  String get pauseTitle => 'Tạm dừng';

  @override
  String get resume => 'Tiếp tục';

  @override
  String get restartDeal => 'Chơi lại ván này';

  @override
  String get newGame => 'Ván mới';

  @override
  String get home => 'Trang chủ';

  @override
  String get restartTitle => 'Chơi lại ván này?';

  @override
  String get restartBody =>
      'Tiến độ của ván này sẽ mất. Bạn sẽ chơi lại cùng một ván từ đầu.';

  @override
  String get newGameTitle => 'Bắt đầu ván mới?';

  @override
  String get newGameBody => 'Ván hiện tại sẽ được tính là thua.';

  @override
  String get victoryTitle => 'Chiến thắng!';

  @override
  String get finalScore => 'Điểm cuối';

  @override
  String get timeLabel => 'Thời gian';

  @override
  String get movesLabel => 'Nước đi';

  @override
  String get maxCombo => 'Combo cao nhất';

  @override
  String get speedBonus => 'Thưởng tốc độ';

  @override
  String get timeBonus => 'Thưởng thời gian';

  @override
  String get bestScore => 'Điểm cao nhất';

  @override
  String get newRecord => 'Kỷ lục mới!';

  @override
  String coinsEarned(int coins) {
    return '+$coins';
  }

  @override
  String get doubleCoins => 'Nhân đôi xu · quảng cáo';

  @override
  String get coinsDoubled => 'Đã nhân đôi xu!';

  @override
  String get playAgain => 'Ván mới';

  @override
  String get mainMenu => 'Menu chính';

  @override
  String achievementUnlocked(String name) {
    return 'Mở khóa thành tích: $name';
  }

  @override
  String get dailyTitle => 'Thử thách hằng ngày';

  @override
  String get todaysChallenge => 'Thử thách hôm nay';

  @override
  String get dailyInfo => 'Ván có thể thắng · Rút 1';

  @override
  String dailyReward(int coins) {
    return 'Phần thưởng: $coins';
  }

  @override
  String get play => 'Chơi';

  @override
  String playDay(String date) {
    return 'Chơi $date';
  }

  @override
  String get dailyCompleted => 'Đã hoàn thành';

  @override
  String get dailyRewardClaimed => 'Đã nhận thưởng';

  @override
  String get dailyPastNoReward =>
      'Những ngày đã qua chỉ nhận dấu tích, không có xu.';

  @override
  String dailyStreak(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Chuỗi $days ngày',
      zero: 'Chưa có chuỗi ngày',
    );
    return '$_temp0';
  }

  @override
  String get dailyCalendarNote => 'Thử thách theo ngày trên lịch của thiết bị.';

  @override
  String get dailyFuture => 'Chưa mở';

  @override
  String dailyCompletedCount(int count) {
    return 'Đã hoàn thành $count';
  }

  @override
  String get previousMonth => 'Tháng trước';

  @override
  String get nextMonth => 'Tháng sau';

  @override
  String get themesBackgrounds => 'Hình nền';

  @override
  String get themesCards => 'Bộ bài';

  @override
  String get themesTables => 'Mặt bàn';

  @override
  String get apply => 'Áp dụng';

  @override
  String get applied => 'Đã áp dụng';

  @override
  String get locked => 'Đã khóa';

  @override
  String get restoreDefaults => 'Khôi phục mặc định';

  @override
  String get getInShop => 'Mua trong cửa hàng';

  @override
  String get themesContrastNote =>
      'Bản xem trước cho thấy độ dễ đọc của lá bài trên mặt bàn này.';

  @override
  String get cosmetic_cards_classic => 'Cổ điển';

  @override
  String get cosmetic_cards_elegant => 'Thanh lịch';

  @override
  String get cosmetic_cards_vintage => 'Hoài cổ';

  @override
  String get cosmetic_cards_modern => 'Hiện đại';

  @override
  String get cosmetic_cards_neon => 'Neon';

  @override
  String get cosmetic_cards_gold => 'Vàng';

  @override
  String get cosmetic_bg_lake => 'Hồ trên núi';

  @override
  String get cosmetic_bg_autumn => 'Lối mùa thu';

  @override
  String get cosmetic_bg_tropic => 'Vịnh nhiệt đới';

  @override
  String get cosmetic_bg_alpine => 'Đỉnh núi Alps';

  @override
  String get cosmetic_bg_aurora => 'Cực quang';

  @override
  String get cosmetic_bg_lavender => 'Hoàng hôn oải hương';

  @override
  String get cosmetic_table_emerald => 'Nỉ ngọc lục bảo';

  @override
  String get cosmetic_table_navy => 'Xanh nửa đêm';

  @override
  String get cosmetic_table_burgundy => 'Đỏ rượu vang';

  @override
  String get cosmetic_table_walnut => 'Gỗ óc chó';

  @override
  String get cosmetic_table_slate => 'Đá phiến';

  @override
  String get cosmetic_table_contrast => 'Tương phản cao';

  @override
  String get statsTotal => 'Tổng';

  @override
  String get statsPlayed => 'Số ván đã chơi';

  @override
  String get statsWins => 'Thắng';

  @override
  String get statsWinRate => 'Tỷ lệ thắng';

  @override
  String get statsTotalTime => 'Tổng thời gian';

  @override
  String get statsBestScore => 'Điểm cao nhất';

  @override
  String get statsFastest => 'Thắng nhanh nhất';

  @override
  String get statsCurrentStreak => 'Chuỗi hiện tại';

  @override
  String get statsBestStreak => 'Chuỗi dài nhất';

  @override
  String get statsMaxCombo => 'Combo cao nhất';

  @override
  String get statsFewestMoves => 'Ít nước đi nhất';

  @override
  String get statsDailyDone => 'Thử thách hằng ngày';

  @override
  String get statsEmpty => 'Chơi ván đầu tiên để xem thống kê tại đây.';

  @override
  String get statsLocalLabel => 'Lưu trên thiết bị này';

  @override
  String durationHm(int hours, int minutes) {
    return '$hours giờ $minutes phút';
  }

  @override
  String achievementsProgress(int done, int total) {
    return 'Đã mở $done/$total';
  }

  @override
  String earnedOn(String date) {
    return 'Đạt được ngày $date';
  }

  @override
  String rewardCoins(int coins) {
    return '+$coins';
  }

  @override
  String get shopTitle => 'Cửa hàng';

  @override
  String get shopCardPacks => 'Bộ bài';

  @override
  String get shopBackgrounds => 'Hình nền';

  @override
  String get shopTables => 'Mặt bàn';

  @override
  String get shopHints => 'Gợi ý';

  @override
  String get buy => 'Mua';

  @override
  String get owned => 'Đã sở hữu';

  @override
  String get equip => 'Dùng';

  @override
  String get equipped => 'Đang dùng';

  @override
  String purchaseTitle(String item) {
    return 'Mua $item?';
  }

  @override
  String purchaseBody(int price, int after) {
    return 'Giá $price xu. Số dư sau khi mua: $after.';
  }

  @override
  String get insufficientTitle => 'Không đủ xu';

  @override
  String insufficientBody(int missing) {
    return 'Bạn cần thêm $missing xu. Hãy thắng ván, hoàn thành thử thách hằng ngày và mở khóa thành tích để kiếm thêm.';
  }

  @override
  String purchaseDone(String item) {
    return 'Đã mở khóa $item!';
  }

  @override
  String get hintPackTitle => 'Gói gợi ý';

  @override
  String hintPackBody(int count, int price) {
    return '$count gợi ý với $price xu';
  }

  @override
  String hintsOwned(int count) {
    return 'Bạn có $count gợi ý';
  }

  @override
  String get coinsDisclaimer =>
      'Xu là tiền trong trò chơi, không có giá trị quy đổi thành tiền. Xu không thể mua, bán, rút hay trao đổi.';

  @override
  String get settingsGameplay => 'Lối chơi';

  @override
  String get settingsAudio => 'Âm thanh & rung';

  @override
  String get settingsDisplay => 'Hiển thị';

  @override
  String get settingsPrivacy => 'Quyền riêng tư';

  @override
  String get settingsData => 'Dữ liệu & tài khoản';

  @override
  String get settingsAbout => 'Giới thiệu';

  @override
  String get music => 'Nhạc nền';

  @override
  String get sound => 'Hiệu ứng âm thanh';

  @override
  String get haptics => 'Rung';

  @override
  String get reducedMotion => 'Giảm chuyển động';

  @override
  String get leftHanded => 'Chế độ tay trái';

  @override
  String get defaultDraw => 'Chế độ rút mặc định';

  @override
  String get tapToFoundation => 'Chạm sẽ đưa bài lên chồng đích trước';

  @override
  String get hintsSetting => 'Gợi ý';

  @override
  String get showTimer => 'Hiện đồng hồ';

  @override
  String get unlimitedPasses => 'Lật chồng bài không giới hạn';

  @override
  String get limitedPassesNote =>
      'Khi tắt: Rút 1 cho lật lại 2 lần, Rút 3 cho 3 lần.';

  @override
  String get foundationMoves => 'Cho phép đi bài từ chồng đích';

  @override
  String get rulesNextGame => 'Thay đổi luật sẽ áp dụng từ ván tiếp theo.';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get languageSystem => 'Theo hệ thống';

  @override
  String get cloudBackup => 'Sao lưu đám mây';

  @override
  String get cloudBackupUnavailable =>
      'Phiên bản này chưa cấu hình sao lưu đám mây. Tiến độ của bạn được lưu trên thiết bị này.';

  @override
  String get signIn => 'Đăng nhập';

  @override
  String get privacyChoices => 'Quyền riêng tư & quảng cáo';

  @override
  String get analyticsSetting => 'Chia sẻ thống kê sử dụng ẩn danh';

  @override
  String get personalizedAds => 'Quảng cáo cá nhân hóa';

  @override
  String get privacyPolicy => 'Chính sách quyền riêng tư';

  @override
  String get privacyPolicyBody =>
      'Solitaire Nova chỉ lưu ván chơi, thống kê và vật phẩm của bạn trên thiết bị này. Không cần tài khoản. Nếu bạn đồng ý, thống kê sử dụng ẩn danh và quảng cáo (qua Google AdMob) có thể được dùng; đối tác quảng cáo có thể xử lý mã định danh thiết bị theo lựa chọn đồng ý của bạn. Bạn có thể rút lại sự đồng ý bất cứ lúc nào trong Cài đặt.';

  @override
  String get deleteData => 'Xóa dữ liệu cục bộ';

  @override
  String get deleteDataTitle => 'Xóa toàn bộ dữ liệu cục bộ?';

  @override
  String get deleteDataBody =>
      'Thao tác này xóa vĩnh viễn ván đã lưu, thống kê, thành tích, xu và vật phẩm trên thiết bị này. Không thể hoàn tác.';

  @override
  String get deleteDataDone => 'Đã xóa dữ liệu cục bộ';

  @override
  String get delete => 'Xóa';

  @override
  String get restorePurchases => 'Khôi phục giao dịch';

  @override
  String get restoreNone =>
      'Không có giao dịch cửa hàng nào để khôi phục. Vật phẩm mua bằng xu vẫn nằm trên thiết bị này.';

  @override
  String get howToPlay => 'Cách chơi';

  @override
  String get rulesTableau =>
      'Xếp bảy cột theo thứ tự giảm dần, xen kẽ màu (đỏ trên đen, đen trên đỏ). Chỉ lá K mới được đặt vào cột trống.';

  @override
  String get rulesFoundation =>
      'Đưa tất cả lá bài lên bốn chồng đích theo chất, từ Át đến K.';

  @override
  String get rulesStock =>
      'Chạm chồng bài để lật 1 hoặc 3 lá. Khi hết, chạm lại để lật lại bài đã rút.';

  @override
  String get rulesControls =>
      'Chạm vào lá bài để tự động di chuyển hoặc kéo thả. Bạn có thể hoàn tác mọi nước, xin gợi ý, hoặc để Tự động hoàn thành ván khi mọi lá đã lật.';

  @override
  String get rulesCombo =>
      'Combo đếm các nước đi hiệu quả liên tiếp. Chỉ để vui và không thay đổi luật chơi.';

  @override
  String get about => 'Giới thiệu';

  @override
  String version(String version) {
    return 'Phiên bản $version';
  }

  @override
  String get licenses => 'Giấy phép mã nguồn mở';

  @override
  String get aboutBody =>
      'Trò chơi Solitaire Klondike cổ điển. Không cờ bạc, không giải thưởng tiền mặt.';

  @override
  String get consentTitle => 'Quyền riêng tư của bạn';

  @override
  String get consentBody =>
      'Solitaire Nova hoạt động hoàn toàn ngoại tuyến. Khi bạn cho phép, chúng tôi hiển thị quảng cáo để trò chơi luôn miễn phí và thu thập thống kê sử dụng ẩn danh để cải thiện. Bạn có thể thay đổi bất cứ lúc nào trong Cài đặt.';

  @override
  String get consentAccept => 'Đồng ý';

  @override
  String get consentEssential => 'Chỉ thiết yếu';

  @override
  String get offlineTitle => 'Bạn đang ngoại tuyến';

  @override
  String get offlineBody =>
      'Tính năng này cần kết nối Internet. Bản thân trò chơi vẫn chơi được ngoại tuyến.';

  @override
  String get adUnavailableTitle => 'Không có quảng cáo';

  @override
  String get adUnavailableBody =>
      'Hiện không có quảng cáo để hiển thị. Vui lòng thử lại sau.';

  @override
  String get adNotCompleted => 'Quảng cáo đã bị đóng trước khi nhận thưởng.';

  @override
  String get cloudConflictTitle => 'Tìm thấy hai ván đã lưu';

  @override
  String get cloudConflictBody =>
      'Cả thiết bị này và bản sao lưu đám mây đều có ván đang chơi dở. Bạn muốn giữ ván nào?';

  @override
  String get keepThisDevice => 'Thiết bị này';

  @override
  String get keepCloud => 'Đám mây';

  @override
  String get errorTitle => 'Đã xảy ra lỗi';

  @override
  String get errorBody => 'Tiến độ của bạn vẫn an toàn. Vui lòng thử lại.';

  @override
  String get achTitle_first_win => 'Chiến thắng đầu tiên';

  @override
  String get achTitle_wins_10 => 'Ngôi sao đang lên';

  @override
  String get achTitle_wins_50 => 'Tay bài cừ';

  @override
  String get achTitle_wins_100 => 'Bậc thầy Solitaire';

  @override
  String get achTitle_wins_250 => 'Đại kiện tướng';

  @override
  String get achTitle_wins_500 => 'Huyền thoại sống';

  @override
  String get achTitle_played_10 => 'Những bước đầu';

  @override
  String get achTitle_played_100 => 'Khách quen';

  @override
  String get achTitle_played_500 => 'Người đam mê';

  @override
  String get achTitle_streak_3 => 'Hat-trick';

  @override
  String get achTitle_streak_5 => 'Phong độ cao';

  @override
  String get achTitle_streak_10 => 'Không thể cản';

  @override
  String get achTitle_draw3_first => 'Mối đe dọa kép ba';

  @override
  String get achTitle_draw3_25 => 'Cựu binh Rút 3';

  @override
  String get achTitle_no_hints => 'Tự lực';

  @override
  String get achTitle_no_undo => 'Không hối tiếc';

  @override
  String get achTitle_purist_10 => 'Thuần túy';

  @override
  String get achTitle_speed_5 => 'Tay nhanh';

  @override
  String get achTitle_speed_3 => 'Thần tốc';

  @override
  String get achTitle_speed_2 => 'Tia chớp';

  @override
  String get achTitle_moves_120 => 'Hiệu quả';

  @override
  String get achTitle_moves_100 => 'Tiết kiệm';

  @override
  String get achTitle_score_4000 => 'Điểm cao';

  @override
  String get achTitle_score_6000 => 'Huyền thoại điểm số';

  @override
  String get achTitle_combo_5 => 'Khởi đầu combo';

  @override
  String get achTitle_combo_10 => 'Chuyên gia combo';

  @override
  String get achTitle_daily_first => 'Ra mắt hằng ngày';

  @override
  String get achTitle_daily_total_10 => 'Chơi đều đặn';

  @override
  String get achTitle_daily_total_30 => 'Trung thành';

  @override
  String get achTitle_daily_streak_7 => 'Người chơi hằng ngày';

  @override
  String get achTitle_winning_10 => 'Người kết thúc';

  @override
  String get achTitle_auto_finish => 'Kết thúc êm ái';

  @override
  String get achTitle_marathon => 'Marathon';

  @override
  String get achTitle_collector_5 => 'Nhà sưu tầm';

  @override
  String get achTitle_stylist => 'Nhà tạo mẫu';

  @override
  String get achTitle_level_10 => 'Dày dạn';

  @override
  String achDescWins(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Thắng $count ván',
      one: 'Thắng ván đầu tiên',
    );
    return '$_temp0';
  }

  @override
  String achDescPlayed(int count) {
    return 'Chơi $count ván';
  }

  @override
  String achDescStreak(int count) {
    return 'Thắng $count ván liên tiếp';
  }

  @override
  String achDescDraw3(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Thắng $count ván Rút 3',
      one: 'Thắng một ván Rút 3',
    );
    return '$_temp0';
  }

  @override
  String get achDescNoHints => 'Thắng một ván không dùng gợi ý';

  @override
  String get achDescNoUndo => 'Thắng một ván không hoàn tác';

  @override
  String achDescPurist(int count) {
    return 'Thắng $count ván không gợi ý và không hoàn tác';
  }

  @override
  String achDescSpeed(int minutes) {
    return 'Thắng một ván dưới $minutes phút';
  }

  @override
  String achDescMoves(int count) {
    return 'Thắng một ván với tối đa $count nước đi';
  }

  @override
  String achDescScore(int score) {
    return 'Đạt $score điểm trong một ván';
  }

  @override
  String achDescCombo(int count) {
    return 'Đạt combo ${count}x';
  }

  @override
  String achDescDailyTotal(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Hoàn thành $count thử thách hằng ngày',
      one: 'Hoàn thành một thử thách hằng ngày',
    );
    return '$_temp0';
  }

  @override
  String achDescDailyStreak(int count) {
    return 'Hoàn thành thử thách hằng ngày $count ngày liên tiếp';
  }

  @override
  String achDescWinning(int count) {
    return 'Thắng $count ván có thể thắng';
  }

  @override
  String get achDescAutoFinish => 'Kết thúc một ván bằng Tự động';

  @override
  String achDescMarathon(int hours) {
    return 'Chơi tổng cộng $hours giờ';
  }

  @override
  String achDescCollector(int count) {
    return 'Mua $count vật phẩm trang trí';
  }

  @override
  String get achDescStylist => 'Áp dụng một giao diện mới';

  @override
  String achDescLevel(int level) {
    return 'Đạt cấp $level';
  }
}
