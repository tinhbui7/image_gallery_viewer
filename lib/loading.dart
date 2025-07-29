import 'package:flutter/cupertino.dart';

class UILoading extends StatelessWidget {
  final Brightness? brightness;
  final double radius;

  const UILoading({super.key, this.brightness, this.radius = 15});

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: CupertinoTheme.of(context),
      child: CupertinoActivityIndicator(radius: radius),
    );
  }
}
