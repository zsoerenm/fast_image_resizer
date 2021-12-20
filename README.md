# fast_image_resizer

This package uses native implementations to resize an image. It should be
fast compared to the image package.
It only supports PNG as output at the moment.

This package has zero dependencies.

## Features

* Supported inputs: JPEG, PNG, GIF, Animated GIF, WebP, Animated WebP, BMP, and WBMP
* Supported outputs: PNG

## Getting started

Add fast_image_resizer to your pubspec.yaml

## Usage

```dart
import 'package:fast_image_resizer/fast_image_resizer.dart';
import 'dart:typed_data';
```

```dart
final rawImage = await rootBundle.load('assets/someImage.png');
final bytes = await resizeImage(Uint8List.view(rawImage.buffer), width: 150);
if (bytes != null) {
    final imageWidget = Image.memory(Uint8List.view(bytes.buffer));
    showDialog(
        context: context,
        builder: (BuildContext context) {
            return AlertDialog(
            title: const Text("Image"),
            content: imageWidget,
            );
        }
    );
}
```
or

```dart
final ImagePicker _picker = ImagePicker();
final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery);
if (image != null) {
    final rawImage = await image.readAsBytes();
    final bytes = await resizeImage(Uint8List.view(rawImage.buffer), height: 250);
    if (bytes != null) {
        final testing = Image.memory(Uint8List.view(bytes.buffer));
        showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text("Image"),
                    content: testing,
                );
            }
        );
    }
}
```
## Known Issues

* This currently does not work on web, because of this issue:
https://github.com/flutter/flutter/issues/34075