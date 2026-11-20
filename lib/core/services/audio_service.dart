import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

import '../logging/app_logger.dart';

enum Sfx { place, flip, draw, foundation, invalid, tap, coins, victory }

abstract class AudioService {
  void configure({
    required bool sound,
    required bool music,
    required bool haptics,
  });
  void play(Sfx sfx);
  void haptic(HapticKind kind);
  void dispose();
}

enum HapticKind { light, error, success }

/// No-op audio for tests.
class SilentAudioService implements AudioService {
  final List<Sfx> played = [];
  @override
  void configure({
    required bool sound,
    required bool music,
    required bool haptics,
  }) {}
  @override
  void play(Sfx sfx) => played.add(sfx);
  @override
  void haptic(HapticKind kind) {}
  @override
  void dispose() {}
}

/// Original synthesized effects (assets/audio, see tool/generate_audio.py).
class AudioplayersAudioService implements AudioService {
  AudioplayersAudioService();

  static const _files = {
    Sfx.place: 'audio/card_place.wav',
    Sfx.flip: 'audio/card_flip.wav',
    Sfx.draw: 'audio/card_draw.wav',
    Sfx.foundation: 'audio/foundation.wav',
    Sfx.invalid: 'audio/invalid.wav',
    Sfx.tap: 'audio/tap.wav',
    Sfx.coins: 'audio/coins.wav',
    Sfx.victory: 'audio/victory.wav',
  };

  final Map<Sfx, AudioPlayer> _players = {};
  AudioPlayer? _music;
  bool _sound = true, _musicOn = false, _haptics = true;

  @override
  void configure({
    required bool sound,
    required bool music,
    required bool haptics,
  }) {
    _sound = sound;
    _haptics = haptics;
    if (music != _musicOn) {
      _musicOn = music;
      _updateMusic();
    }
  }

  Future<void> _updateMusic() async {
    try {
      if (_musicOn) {
        final m = _music ??= AudioPlayer(playerId: 'music');
        await m.setReleaseMode(ReleaseMode.loop);
        await m.setVolume(0.35);
        await m.play(AssetSource('audio/ambient_loop.m4a'));
      } else {
        await _music?.stop();
      }
    } catch (e) {
      AppLogger.w('audio.music_failed', const {}, e);
    }
  }

  @override
  void play(Sfx sfx) {
    if (!_sound) return;
    final p = _players.putIfAbsent(sfx, () {
      final player = AudioPlayer(playerId: 'sfx_${sfx.name}');
      player.setReleaseMode(ReleaseMode.stop);
      player.setPlayerMode(PlayerMode.lowLatency);
      return player;
    });
    p
        .stop()
        .then((_) => p.play(AssetSource(_files[sfx]!), volume: 0.7))
        .catchError(
          (Object e) => AppLogger.w('audio.sfx_failed', {'sfx': sfx.name}, e),
        );
  }

  @override
  void haptic(HapticKind kind) {
    if (!_haptics) return;
    switch (kind) {
      case HapticKind.light:
        HapticFeedback.selectionClick();
      case HapticKind.error:
        HapticFeedback.heavyImpact();
      case HapticKind.success:
        HapticFeedback.mediumImpact();
    }
  }

  @override
  void dispose() {
    for (final p in _players.values) {
      p.dispose();
    }
    _music?.dispose();
  }
}
