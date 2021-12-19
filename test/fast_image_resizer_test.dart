import 'package:flutter_test/flutter_test.dart';

import 'package:fast_image_resizer/fast_image_resizer.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;

void main() {
  test('resize image', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final rawImage = await rootBundle.load('assets/lena.png');
    final heightResizedImage =
        await resizeImage(Uint8List.view(rawImage.buffer), height: 100);
    if (heightResizedImage != null) {
      final codec = await ui.instantiateImageCodec(
        heightResizedImage.buffer.asUint8List(),
      );
      final image = (await codec.getNextFrame()).image;
      expect(image.height, 100);
    } else {
      expect(true, false);
    }
    final widthResizedImage =
        await resizeImage(Uint8List.view(rawImage.buffer), width: 100);
    if (widthResizedImage != null) {
      final codec = await ui.instantiateImageCodec(
        widthResizedImage.buffer.asUint8List(),
      );
      final image = (await codec.getNextFrame()).image;
      expect(image.width, 100);
    } else {
      expect(true, false);
    }
  });
}
