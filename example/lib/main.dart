import 'package:flutter/material.dart';
import 'package:image_gallery_viewer/image_gallery_viewer.dart';

void main() {
  runApp(const MyExampleApp());
}

class MyExampleApp extends StatelessWidget {
  const MyExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Image Gallery Example')),
        body: Center(
          child: ImageGalleryViewer(
            images: const [
              'https://picsum.photos/id/1011/600/400',
              'https://picsum.photos/id/1015/600/400',
              'https://picsum.photos/id/1025/600/400',
            ],
          ),
        ),
      ),
    );
  }
}
