import 'package:fast_image_resizer/fast_image_resizer.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Image resizer",
        home: TextButton.icon(
            label: Text("Choose picture"),
            icon: Icon(Icons.camera),
            onPressed: () async {
              final rawImage = await rootBundle.load('assets/someImage.png');
              final bytes = await resizeImage(Uint8List.view(rawImage.buffer),
                  width: 150);
              if (bytes != null) {
                final imageWidget = Image.memory(Uint8List.view(bytes.buffer));
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Image"),
                        content: imageWidget,
                      );
                    });
              }
            }));
  }
}
