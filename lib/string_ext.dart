import 'package:flutter/rendering.dart';

extension NullableStringIsNullOrEmptyExtension on String? {
  /// Returns `true` if the String is either null or empty.
  bool get isNullOrEmpty => this?.isEmpty ?? true;

  bool get isNotNullOrEmpty => !isNullOrEmpty;
}

extension StringValidateExt on String {
  bool isEmail() {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(this);
  }

  bool get isUrl => Uri.parse(this).isAbsolute;

  bool get isLocalUrl {
    return startsWith('/') ||
        startsWith('file://') ||
        (length > 1 && substring(1).startsWith(':\\'));
  }

  bool get isValidPassword {
    final length = this.length;
    final hasLetter = contains(RegExp(r'[a-z]'));
    final hasUpperLetter = contains(RegExp(r'[A-Z]'));
    final hasNumber = contains(RegExp(r'[0-9]'));
    final hasSpecial = contains(RegExp(r'[.,*?!@#\$&*~]'));
    final isValid =
        (length >= 8) && hasLetter && hasNumber && hasUpperLetter && hasSpecial;
    return isValid;
  }

  bool get hasMinLength => length >= 8;

  bool get hasLowercase => RegExp(r'[a-z]').hasMatch(this);

  bool get hasUppercase => RegExp(r'[A-Z]').hasMatch(this);

  bool get hasNumber => RegExp(r'[0-9]').hasMatch(this);

  bool get hasSymbol =>
      RegExp(r'[!@#$%^&*()_\-+={}\[\]\|;:<>,.?\/~`]').hasMatch(this);

  bool get hasNumberOrSymbol =>
      RegExp(r'[0-9!@#$%^&*()_\-+={}\[\]\|;:<>,.?\/~`]').hasMatch(this);
}

extension StringDurationExt on String {
  Duration parseDuration() {
    final duration3Regex = RegExp(r'\d+:\d+:\d+(\.\d+)?');
    final duration2Regex = RegExp(r'\d+:\d+(\.\d+)?');

    var hours = 0;
    var minutes = 0;
    var micros = 0;
    String? formated;
    if (duration3Regex.hasMatch(this)) {
      formated = duration3Regex.firstMatch(this)!.group(0);
    } else if (duration2Regex.hasMatch(this)) {
      formated = duration2Regex.firstMatch(this)!.group(0);
    }
    if (formated.isNullOrEmpty) {
      return Duration.zero;
    }
    final parts = formated!.split(':');
    try {
      if (parts.isNotEmpty) {
        hours = int.parse(parts.first);
      }
      if (parts.length > 1) {
        minutes = int.parse(parts[1]);
      }
      if (parts.length > 2) {
        micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
      }
      return Duration(hours: hours, minutes: minutes, microseconds: micros);
    } catch (_) {
      return Duration.zero;
    }
  }
}

extension StringCalculateWidthExt on String {
  /// Calculate the width of the string based on the given text style.
  double calculateWidth(TextStyle style) {
    final textSpan = TextSpan(text: this, style: style);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size.width;
  }
}
