import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_viewer/image_gallery_viewer.dart';

class UIImagePreview extends StatefulWidget {
  const UIImagePreview({
    super.key,
    required this.images,
    this.forcusIndex = 0,
    this.heroTag,
    this.imagePadding,
    this.onDownload,
  });

  final List<String> images;
  final int forcusIndex;
  final String? heroTag;
  final EdgeInsetsGeometry? imagePadding;
  final Function(String url)? onDownload;

  @override
  State<UIImagePreview> createState() => _UIImagePreviewState();
}

class _UIImagePreviewState extends State<UIImagePreview> {
  late final PageController _pageController;

  final slidePagekey = GlobalKey<ExtendedImageSlidePageState>();

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.forcusIndex);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  List<String> get images => widget.images;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          spacing: 48.0,
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: images.length,
                controller: _pageController,
                itemBuilder: (context, index) {
                  final image = ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    clipBehavior: Clip.antiAlias,
                    child: UIImageZoom(url: images[index], fit: BoxFit.cover),
                  );
                  if (widget.heroTag.isNotNullOrEmpty) {
                    return HeroWidget(
                      tag: widget.heroTag!,
                      slideType: SlideType.wholePage,
                      slidePagekey: slidePagekey,
                      child: image,
                    );
                  }
                  return Padding(
                    padding:
                        widget.imagePadding ??
                        const EdgeInsets.symmetric(horizontal: 8.0),
                    child: image,
                  );
                },
              ),
            ),
            UIImageIndicator(
              images: images,
              controller: _pageController,
              initialPage: widget.forcusIndex,
            ),
          ],
        ),
      ),
    );
  }
}
