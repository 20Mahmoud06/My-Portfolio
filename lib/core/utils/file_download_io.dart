import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/foundation.dart';

Future<void> downloadAsset(String assetPath, {String? fileName}) async {
  try {
    // Strip leading assets/assets/ → assets/ for rootBundle
    final bundlePath = assetPath.startsWith('assets/assets/')
        ? assetPath.replaceFirst('assets/assets/', 'assets/')
        : assetPath;
    final data = await rootBundle.load(bundlePath);
    final tempDir = Directory.systemTemp;
    final file = File(
      '${tempDir.path}/${fileName ?? assetPath.split('/').last}',
    );
    await file.writeAsBytes(data.buffer.asUint8List());

    if (Platform.isAndroid || Platform.isIOS) {
      debugPrint('Resume saved to: ${file.path}');
    } else {
      await Process.run(
        Platform.isWindows ? 'start' : (Platform.isMacOS ? 'open' : 'xdg-open'),
        [file.path],
        runInShell: true,
      );
    }
  } catch (e) {
    debugPrint('Failed to download: $e');
  }
}
