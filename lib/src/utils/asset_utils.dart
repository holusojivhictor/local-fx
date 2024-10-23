import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AssetUtils {
  AssetUtils._();

  static Future<void> preloadSvgs() async {
    final manifestJson = await rootBundle.loadString('AssetManifest.json');
    final manifest = json.decode(manifestJson) as Map<String, dynamic>;
    final svgsPaths = (manifest.keys.where(
      (String key) => key.startsWith('assets/svgs/') && key.endsWith('.svg'),
    ) as Iterable)
        .toList();

    for (final svgPath in svgsPaths as List<String>) {
      final loader = SvgAssetLoader(svgPath);
      await svg.cache
          .putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
    }
  }
}
