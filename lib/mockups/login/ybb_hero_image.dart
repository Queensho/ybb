import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class YbbHeroImage extends StatefulWidget {
  const YbbHeroImage({super.key});

  @override
  State<YbbHeroImage> createState() => _YbbHeroImageState();
}

class _YbbHeroImageState extends State<YbbHeroImage> {
  late final Future<Uint8List> _bytes = _loadImage();

  Future<Uint8List> _loadImage() async {
    final svg = await rootBundle.loadString('assets/3d/ybb_login_hero.svg');
    final match = RegExp(r'base64,([^\"]+)').firstMatch(svg);
    if (match == null) {
      throw StateError('YBB hero image data not found');
    }
    return base64Decode(match.group(1)!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: _bytes,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();
        return Image.memory(
          snapshot.data!,
          width: 620,
          fit: BoxFit.contain,
          gaplessPlayback: true,
          filterQuality: FilterQuality.high,
        );
      },
    );
  }
}
