library fast_image_resizer;

import 'dart:ui' as ui;
import 'dart:typed_data';

/// Format of an image
enum ImageFormat {
  /// PNG format.
  ///
  /// A loss-less compression format for images.
  /// The PNG format supports images up to
  /// 2,147,483,647 pixels in either dimension, though in practice available
  /// memory provides a more immediate limitation on maximum image size.
  png,

  /// Raw RGBA format.
  ///
  /// Unencoded bytes, in RGBA row-primary form with premultiplied alpha, 8 bits per channel.
  rawRgba,

  /// Raw straight RGBA format.
  ///
  /// Unencoded bytes, in RGBA row-primary form with straight alpha, 8 bits per channel.
  rawStraightRgba,

  /// Raw unmodified format.
  ///
  /// Unencoded bytes, in the image's existing format. For example, a grayscale
  /// image may use a single 8-bit channel for each pixel.
  rawUnmodified,
}

extension ImageFormatExtension on ImageFormat {
  static ui.ImageByteFormat toDartUiFormat(ImageFormat format) {
    switch (format) {
      case ImageFormat.png:
        return ui.ImageByteFormat.png;

      case ImageFormat.rawRgba:
        return ui.ImageByteFormat.rawRgba;
      case ImageFormat.rawStraightRgba:
        return ui.ImageByteFormat.rawStraightRgba;
      case ImageFormat.rawUnmodified:
        return ui.ImageByteFormat.rawUnmodified;
    }
  }
}

/// Resizes the image [rawImage] to [width] and [height].
///
/// If only width or height are specified, the resized
/// image will keep the aspect ratio.
Future<ByteData?> resizeImage(
  Uint8List rawImage, {
  int? width,
  int? height,
  ImageFormat format = ImageFormat.png,
}) async {
  final codec = await ui.instantiateImageCodec(rawImage,
      targetWidth: width, targetHeight: height);
  final resizedImage = (await codec.getNextFrame()).image;
  final uiFormat = ImageFormatExtension.toDartUiFormat(format);
  return resizedImage.toByteData(format: uiFormat);
}
