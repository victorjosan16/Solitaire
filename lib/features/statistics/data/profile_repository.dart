import '../../../core/database/json_document_store.dart';
import '../../../shared/models/profile.dart';

/// Loads/saves the [ProfileData] document (economy + progress).
class ProfileRepository {
  ProfileRepository(this._store);

  final JsonDocumentStore _store;

  static const spec = DocumentSpec(
    name: 'profile',
    version: ProfileData.schemaVersion,
  );

  Future<ProfileData> load() async {
    final r = await _store.load(spec);
    final data = r.data;
    if (data == null) return const ProfileData();
    try {
      return ProfileData.fromJson(data);
    } catch (_) {
      return const ProfileData();
    }
  }

  Future<void> save(ProfileData p) => _store.save(spec, p.toJson());

  Future<void> clear() => _store.delete(spec.name);
}
