import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_viewer/image_gallery_viewer.dart';
import 'package:image_gallery_viewer/loading.dart';

import 'ui_image_error.dart';

class UIImageZoom extends StatefulWidget {
  final String url;
  final BoxFit? fit;

  const UIImageZoom({Key? key, required this.url, this.fit}) : super(key: key);

  @override
  State<UIImageZoom> createState() => _UIImageZoomState();
}

typedef DoubleClickAnimationListener = void Function();

class _UIImageZoomState extends State<UIImageZoom>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    Animation? animation;

    Function() animationListener = () {};
    dynamic widgetImage;
    dynamic img;

    if (widget.url.contains('http')) {
      widgetImage = ExtendedImage.network;
      img = widget.url;
    } else if (widget.url.isLocalUrl) {
      widgetImage = ExtendedImage.file;
      img = File(widget.url);
    } else {
      widgetImage = ExtendedImage.asset;
      img = widget.url;
    }

    return widgetImage(
      img,
      enableSlideOutPage: true,
      mode: ExtendedImageMode.gesture,
      fit: widget.fit ?? BoxFit.fitWidth,
      extendedImageGestureKey: GlobalKey<ExtendedImageGestureState>(),
      loadStateChanged: (ExtendedImageState state) {
        if (state.extendedImageLoadState == LoadState.loading) {
          return const UILoading();
        }
        if (state.extendedImageLoadState == LoadState.failed) {
          return const UIImageError();
        }
        return null;
      },
      initGestureConfigHandler: (ExtendedImageState state) {
        return GestureConfig(
          minScale: 0.9,
          animationMinScale: 0.7,
          maxScale: 4.0,
          animationMaxScale: 4.5,
          speed: 1.0,
          inertialSpeed: 100.0,
          initialScale: 1.0,
          inPageView: false,
          initialAlignment: InitialAlignment.center,
          reverseMousePointerScrollDirection: true,
          gestureDetailsIsChanged: (GestureDetails? details) {
            //log(details?.totalScale);
          },
        );
      },
      onDoubleTap: (ExtendedImageGestureState state) {
        ///you can use define pointerDownPosition as you can,
        ///default value is double tap pointer down postion.
        final pointerDownPosition = state.pointerDownPosition;
        final begin = state.gestureDetails!.totalScale!;
        double end;

        animation?.removeListener(animationListener);
        animationController
          ..stop()
          ..reset();

        if (begin == 1) {
          end = 3.0;
        } else {
          end = 1;
        }
        animationListener = () {
          state.handleDoubleTap(
            scale: animation!.value,
            doubleTapPosition: pointerDownPosition,
          );
        };
        animation = animationController.drive(
          Tween<double>(begin: begin, end: end),
        );

        animation!.addListener(animationListener);

        animationController.forward();
      },
    );
  }
}
