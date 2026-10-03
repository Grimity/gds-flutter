import 'package:flutter/widgets.dart';

/// 디자인 시스템에서 제공하는 [num]에 대한 유틸리티 확장.
extension GdsNumberExtension on num {
  /// 숫자를 축약 표기하기 위한 기준 나눗수와 단위 접미사 목록.
  static const _compactUnits = [
    (divisor: 1e16, suffix: '경'),
    (divisor: 1e12, suffix: '조'),
    (divisor: 1e8, suffix: '억'),
    (divisor: 1e4, suffix: '만'),
    (divisor: 1e3, suffix: '천'),
  ];

  // Padding
  EdgeInsets get all => .all(toDouble());
  EdgeInsets get vertical => .symmetric(vertical: toDouble());
  EdgeInsets get horizontal => .symmetric(horizontal: toDouble());
  EdgeInsets get top => .only(top: toDouble());
  EdgeInsets get left => .only(left: toDouble());
  EdgeInsets get right => .only(right: toDouble());
  EdgeInsets get bottom => .only(bottom: toDouble());

  // Gap
  SizedBox get verticalGap => .new(height: toDouble());
  SizedBox get horizontalGap => .new(width: toDouble());

  /// 숫자의 정수 부분을 세 자리마다 쉼표로 구분합니다.
  String get comma {
    final parts = toString().split('.');
    final integer = parts.first.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (_) => ',',
    );

    return parts.length == 1 ? integer : '$integer.${parts.skip(1).join('.')}';
  }

  /// 숫자를 천, 만, 억, 조, 경 단위의 간결한 문자열로 반환합니다.
  String get compact {
    assert(this >= 0);

    // 숫자를 소수점 한 자리까지 축약 표기합니다.
    String formatCompactNumber(double value) {
      final truncated = (value * 10).floor() / 10;
      return truncated == truncated.truncateToDouble() ? truncated.toInt().toString() : truncated.toStringAsFixed(1);
    }

    final value = toDouble();
    if (value.isInfinite) return '∞';

    for (final unit in _compactUnits) {
      if (value < unit.divisor) continue;

      final scaled = value / unit.divisor;
      final number = scaled >= 1000 ? scaled.compact : formatCompactNumber(scaled);

      return '$number${unit.suffix}';
    }

    return formatCompactNumber(value);
  }
}
