import '../../features/solitaire/domain/models/game_snapshot.dart';

enum SyncState { unavailable, signedOut, idle, syncing, error }

/// Optional cloud backup (Firebase Auth + Firestore adapter is an
/// integration step). The default build reports [SyncState.unavailable] and
/// the game is 100% functional locally.
abstract class CloudBackupService {
  SyncState get state;
  bool get isConfigured;
}

class UnavailableCloudBackup implements CloudBackupService {
  @override
  SyncState get state => SyncState.unavailable;
  @override
  bool get isConfigured => false;
}

enum ConflictResolution { keepLocal, keepRemote, askUser }

/// Documented conflict policy (docs/ARCHITECTURE.md#sync):
/// * Different game ids: the locally active game always wins; the remote one
///   is history only.
/// * Same game id: higher move count / later updatedAt wins automatically.
/// * Both sides have diverged active progress on different games and the
///   remote is newer: ask the user.
ConflictResolution resolveGameConflict(GameSnapshot? local, GameSnapshot? remote) {
  if (remote == null) return ConflictResolution.keepLocal;
  if (local == null) return ConflictResolution.keepRemote;
  if (local.gameId == remote.gameId) {
    if (remote.finished && !local.finished) return ConflictResolution.keepRemote;
    if (local.finished && !remote.finished) return ConflictResolution.keepLocal;
    return remote.history.length > local.history.length &&
            remote.updatedAt.isAfter(local.updatedAt)
        ? ConflictResolution.keepRemote
        : ConflictResolution.keepLocal;
  }
  if (!local.hasProgress || local.finished) {
    return remote.finished ? ConflictResolution.keepLocal : ConflictResolution.keepRemote;
  }
  if (remote.finished || !remote.hasProgress) return ConflictResolution.keepLocal;
  return remote.updatedAt.isAfter(local.updatedAt)
      ? ConflictResolution.askUser
      : ConflictResolution.keepLocal;
}
