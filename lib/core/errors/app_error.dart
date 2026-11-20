/// Typed, user-presentable error categories. UI maps them to localized text.
sealed class AppError implements Exception {
  const AppError();
}

class StorageError extends AppError {
  const StorageError(this.cause);
  final Object cause;
  @override
  String toString() => 'StorageError($cause)';
}

class InsufficientCoinsError extends AppError {
  const InsufficientCoinsError(this.required, this.balance);
  final int required;
  final int balance;
}

class AlreadyOwnedError extends AppError {
  const AlreadyOwnedError(this.itemId);
  final String itemId;
}

class NotOwnedError extends AppError {
  const NotOwnedError(this.itemId);
  final String itemId;
}

class OfflineError extends AppError {
  const OfflineError();
}

class AdUnavailableError extends AppError {
  const AdUnavailableError(this.reason);
  final String reason;
}
