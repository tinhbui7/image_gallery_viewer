import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_gallery_viewer/ui_image_view.dart';

class UIImageIndicator extends StatefulWidget {
  final List<String> images;
  final PageController? controller;
  final ValueChanged<int>? onPageChanged;
  final int initialPage;

  const UIImageIndicator({
    super.key,
    required this.images,
    this.controller,
    this.onPageChanged,
    this.initialPage = 0,
  });

  @override
  State<UIImageIndicator> createState() => _UIImageIndicatorState();
}

class _UIImageIndicatorState extends State<UIImageIndicator> {
  int _currentPage = 0;
  final ScrollController _thumbnailScrollController = ScrollController();
  static const indicatorHeight = 56.0;
  static const _imageHeight = 44.0;
  static const imageSpacing = 4.0;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;

    widget.controller?.addListener(() {
      final page = widget.controller!.page?.round() ?? 0;
      if (_currentPage != page) {
        setState(() {
          _currentPage = page;
        });
        _scrollThumbnailToCenter(page);
      }
    });
  }

  @override
  void dispose() {
    _thumbnailScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: indicatorHeight,
      child: ListView.separated(
        shrinkWrap: true,
        controller: _thumbnailScrollController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.images.length,
        itemBuilder: (context, index) {
          final isSelected = index == _currentPage;
          final size = isSelected ? indicatorHeight : _imageHeight;

          var boderColor = Colors.transparent;
          List<BoxShadow>? boxShadow;
          var fillColor = Colors.white24;
          if (isSelected) {
            boderColor = Colors.white;
            boxShadow = [
              const BoxShadow(
                color: Color(0x29000000),
                offset: Offset(0, 4),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ];
            fillColor = Colors.transparent;
          }

          return GestureDetector(
            onTap: () => _goToPage(index),
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: size,
                height: size,
                decoration: BoxDecoration(
                  border: Border.all(color: boderColor, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: boxShadow,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: UIImageView(
                          source: widget.images[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned.fill(child: ColoredBox(color: fillColor)),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const Gap(imageSpacing),
      ),
    );
  }
}

extension on _UIImageIndicatorState {
  void _goToPage(int index) {
    if (_currentPage == index) {
      return;
    }

    widget.controller?.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    widget.onPageChanged?.call(index);
    _scrollThumbnailToCenter(index);
  }

  void _scrollThumbnailToCenter(int index) {
    const itemWidth =
        _UIImageIndicatorState.indicatorHeight -
        _UIImageIndicatorState.imageSpacing;
    final screenWidth = MediaQuery.sizeOf(context).width;

    final offset = (itemWidth * index) - screenWidth / 2 + itemWidth / 2;

    final scrollOffset = offset.clamp(
      _thumbnailScrollController.position.minScrollExtent,
      _thumbnailScrollController.position.maxScrollExtent,
    );

    _thumbnailScrollController.animateTo(
      scrollOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
