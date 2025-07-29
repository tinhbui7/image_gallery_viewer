import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class UIImageError extends StatelessWidget {
  const UIImageError({
    super.key,
    this.message,
    this.icon,
    this.fontSize,
    this.spacing,
  });

  final String? message;
  final Widget? icon;
  final double? fontSize;
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 34, sigmaY: 34),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(92, 106, 124, 0.72),
              Color.fromRGBO(11, 25, 48, 0.72),
            ],
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraint) {
            final width = min(
              constraint.maxWidth,
              MediaQuery.sizeOf(context).width,
            );
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 6),
              child: FittedBox(
                child: Column(
                  spacing: spacing ?? 8.0,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon ??
                        Icon(Icons.error, color: Color(0xFFF6F9FF), size: 24.0),
                    Text(message ?? 'Load Image Error'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
