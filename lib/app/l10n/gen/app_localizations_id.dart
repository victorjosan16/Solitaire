// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Solitaire Nova';

  @override
  String splashLoading(int percent) {
    return 'Memuat… $percent%';
  }

  @override
  String get navHome => 'Beranda';

  @override
  String get navStats => 'Statistik';

  @override
  String get navShop => 'Toko';

  @override
  String get navSettings => 'Setelan';

  @override
  String get back => 'Kembali';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Batal';

  @override
  String get confirm => 'Konfirmasi';

  @override
  String get close => 'Tutup';

  @override
  String levelLabel(int level) {
    return 'Level $level';
  }

  @override
  String coinsBalance(int coins) {
    return '$coins koin';
  }

  @override
  String get continueGame => 'Lanjutkan';

  @override
  String continueSubtitle(String mode, int moves, String time) {
    return '$mode · $moves langkah · $time';
  }

  @override
  String get playClassic => 'Permainan Klasik';

  @override
  String get drawOne => 'Ambil 1';

  @override
  String get drawThree => 'Ambil 3';

  @override
  String get dealRandom => 'Bagian acak';

  @override
  String get dealWinning => 'Bagian yang bisa dimenangkan';

  @override
  String get dealWinningInfo =>
      'Bagian yang bisa dimenangkan telah diverifikasi dapat diselesaikan oleh pemecah kami. Bagian acak mungkin tidak memiliki solusi.';

  @override
  String get dailyChallenge => 'Tantangan Harian';

  @override
  String get achievements => 'Pencapaian';

  @override
  String get themes => 'Tema';

  @override
  String get statistics => 'Statistik';

  @override
  String get shop => 'Toko';

  @override
  String get settings => 'Setelan';

  @override
  String get modeRandom => 'Acak';

  @override
  String get modeWinning => 'Bisa dimenangkan';

  @override
  String get modeDaily => 'Harian';

  @override
  String get hudScore => 'Skor';

  @override
  String get hudTime => 'Waktu';

  @override
  String get hudMoves => 'Langkah';

  @override
  String get actionUndo => 'Urungkan';

  @override
  String get actionHint => 'Petunjuk';

  @override
  String get actionAuto => 'Otomatis';

  @override
  String get actionNew => 'Baru';

  @override
  String get actionPause => 'Jeda';

  @override
  String hintsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Sisa $count petunjuk',
      zero: 'Petunjuk habis',
    );
    return '$_temp0';
  }

  @override
  String semStock(int count) {
    return 'Tumpukan, $count kartu. Ketuk untuk mengambil.';
  }

  @override
  String get semStockRecycle =>
      'Tumpukan kosong. Ketuk untuk membalik kartu buangan.';

  @override
  String get semStockEmpty => 'Tumpukan kosong';

  @override
  String get semWaste => 'Kartu buangan';

  @override
  String semFoundation(String suit, int count) {
    return 'Fondasi $suit, $count kartu';
  }

  @override
  String semEmptyColumn(int column) {
    return 'Kolom kosong $column';
  }

  @override
  String semCard(String rank, String suit) {
    return '$rank $suit';
  }

  @override
  String get semFaceDown => 'Kartu tertutup';

  @override
  String get suitClubs => 'Keriting';

  @override
  String get suitDiamonds => 'Wajik';

  @override
  String get suitHearts => 'Hati';

  @override
  String get suitSpades => 'Sekop';

  @override
  String get rankAce => 'As';

  @override
  String get rankJack => 'Jack';

  @override
  String get rankQueen => 'Ratu';

  @override
  String get rankKing => 'Raja';

  @override
  String get noMovesTitle => 'Tidak ada langkah berguna';

  @override
  String get noMovesBody =>
      'Saat ini tidak ada langkah produktif. Anda bisa mengurungkan, mengulang bagian ini, atau memulai permainan baru.';

  @override
  String get noHintsTitle => 'Petunjuk habis';

  @override
  String get noHintsBody =>
      'Dapatkan petunjuk dengan koin atau dengan menonton iklan singkat opsional.';

  @override
  String buyHints(int count, int price) {
    return 'Beli $count seharga $price';
  }

  @override
  String watchAdHints(int count) {
    return 'Iklan untuk $count';
  }

  @override
  String get hintsDisabled => 'Petunjuk dinonaktifkan di Setelan.';

  @override
  String get actionShuffle => 'Kocok';

  @override
  String get shuffleTitle => 'Kocok kartu?';

  @override
  String shuffleBody(int left) {
    return 'Semua kartu kecuali yang ada di fondasi akan dikocok dan dibagikan ulang. Tindakan ini tidak dapat diurungkan. Sisa kocokan di permainan ini: $left.';
  }

  @override
  String shufflePay(int price) {
    return 'Bayar $price koin';
  }

  @override
  String get shuffleWatchAd => 'Tonton iklan';

  @override
  String get shuffleLimit => 'Tidak ada kocokan tersisa di permainan ini.';

  @override
  String get autoFinishing => 'Menyelesaikan…';

  @override
  String get skip => 'Lewati';

  @override
  String get pauseTitle => 'Dijeda';

  @override
  String get resume => 'Lanjutkan';

  @override
  String get restartDeal => 'Ulangi bagian';

  @override
  String get newGame => 'Permainan baru';

  @override
  String get home => 'Beranda';

  @override
  String get restartTitle => 'Ulangi bagian ini?';

  @override
  String get restartBody =>
      'Kemajuan dalam permainan ini akan hilang. Anda akan memainkan bagian yang sama dari awal.';

  @override
  String get newGameTitle => 'Mulai permainan baru?';

  @override
  String get newGameBody =>
      'Permainan saat ini akan dihitung sebagai kekalahan.';

  @override
  String get victoryTitle => 'Menang!';

  @override
  String get finalScore => 'Skor akhir';

  @override
  String get timeLabel => 'Waktu';

  @override
  String get movesLabel => 'Langkah';

  @override
  String get maxCombo => 'Kombo maks.';

  @override
  String get speedBonus => 'Bonus kecepatan';

  @override
  String get timeBonus => 'Bonus waktu';

  @override
  String get bestScore => 'Skor terbaik';

  @override
  String get newRecord => 'Rekor baru!';

  @override
  String coinsEarned(int coins) {
    return '+$coins';
  }

  @override
  String get doubleCoins => 'Gandakan koin · iklan';

  @override
  String get coinsDoubled => 'Koin digandakan!';

  @override
  String get playAgain => 'Permainan baru';

  @override
  String get mainMenu => 'Menu utama';

  @override
  String achievementUnlocked(String name) {
    return 'Pencapaian terbuka: $name';
  }

  @override
  String get dailyTitle => 'Tantangan Harian';

  @override
  String get todaysChallenge => 'Tantangan hari ini';

  @override
  String get dailyInfo => 'Bagian yang bisa dimenangkan · Ambil 1';

  @override
  String dailyReward(int coins) {
    return 'Hadiah: $coins';
  }

  @override
  String get play => 'Main';

  @override
  String playDay(String date) {
    return 'Main $date';
  }

  @override
  String get dailyCompleted => 'Selesai';

  @override
  String get dailyRewardClaimed => 'Hadiah diterima';

  @override
  String get dailyPastNoReward =>
      'Hari sebelumnya memberi tanda centang, bukan koin.';

  @override
  String dailyStreak(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Rangkaian $days hari',
      zero: 'Tidak ada rangkaian aktif',
    );
    return '$_temp0';
  }

  @override
  String get dailyCalendarNote =>
      'Tantangan mengikuti tanggal kalender perangkat Anda.';

  @override
  String get dailyFuture => 'Belum tersedia';

  @override
  String dailyCompletedCount(int count) {
    return '$count selesai';
  }

  @override
  String get previousMonth => 'Bulan sebelumnya';

  @override
  String get nextMonth => 'Bulan berikutnya';

  @override
  String get themesBackgrounds => 'Latar';

  @override
  String get themesCards => 'Kartu';

  @override
  String get themesTables => 'Meja';

  @override
  String get apply => 'Terapkan';

  @override
  String get applied => 'Diterapkan';

  @override
  String get locked => 'Terkunci';

  @override
  String get restoreDefaults => 'Kembalikan bawaan';

  @override
  String get getInShop => 'Dapatkan di toko';

  @override
  String get themesContrastNote =>
      'Pratinjau menunjukkan keterbacaan kartu di meja ini.';

  @override
  String get cosmetic_cards_classic => 'Klasik';

  @override
  String get cosmetic_cards_elegant => 'Elegan';

  @override
  String get cosmetic_cards_vintage => 'Vintage';

  @override
  String get cosmetic_cards_modern => 'Modern';

  @override
  String get cosmetic_cards_neon => 'Neon';

  @override
  String get cosmetic_cards_gold => 'Emas';

  @override
  String get cosmetic_bg_lake => 'Danau Gunung';

  @override
  String get cosmetic_bg_autumn => 'Jalan Musim Gugur';

  @override
  String get cosmetic_bg_tropic => 'Teluk Tropis';

  @override
  String get cosmetic_bg_alpine => 'Puncak Alpen';

  @override
  String get cosmetic_bg_aurora => 'Cahaya Utara';

  @override
  String get cosmetic_bg_lavender => 'Senja Lavender';

  @override
  String get cosmetic_table_emerald => 'Laken Zamrud';

  @override
  String get cosmetic_table_navy => 'Biru Tengah Malam';

  @override
  String get cosmetic_table_burgundy => 'Merah Anggur Kerajaan';

  @override
  String get cosmetic_table_walnut => 'Kenari';

  @override
  String get cosmetic_table_slate => 'Batu Sabak';

  @override
  String get cosmetic_table_contrast => 'Kontras Tinggi';

  @override
  String get statsTotal => 'Total';

  @override
  String get statsPlayed => 'Permainan dimainkan';

  @override
  String get statsWins => 'Kemenangan';

  @override
  String get statsWinRate => 'Tingkat kemenangan';

  @override
  String get statsTotalTime => 'Total waktu';

  @override
  String get statsBestScore => 'Skor terbaik';

  @override
  String get statsFastest => 'Kemenangan tercepat';

  @override
  String get statsCurrentStreak => 'Rangkaian saat ini';

  @override
  String get statsBestStreak => 'Rangkaian terbaik';

  @override
  String get statsMaxCombo => 'Kombo maks.';

  @override
  String get statsFewestMoves => 'Langkah tersedikit';

  @override
  String get statsDailyDone => 'Tantangan harian';

  @override
  String get statsEmpty =>
      'Mainkan permainan pertama Anda untuk melihat statistik di sini.';

  @override
  String get statsLocalLabel => 'Disimpan di perangkat ini';

  @override
  String durationHm(int hours, int minutes) {
    return '$hours j $minutes m';
  }

  @override
  String achievementsProgress(int done, int total) {
    return '$done dari $total terbuka';
  }

  @override
  String earnedOn(String date) {
    return 'Diperoleh $date';
  }

  @override
  String rewardCoins(int coins) {
    return '+$coins';
  }

  @override
  String get shopTitle => 'Toko';

  @override
  String get shopCardPacks => 'Set kartu';

  @override
  String get shopBackgrounds => 'Latar';

  @override
  String get shopTables => 'Meja';

  @override
  String get shopHints => 'Petunjuk';

  @override
  String get buy => 'Beli';

  @override
  String get owned => 'Dimiliki';

  @override
  String get equip => 'Pakai';

  @override
  String get equipped => 'Dipakai';

  @override
  String purchaseTitle(String item) {
    return 'Beli $item?';
  }

  @override
  String purchaseBody(int price, int after) {
    return 'Harganya $price koin. Saldo setelah pembelian: $after.';
  }

  @override
  String get insufficientTitle => 'Koin tidak cukup';

  @override
  String insufficientBody(int missing) {
    return 'Anda butuh $missing koin lagi. Menangkan permainan, selesaikan tantangan harian, dan buka pencapaian untuk mendapatkan lebih banyak.';
  }

  @override
  String purchaseDone(String item) {
    return '$item terbuka!';
  }

  @override
  String get hintPackTitle => 'Paket petunjuk';

  @override
  String hintPackBody(int count, int price) {
    return '$count petunjuk seharga $price koin';
  }

  @override
  String hintsOwned(int count) {
    return 'Anda punya $count petunjuk';
  }

  @override
  String get coinsDisclaimer =>
      'Koin adalah mata uang dalam game tanpa nilai uang. Koin tidak dapat dibeli, dijual, ditarik, atau ditukar.';

  @override
  String get settingsGameplay => 'Permainan';

  @override
  String get settingsAudio => 'Suara & getar';

  @override
  String get settingsDisplay => 'Tampilan';

  @override
  String get settingsPrivacy => 'Privasi';

  @override
  String get settingsData => 'Data & akun';

  @override
  String get settingsAbout => 'Tentang';

  @override
  String get music => 'Musik';

  @override
  String get sound => 'Efek suara';

  @override
  String get haptics => 'Getar';

  @override
  String get reducedMotion => 'Kurangi gerakan';

  @override
  String get leftHanded => 'Mode kidal';

  @override
  String get defaultDraw => 'Mode ambil bawaan';

  @override
  String get tapToFoundation => 'Ketukan mengirim kartu ke fondasi lebih dulu';

  @override
  String get hintsSetting => 'Petunjuk';

  @override
  String get showTimer => 'Tampilkan pengatur waktu';

  @override
  String get unlimitedPasses => 'Putaran tumpukan tanpa batas';

  @override
  String get limitedPassesNote =>
      'Jika nonaktif: Ambil 1 boleh membalik 2 kali, Ambil 3 boleh 3 kali.';

  @override
  String get foundationMoves => 'Izinkan langkah dari fondasi';

  @override
  String get rulesNextGame =>
      'Perubahan aturan berlaku mulai permainan berikutnya.';

  @override
  String get language => 'Bahasa';

  @override
  String get languageSystem => 'Bawaan sistem';

  @override
  String get cloudBackup => 'Cadangan cloud';

  @override
  String get cloudBackupUnavailable =>
      'Cadangan cloud tidak dikonfigurasi di versi ini. Kemajuan Anda disimpan di perangkat ini.';

  @override
  String get signIn => 'Masuk';

  @override
  String get privacyChoices => 'Pilihan privasi & iklan';

  @override
  String get analyticsSetting => 'Bagikan statistik penggunaan anonim';

  @override
  String get personalizedAds => 'Iklan yang dipersonalisasi';

  @override
  String get privacyPolicy => 'Kebijakan privasi';

  @override
  String get privacyPolicyBody =>
      'Solitaire Nova menyimpan permainan, statistik, dan pembelian Anda hanya di perangkat ini. Tidak perlu akun. Jika Anda mengizinkan, statistik penggunaan anonim dan iklan (melalui Google AdMob) dapat digunakan; mitra iklan dapat memproses pengenal perangkat sesuai pilihan persetujuan Anda. Anda dapat menarik persetujuan kapan saja di Setelan.';

  @override
  String get deleteData => 'Hapus data lokal';

  @override
  String get deleteDataTitle => 'Hapus semua data lokal?';

  @override
  String get deleteDataBody =>
      'Ini akan menghapus permanen permainan tersimpan, statistik, pencapaian, koin, dan item di perangkat ini. Tindakan ini tidak dapat dibatalkan.';

  @override
  String get deleteDataDone => 'Data lokal dihapus';

  @override
  String get delete => 'Hapus';

  @override
  String get restorePurchases => 'Pulihkan pembelian';

  @override
  String get restoreNone =>
      'Tidak ada pembelian toko untuk dipulihkan. Item yang dibeli dengan koin tetap ada di perangkat ini.';

  @override
  String get howToPlay => 'Cara bermain';

  @override
  String get rulesTableau =>
      'Susun tujuh kolom secara menurun dengan warna berselang-seling (merah di atas hitam, hitam di atas merah). Hanya Raja yang boleh mengisi kolom kosong.';

  @override
  String get rulesFoundation =>
      'Pindahkan semua kartu ke empat fondasi menurut jenisnya, dari As sampai Raja.';

  @override
  String get rulesStock =>
      'Ketuk tumpukan untuk membuka 1 atau 3 kartu. Saat kosong, ketuk lagi untuk membalik kartu buangan.';

  @override
  String get rulesControls =>
      'Ketuk kartu untuk memindahkannya otomatis, atau seret. Urungkan langkah apa pun, minta petunjuk, atau biarkan Otomatis menyelesaikan permainan saat semua kartu terbuka.';

  @override
  String get rulesCombo =>
      'Kombo menghitung langkah produktif berturut-turut. Hanya untuk keseruan dan tidak mengubah aturan.';

  @override
  String get about => 'Tentang';

  @override
  String version(String version) {
    return 'Versi $version';
  }

  @override
  String get licenses => 'Lisensi sumber terbuka';

  @override
  String get aboutBody =>
      'Solitaire Klondike klasik. Tanpa judi, tanpa hadiah uang.';

  @override
  String get consentTitle => 'Privasi Anda';

  @override
  String get consentBody =>
      'Solitaire Nova berfungsi sepenuhnya secara offline. Dengan izin Anda, kami menampilkan iklan agar permainan tetap gratis dan mengumpulkan statistik penggunaan anonim untuk menyempurnakannya. Anda dapat mengubahnya kapan saja di Setelan.';

  @override
  String get consentAccept => 'Terima';

  @override
  String get consentEssential => 'Hanya yang penting';

  @override
  String get offlineTitle => 'Anda sedang offline';

  @override
  String get offlineBody =>
      'Fitur ini memerlukan koneksi internet. Permainannya sendiri berfungsi offline.';

  @override
  String get adUnavailableTitle => 'Iklan tidak tersedia';

  @override
  String get adUnavailableBody =>
      'Saat ini tidak ada iklan untuk ditampilkan. Coba lagi nanti.';

  @override
  String get adNotCompleted => 'Iklan ditutup sebelum hadiah diperoleh.';

  @override
  String get cloudConflictTitle => 'Ditemukan dua permainan tersimpan';

  @override
  String get cloudConflictBody =>
      'Perangkat ini dan cadangan cloud Anda sama-sama memiliki permainan yang sedang berjalan. Mana yang ingin disimpan?';

  @override
  String get keepThisDevice => 'Perangkat ini';

  @override
  String get keepCloud => 'Cloud';

  @override
  String get errorTitle => 'Terjadi masalah';

  @override
  String get errorBody => 'Kemajuan Anda aman. Silakan coba lagi.';

  @override
  String get achTitle_first_win => 'Kemenangan Pertama';

  @override
  String get achTitle_wins_10 => 'Bintang Baru';

  @override
  String get achTitle_wins_50 => 'Jagoan Kartu';

  @override
  String get achTitle_wins_100 => 'Master Solitaire';

  @override
  String get achTitle_wins_250 => 'Grandmaster';

  @override
  String get achTitle_wins_500 => 'Legenda Hidup';

  @override
  String get achTitle_played_10 => 'Langkah Awal';

  @override
  String get achTitle_played_100 => 'Pemain Setia';

  @override
  String get achTitle_played_500 => 'Penggemar Berat';

  @override
  String get achTitle_streak_3 => 'Hat-trick';

  @override
  String get achTitle_streak_5 => 'Sedang Panas';

  @override
  String get achTitle_streak_10 => 'Tak Terhentikan';

  @override
  String get achTitle_draw3_first => 'Ancaman Rangkap Tiga';

  @override
  String get achTitle_draw3_25 => 'Veteran Ambil 3';

  @override
  String get achTitle_no_hints => 'Mandiri';

  @override
  String get achTitle_no_undo => 'Tanpa Penyesalan';

  @override
  String get achTitle_purist_10 => 'Puris';

  @override
  String get achTitle_speed_5 => 'Tangan Cekatan';

  @override
  String get achTitle_speed_3 => 'Gesit';

  @override
  String get achTitle_speed_2 => 'Kilat';

  @override
  String get achTitle_moves_120 => 'Efisien';

  @override
  String get achTitle_moves_100 => 'Hemat';

  @override
  String get achTitle_score_4000 => 'Skor Tinggi';

  @override
  String get achTitle_score_6000 => 'Legenda Skor';

  @override
  String get achTitle_combo_5 => 'Awal Kombo';

  @override
  String get achTitle_combo_10 => 'Ahli Kombo';

  @override
  String get achTitle_daily_first => 'Debut Harian';

  @override
  String get achTitle_daily_total_10 => 'Langganan Harian';

  @override
  String get achTitle_daily_total_30 => 'Setia Harian';

  @override
  String get achTitle_daily_streak_7 => 'Pemain Harian';

  @override
  String get achTitle_winning_10 => 'Penuntas';

  @override
  String get achTitle_auto_finish => 'Akhir yang Mulus';

  @override
  String get achTitle_marathon => 'Maraton';

  @override
  String get achTitle_collector_5 => 'Kolektor';

  @override
  String get achTitle_stylist => 'Penata Gaya';

  @override
  String get achTitle_level_10 => 'Berpengalaman';

  @override
  String achDescWins(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Menangkan $count permainan',
      one: 'Menangkan permainan pertama Anda',
    );
    return '$_temp0';
  }

  @override
  String achDescPlayed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Mainkan $count permainan',
      one: 'Mainkan 1 permainan',
    );
    return '$_temp0';
  }

  @override
  String achDescStreak(int count) {
    return 'Menangkan $count permainan berturut-turut';
  }

  @override
  String achDescDraw3(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Menangkan $count permainan Ambil 3',
      one: 'Menangkan permainan Ambil 3',
    );
    return '$_temp0';
  }

  @override
  String get achDescNoHints => 'Menangkan permainan tanpa petunjuk';

  @override
  String get achDescNoUndo => 'Menangkan permainan tanpa mengurungkan';

  @override
  String achDescPurist(int count) {
    return 'Menangkan $count permainan tanpa petunjuk atau urungkan';
  }

  @override
  String achDescSpeed(int minutes) {
    return 'Menangkan permainan dalam kurang dari $minutes menit';
  }

  @override
  String achDescMoves(int count) {
    return 'Menangkan permainan dalam $count langkah atau kurang';
  }

  @override
  String achDescScore(int score) {
    return 'Raih $score poin dalam satu permainan';
  }

  @override
  String achDescCombo(int count) {
    return 'Capai kombo ${count}x';
  }

  @override
  String achDescDailyTotal(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Selesaikan $count tantangan harian',
      one: 'Selesaikan tantangan harian',
    );
    return '$_temp0';
  }

  @override
  String achDescDailyStreak(int count) {
    return 'Selesaikan tantangan harian $count hari berturut-turut';
  }

  @override
  String achDescWinning(int count) {
    return 'Menangkan $count bagian yang bisa dimenangkan';
  }

  @override
  String get achDescAutoFinish => 'Selesaikan permainan dengan Otomatis';

  @override
  String achDescMarathon(int hours) {
    return 'Bermain total $hours jam';
  }

  @override
  String achDescCollector(int count) {
    return 'Beli $count item kosmetik';
  }

  @override
  String get achDescStylist => 'Terapkan tema baru';

  @override
  String achDescLevel(int level) {
    return 'Capai level $level';
  }
}
