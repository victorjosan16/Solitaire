// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Solitaire Nova';

  @override
  String splashLoading(int percent) {
    return 'Yükleniyor… %$percent';
  }

  @override
  String get navHome => 'Ana Sayfa';

  @override
  String get navStats => 'İstatistik';

  @override
  String get navShop => 'Mağaza';

  @override
  String get navProfile => 'Profil';

  @override
  String get gameModeSetting => 'Oyun modu';

  @override
  String get navSettings => 'Ayarlar';

  @override
  String get back => 'Geri';

  @override
  String get ok => 'Tamam';

  @override
  String get cancel => 'İptal';

  @override
  String get confirm => 'Onayla';

  @override
  String get close => 'Kapat';

  @override
  String levelLabel(int level) {
    return 'Seviye $level';
  }

  @override
  String coinsBalance(int coins) {
    return '$coins jeton';
  }

  @override
  String get continueGame => 'Devam et';

  @override
  String continueSubtitle(String mode, int moves, String time) {
    return '$mode · $moves hamle · $time';
  }

  @override
  String get playClassic => 'Klasik Oyun';

  @override
  String get drawOne => '1 Kart Çek';

  @override
  String get drawThree => '3 Kart Çek';

  @override
  String get dealRandom => 'Rastgele dağıtım';

  @override
  String get dealWinning => 'Kazanılabilir dağıtım';

  @override
  String get dealWinningInfo =>
      'Kazanılabilir dağıtımların çözülebilir olduğu çözücümüz tarafından doğrulanmıştır. Rastgele dağıtımların çözümü olmayabilir.';

  @override
  String get dailyChallenge => 'Günlük Görev';

  @override
  String get achievements => 'Başarımlar';

  @override
  String get themes => 'Temalar';

  @override
  String get statistics => 'İstatistikler';

  @override
  String get shop => 'Mağaza';

  @override
  String get settings => 'Ayarlar';

  @override
  String get modeRandom => 'Rastgele';

  @override
  String get modeWinning => 'Kazanılabilir';

  @override
  String get modeDaily => 'Günlük';

  @override
  String get hudScore => 'Puan';

  @override
  String get hudTime => 'Süre';

  @override
  String get hudMoves => 'Hamle';

  @override
  String get actionUndo => 'Geri al';

  @override
  String get actionHint => 'İpucu';

  @override
  String get actionAuto => 'Otomatik';

  @override
  String get actionNew => 'Yeni';

  @override
  String get actionPause => 'Duraklat';

  @override
  String hintsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ipucu kaldı',
      zero: 'İpucu kalmadı',
    );
    return '$_temp0';
  }

  @override
  String semStock(int count) {
    return 'Deste, $count kart. Çekmek için dokun.';
  }

  @override
  String get semStockRecycle => 'Deste boş. Açık kartları çevirmek için dokun.';

  @override
  String get semStockEmpty => 'Deste boş';

  @override
  String get semWaste => 'Açık kartlar';

  @override
  String semFoundation(String suit, int count) {
    return '$suit temeli, $count kart';
  }

  @override
  String semEmptyColumn(int column) {
    return 'Boş sütun $column';
  }

  @override
  String semCard(String rank, String suit) {
    return '$suit $rank';
  }

  @override
  String get semFaceDown => 'Kapalı kart';

  @override
  String get suitClubs => 'Sinek';

  @override
  String get suitDiamonds => 'Karo';

  @override
  String get suitHearts => 'Kupa';

  @override
  String get suitSpades => 'Maça';

  @override
  String get rankAce => 'As';

  @override
  String get rankJack => 'Vale';

  @override
  String get rankQueen => 'Kız';

  @override
  String get rankKing => 'Papaz';

  @override
  String get noMovesTitle => 'İşe yarar hamle yok';

  @override
  String get noMovesBody =>
      'Şu anda verimli bir hamle yok. Geri alabilir, bu dağıtımı yeniden başlatabilir veya yeni bir oyun açabilirsin.';

  @override
  String get noHintsTitle => 'İpucun kalmadı';

  @override
  String get noHintsBody =>
      'Jetonla veya isteğe bağlı kısa bir reklam izleyerek daha fazla ipucu al.';

  @override
  String buyHints(int count, int price) {
    return '$price jetona $count al';
  }

  @override
  String watchAdHints(int count) {
    return 'Reklamla $count al';
  }

  @override
  String get hintsDisabled => 'İpuçları Ayarlar\'da kapalı.';

  @override
  String get actionShuffle => 'Karıştır';

  @override
  String get shuffleTitle => 'Kartlar karıştırılsın mı?';

  @override
  String shuffleBody(int left) {
    return 'Temellerdekiler dışındaki tüm kartlar karıştırılıp yeniden dağıtılacak. Bu işlem geri alınamaz. Bu oyunda kalan karıştırma hakkı: $left.';
  }

  @override
  String get shuffleInfo =>
      'Temellerdekiler dışındaki tüm kartlar karıştırılıp yeniden dağıtılacak. Bu işlem geri alınamaz.';

  @override
  String get shufflesLeftLabel => 'Bu oyunda kalan karıştırma hakkı';

  @override
  String shufflePay(int price) {
    return '$price jeton öde';
  }

  @override
  String get shuffleWatchAd => 'Reklam izle';

  @override
  String get shuffleLimit => 'Bu oyunda karıştırma hakkın kalmadı.';

  @override
  String get autoFinishing => 'Bitiriliyor…';

  @override
  String get skip => 'Atla';

  @override
  String get pauseTitle => 'Duraklatıldı';

  @override
  String get resume => 'Devam et';

  @override
  String get restartDeal => 'Dağıtımı yeniden başlat';

  @override
  String get newGame => 'Yeni oyun';

  @override
  String get home => 'Ana Sayfa';

  @override
  String get restartTitle => 'Bu dağıtım yeniden başlatılsın mı?';

  @override
  String get restartBody =>
      'Bu oyundaki ilerlemen kaybolacak. Aynı dağıtımı baştan oynayacaksın.';

  @override
  String get newGameTitle => 'Yeni oyun başlatılsın mı?';

  @override
  String get newGameBody => 'Mevcut oyun kayıp olarak sayılacak.';

  @override
  String get victoryTitle => 'Zafer!';

  @override
  String get finalScore => 'Son puan';

  @override
  String get timeLabel => 'Süre';

  @override
  String get movesLabel => 'Hamle';

  @override
  String get maxCombo => 'En yüksek kombo';

  @override
  String get speedBonus => 'Hız bonusu';

  @override
  String get timeBonus => 'Süre bonusu';

  @override
  String get bestScore => 'En iyi puan';

  @override
  String get newRecord => 'Yeni rekor!';

  @override
  String coinsEarned(int coins) {
    return '+$coins';
  }

  @override
  String get doubleCoins => 'Jetonları ikiye katla · reklam';

  @override
  String get coinsDoubled => 'Jetonlar ikiye katlandı!';

  @override
  String get playAgain => 'Yeni oyun';

  @override
  String get mainMenu => 'Ana menü';

  @override
  String achievementUnlocked(String name) {
    return 'Başarım açıldı: $name';
  }

  @override
  String get dailyTitle => 'Günlük Görev';

  @override
  String get todaysChallenge => 'Bugünün görevi';

  @override
  String get dailyInfo => 'Kazanılabilir dağıtım · 1 Kart Çek';

  @override
  String dailyReward(int coins) {
    return 'Ödül: $coins';
  }

  @override
  String get play => 'Oyna';

  @override
  String playDay(String date) {
    return '$date oyna';
  }

  @override
  String get dailyCompleted => 'Tamamlandı';

  @override
  String get dailyRewardClaimed => 'Ödül alındı';

  @override
  String get dailyPastNoReward =>
      'Geçmiş günler jeton değil, onay işareti verir.';

  @override
  String dailyStreak(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days günlük seri',
      zero: 'Aktif seri yok',
    );
    return '$_temp0';
  }

  @override
  String get dailyCalendarNote =>
      'Görevler cihazının takvim tarihine göre belirlenir.';

  @override
  String get dailyFuture => 'Henüz açılmadı';

  @override
  String dailyCompletedCount(int count) {
    return '$count tamamlandı';
  }

  @override
  String get previousMonth => 'Önceki ay';

  @override
  String get nextMonth => 'Sonraki ay';

  @override
  String get themesBackgrounds => 'Arka planlar';

  @override
  String get themesCards => 'Kartlar';

  @override
  String get themesTables => 'Masalar';

  @override
  String get apply => 'Uygula';

  @override
  String get applied => 'Uygulandı';

  @override
  String get locked => 'Kilitli';

  @override
  String get restoreDefaults => 'Varsayılanlara dön';

  @override
  String get getInShop => 'Mağazadan al';

  @override
  String get themesContrastNote =>
      'Önizleme, kartların bu masada ne kadar okunaklı olduğunu gösterir.';

  @override
  String get cosmetic_cards_classic => 'Klasik';

  @override
  String get cosmetic_cards_elegant => 'Zarif';

  @override
  String get cosmetic_cards_vintage => 'Vintage';

  @override
  String get cosmetic_cards_modern => 'Modern';

  @override
  String get cosmetic_cards_neon => 'Neon';

  @override
  String get cosmetic_cards_gold => 'Altın';

  @override
  String get cosmetic_bg_lake => 'Dağ Gölü';

  @override
  String get cosmetic_bg_autumn => 'Sonbahar Patikası';

  @override
  String get cosmetic_bg_tropic => 'Tropik Koy';

  @override
  String get cosmetic_bg_alpine => 'Alp Zirveleri';

  @override
  String get cosmetic_bg_aurora => 'Kuzey Işıkları';

  @override
  String get cosmetic_bg_lavender => 'Lavanta Alacakaranlığı';

  @override
  String get cosmetic_table_emerald => 'Zümrüt Çuha';

  @override
  String get cosmetic_table_navy => 'Gece Mavisi';

  @override
  String get cosmetic_table_burgundy => 'Kraliyet Bordosu';

  @override
  String get cosmetic_table_walnut => 'Ceviz';

  @override
  String get cosmetic_table_slate => 'Arduvaz';

  @override
  String get cosmetic_table_contrast => 'Yüksek Kontrast';

  @override
  String get statsTotal => 'Toplam';

  @override
  String get statsPlayed => 'Oynanan oyun';

  @override
  String get statsWins => 'Galibiyet';

  @override
  String get statsWinRate => 'Kazanma oranı';

  @override
  String get statsTotalTime => 'Toplam süre';

  @override
  String get statsBestScore => 'En iyi puan';

  @override
  String get statsFastest => 'En hızlı galibiyet';

  @override
  String get statsCurrentStreak => 'Mevcut seri';

  @override
  String get statsBestStreak => 'En iyi seri';

  @override
  String get statsMaxCombo => 'En yüksek kombo';

  @override
  String get statsFewestMoves => 'En az hamle';

  @override
  String get statsDailyDone => 'Günlük görevler';

  @override
  String get statsEmpty =>
      'İstatistiklerini burada görmek için ilk oyununu oyna.';

  @override
  String get statsLocalLabel => 'Bu cihazda saklanır';

  @override
  String durationHm(int hours, int minutes) {
    return '$hours sa $minutes dk';
  }

  @override
  String achievementsProgress(int done, int total) {
    return '$total başarımdan $done açıldı';
  }

  @override
  String earnedOn(String date) {
    return '$date tarihinde kazanıldı';
  }

  @override
  String rewardCoins(int coins) {
    return '+$coins';
  }

  @override
  String get shopTitle => 'Mağaza';

  @override
  String get shopCardPacks => 'Kart setleri';

  @override
  String get shopBackgrounds => 'Arka planlar';

  @override
  String get shopTables => 'Masalar';

  @override
  String get shopHints => 'İpuçları';

  @override
  String watchAdCoins(int coins) {
    return 'Reklam izle: +$coins jeton';
  }

  @override
  String get buy => 'Satın al';

  @override
  String get owned => 'Sahipsin';

  @override
  String get equip => 'Kullan';

  @override
  String get equipped => 'Kullanımda';

  @override
  String purchaseTitle(String item) {
    return '$item satın alınsın mı?';
  }

  @override
  String purchaseBody(int price, int after) {
    return 'Fiyatı $price jeton. Satın aldıktan sonraki bakiye: $after.';
  }

  @override
  String get insufficientTitle => 'Yeterli jeton yok';

  @override
  String insufficientBody(int missing) {
    return '$missing jetona daha ihtiyacın var. Daha fazla kazanmak için oyun kazan, günlük görevleri tamamla ve başarımların kilidini aç.';
  }

  @override
  String purchaseDone(String item) {
    return '$item açıldı!';
  }

  @override
  String get hintPackTitle => 'İpucu paketi';

  @override
  String hintPackBody(int count, int price) {
    return '$price jetona $count ipucu';
  }

  @override
  String hintsOwned(int count) {
    return '$count ipucun var';
  }

  @override
  String get coinsDisclaimer =>
      'Jetonlar, parasal değeri olmayan bir oyun içi para birimidir. Satın alınamaz, satılamaz, çekilemez veya takas edilemez.';

  @override
  String get settingsGameplay => 'Oynanış';

  @override
  String get settingsAudio => 'Ses ve titreşim';

  @override
  String get settingsDisplay => 'Görünüm';

  @override
  String get settingsPrivacy => 'Gizlilik';

  @override
  String get settingsData => 'Veri ve hesap';

  @override
  String get settingsAbout => 'Hakkında';

  @override
  String get music => 'Müzik';

  @override
  String get sound => 'Ses efektleri';

  @override
  String get haptics => 'Titreşim';

  @override
  String get reducedMotion => 'Hareketi azalt';

  @override
  String get leftHanded => 'Solak modu';

  @override
  String get defaultDraw => 'Varsayılan çekme modu';

  @override
  String get tapToFoundation => 'Dokunma kartı önce temele gönderir';

  @override
  String get hintsSetting => 'İpuçları';

  @override
  String get showTimer => 'Zamanlayıcıyı göster';

  @override
  String get unlimitedPasses => 'Sınırsız deste turu';

  @override
  String get limitedPassesNote =>
      'Kapalıyken: 1 Kart Çek 2 kez, 3 Kart Çek 3 kez çevirmeye izin verir.';

  @override
  String get foundationMoves => 'Temelden hamlelere izin ver';

  @override
  String get rulesNextGame =>
      'Kural değişiklikleri sonraki oyundan itibaren geçerli olur.';

  @override
  String get language => 'Dil';

  @override
  String get languageSystem => 'Sistem varsayılanı';

  @override
  String get cloudBackup => 'Bulut yedeği';

  @override
  String get cloudBackupUnavailable =>
      'Bulut yedeği bu sürümde yapılandırılmadı. İlerlemen bu cihazda kaydedilir.';

  @override
  String get signIn => 'Giriş yap';

  @override
  String get privacyChoices => 'Gizlilik ve reklam tercihleri';

  @override
  String get analyticsSetting => 'Anonim kullanım istatistiklerini paylaş';

  @override
  String get personalizedAds => 'Kişiselleştirilmiş reklamlar';

  @override
  String get privacyPolicy => 'Gizlilik politikası';

  @override
  String get privacyPolicyBody =>
      'Solitaire Nova oyunlarını, istatistiklerini ve satın aldıklarını yalnızca bu cihazda saklar. Hesap gerekmez. İzin verirsen anonim kullanım istatistikleri ve reklamlar (Google AdMob aracılığıyla) kullanılabilir; reklam ortakları cihaz tanımlayıcılarını onay tercihlerine göre işleyebilir. Onayını istediğin zaman Ayarlar\'dan geri çekebilirsin.';

  @override
  String get deleteData => 'Yerel verileri sil';

  @override
  String get deleteDataTitle => 'Tüm yerel veriler silinsin mi?';

  @override
  String get deleteDataBody =>
      'Bu işlem, bu cihazdaki kayıtlı oyununu, istatistiklerini, başarımlarını, jetonlarını ve eşyalarını kalıcı olarak siler. Geri alınamaz.';

  @override
  String get deleteDataDone => 'Yerel veriler silindi';

  @override
  String get delete => 'Sil';

  @override
  String get restorePurchases => 'Satın alımları geri yükle';

  @override
  String get restoreNone =>
      'Geri yüklenecek mağaza satın alımı yok. Jetonla alınan eşyalar bu cihazda kalır.';

  @override
  String get howToPlay => 'Nasıl oynanır';

  @override
  String get rulesTableau =>
      'Yedi sütunu renkleri değiştirerek azalan sırada diz (siyah üstüne kırmızı, kırmızı üstüne siyah). Boş sütuna yalnızca Papaz konabilir.';

  @override
  String get rulesFoundation =>
      'Tüm kartları renklerine göre As\'tan Papaz\'a dört temele taşı.';

  @override
  String get rulesStock =>
      '1 veya 3 kart açmak için desteye dokun. Deste bitince açık kartları çevirmek için tekrar dokun.';

  @override
  String get rulesControls =>
      'Bir kartı temellere göndermek için ona dokunun veya istediğiniz sütuna sürükleyin. Hamleleri geri alın, ipucu isteyin ya da tüm kartlar açıldığında oyunu Otomatik bitirsin.';

  @override
  String get rulesCombo =>
      'Kombolar art arda gelen verimli hamleleri sayar. Sadece eğlence içindir, kuralları değiştirmez.';

  @override
  String get about => 'Hakkında';

  @override
  String version(String version) {
    return 'Sürüm $version';
  }

  @override
  String get licenses => 'Açık kaynak lisansları';

  @override
  String get aboutBody =>
      'Klasik bir Klondike Solitaire. Kumar yok, para ödülü yok.';

  @override
  String get consentTitle => 'Gizliliğin';

  @override
  String get consentBody =>
      'Solitaire Nova tamamen çevrimdışı çalışır. İznin olursa oyunu ücretsiz tutan reklamlar gösterir ve oyunu geliştirmek için anonim kullanım istatistikleri toplarız. Bunu istediğin zaman Ayarlar\'dan değiştirebilirsin.';

  @override
  String get consentAccept => 'Kabul et';

  @override
  String get consentEssential => 'Yalnızca gerekli';

  @override
  String get offlineTitle => 'Çevrimdışısın';

  @override
  String get offlineBody =>
      'Bu özellik internet bağlantısı gerektirir. Oyunun kendisi çevrimdışı çalışır.';

  @override
  String get adUnavailableTitle => 'Reklam yok';

  @override
  String get adUnavailableBody =>
      'Şu anda gösterilecek reklam yok. Lütfen daha sonra tekrar dene.';

  @override
  String get adNotCompleted => 'Reklam, ödül kazanılmadan kapatıldı.';

  @override
  String get cloudConflictTitle => 'İki kayıtlı oyun bulundu';

  @override
  String get cloudConflictBody =>
      'Hem bu cihazda hem de bulut yedeğinde devam eden bir oyun var. Hangisini tutmak istersin?';

  @override
  String get keepThisDevice => 'Bu cihaz';

  @override
  String get keepCloud => 'Bulut';

  @override
  String get errorTitle => 'Bir şeyler ters gitti';

  @override
  String get errorBody => 'İlerlemen güvende. Lütfen tekrar dene.';

  @override
  String get achTitle_first_win => 'İlk Zafer';

  @override
  String get achTitle_wins_10 => 'Yükselen Yıldız';

  @override
  String get achTitle_wins_50 => 'Kart Ustası';

  @override
  String get achTitle_wins_100 => 'Solitaire Ustası';

  @override
  String get achTitle_wins_250 => 'Büyük Usta';

  @override
  String get achTitle_wins_500 => 'Yaşayan Efsane';

  @override
  String get achTitle_played_10 => 'İlk Adımlar';

  @override
  String get achTitle_played_100 => 'Müdavim';

  @override
  String get achTitle_played_500 => 'Tutkun';

  @override
  String get achTitle_streak_3 => 'Hat-trick';

  @override
  String get achTitle_streak_5 => 'Formda';

  @override
  String get achTitle_streak_10 => 'Durdurulamaz';

  @override
  String get achTitle_draw3_first => 'Üçlü Tehdit';

  @override
  String get achTitle_draw3_25 => '3 Kart Gazisi';

  @override
  String get achTitle_no_hints => 'Kendi Başına';

  @override
  String get achTitle_no_undo => 'Pişmanlık Yok';

  @override
  String get achTitle_purist_10 => 'Saf Oyuncu';

  @override
  String get achTitle_speed_5 => 'Çevik Eller';

  @override
  String get achTitle_speed_3 => 'Hızlı';

  @override
  String get achTitle_speed_2 => 'Yıldırım';

  @override
  String get achTitle_moves_120 => 'Verimli';

  @override
  String get achTitle_moves_100 => 'Tutumlu';

  @override
  String get achTitle_score_4000 => 'Yüksek Puan';

  @override
  String get achTitle_score_6000 => 'Puan Efsanesi';

  @override
  String get achTitle_combo_5 => 'Kombo Başlangıcı';

  @override
  String get achTitle_combo_10 => 'Kombo Uzmanı';

  @override
  String get achTitle_daily_first => 'Günlük İlk Adım';

  @override
  String get achTitle_daily_total_10 => 'Günlük Müdavim';

  @override
  String get achTitle_daily_total_30 => 'Günlük Sadık';

  @override
  String get achTitle_daily_streak_7 => 'Günlük Oyuncu';

  @override
  String get achTitle_winning_10 => 'Bitirici';

  @override
  String get achTitle_auto_finish => 'Yumuşak Final';

  @override
  String get achTitle_marathon => 'Maraton';

  @override
  String get achTitle_collector_5 => 'Koleksiyoncu';

  @override
  String get achTitle_stylist => 'Stilist';

  @override
  String get achTitle_level_10 => 'Deneyimli';

  @override
  String achDescWins(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count oyun kazan',
      one: 'İlk oyununu kazan',
    );
    return '$_temp0';
  }

  @override
  String achDescPlayed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count oyun oyna',
      one: '1 oyun oyna',
    );
    return '$_temp0';
  }

  @override
  String achDescStreak(int count) {
    return 'Üst üste $count oyun kazan';
  }

  @override
  String achDescDraw3(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count adet 3 Kart Çek oyunu kazan',
      one: 'Bir 3 Kart Çek oyunu kazan',
    );
    return '$_temp0';
  }

  @override
  String get achDescNoHints => 'İpucu kullanmadan bir oyun kazan';

  @override
  String get achDescNoUndo => 'Geri almadan bir oyun kazan';

  @override
  String achDescPurist(int count) {
    return 'İpucu ve geri alma olmadan $count oyun kazan';
  }

  @override
  String achDescSpeed(int minutes) {
    return 'Bir oyunu $minutes dakikadan kısa sürede kazan';
  }

  @override
  String achDescMoves(int count) {
    return 'Bir oyunu en fazla $count hamlede kazan';
  }

  @override
  String achDescScore(int score) {
    return 'Tek oyunda $score puan topla';
  }

  @override
  String achDescCombo(int count) {
    return '${count}x komboya ulaş';
  }

  @override
  String achDescDailyTotal(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count günlük görev tamamla',
      one: 'Bir günlük görevi tamamla',
    );
    return '$_temp0';
  }

  @override
  String achDescDailyStreak(int count) {
    return 'Günlük görevleri $count gün üst üste tamamla';
  }

  @override
  String achDescWinning(int count) {
    return '$count kazanılabilir dağıtım kazan';
  }

  @override
  String get achDescAutoFinish => 'Bir oyunu Otomatik ile bitir';

  @override
  String achDescMarathon(int hours) {
    return 'Toplam $hours saat oyna';
  }

  @override
  String achDescCollector(int count) {
    return '$count kozmetik eşya satın al';
  }

  @override
  String get achDescStylist => 'Yeni bir tema uygula';

  @override
  String achDescLevel(int level) {
    return '$level. seviyeye ulaş';
  }
}
