import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class YbbHeroImage extends StatelessWidget {
  const YbbHeroImage({super.key});

  static final Uint8List _bytes = base64Decode(_data);

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      _bytes,
      width: 620,
      height: 270,
      fit: BoxFit.contain,
      gaplessPlayback: true,
      filterQuality: FilterQuality.high,
      errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported_outlined, color: Colors.white54, size: 64),
    );
  }

  static const String _data = 'UklGRqCJ...';
}
