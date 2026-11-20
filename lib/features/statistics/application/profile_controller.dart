import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../../../shared/models/profile.dart';
import '../../customization/domain/cosmetics.dart';
import '../data/profile_repository.dart';
import '../domain/player_stats.dart';

final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => ProfileRepository(ref.watch(documentStoreProvider)),
);

/// Owns the [ProfileData] document. Every mutation is pure on the model and
/// then persisted atomically; idempotency lives in the model's ledger.
class ProfileController extends Notifier<ProfileData> {
  @override
  ProfileData build() => ref.read(initialProfileProvider);

  DateTime get _now => ref.read(clockProvider)();

  Future<void> _commit(ProfileData next) async {
    if (identical(next, state)) return;
    state = next.copyWith(updatedAt: _now.toUtc());
    await ref.read(profileRepositoryProvider).save(state);
  }

  Future<RecordOutcome> recordGame(GameResult result) async {
    final (next, outcome) = state.recordGame(result, _now);
    await _commit(next);
    return outcome;
  }

  /// Throws [InsufficientCoinsError] / [AlreadyOwnedError].
  Future<void> purchase(CosmeticItem item) => _commit(state.purchase(item));

  Future<void> equip(CosmeticItem item) async {
    var next = state.equip(item);
    next = next.evaluateAchievements(_now).$1;
    await _commit(next);
  }

  Future<void> restoreDefaultCosmetics() =>
      _commit(state.restoreDefaultCosmetics());

  Future<void> buyHintPack(String purchaseId) =>
      _commit(state.buyHintPack(purchaseId));

  /// Throws [InsufficientCoinsError].
  Future<void> payShuffle(String key) => _commit(state.payShuffle(key));

  /// True when [eventId] had not been redeemed before.
  Future<bool> redeemAdShuffle(String eventId) async {
    final next = state.redeemAdShuffle(eventId);
    if (identical(next, state)) return false;
    await _commit(next);
    return true;
  }

  Future<void> consumeHint() => _commit(state.consumeHint());

  Future<void> grantRewardedHints(String eventId) =>
      _commit(state.grantRewardedHints(eventId));

  Future<bool> doubleWinCoins(String gameId, int amount) async {
    final before = state.coins;
    await _commit(state.doubleWinCoins(gameId, amount));
    return state.coins > before;
  }

  Future<void> deleteAll() async {
    await ref.read(profileRepositoryProvider).clear();
    state = const ProfileData();
  }
}

final profileProvider = NotifierProvider<ProfileController, ProfileData>(
  ProfileController.new,
);
