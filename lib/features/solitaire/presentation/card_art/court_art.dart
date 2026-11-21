import 'dart:ui' as ui;

import 'package:flutter/services.dart';

import '../../domain/models/card.dart';

/// Illustrated court portraits (J/Q/K for each suit), decoded once at
/// startup so the synchronous card painter can draw them. When they are not
/// loaded (e.g. decoding failed) cards fall back to the vector court mark.
abstract final class CourtArt {
  static final Map<String, ui.Image> _images = {};

  static bool get loaded => _images.length == 12;

  static String _key(int rank, Suit suit) =>
      '${const {11: 'j', 12: 'q', 13: 'k'}[rank]}_${suit.name}';

  static ui.Image? of(PlayingCard card) =>
      card.rank > 10 ? _images[_key(card.rank, card.suit)] : null;

  static Future<void> load(AssetBundle bundle) async {
    if (loaded) return;
    for (final suit in Suit.values) {
      for (final rank in const [11, 12, 13]) {
        final key = _key(rank, suit);
        final data = await bundle.load('assets/images/courts/$key.png');
        final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
        final frame = await codec.getNextFrame();
        _images[key] = frame.image;
      }
    }
  }
}
