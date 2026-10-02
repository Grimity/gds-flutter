import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 디자인 시스템에서 제공하는 [Color]에 대한 유틸리티 확장.
extension GdsColorExtension on Color {
  // Opacity
  Color get opacity80 => withAlpha(GdsOpacity.opacity80.alpha);
  Color get opacity60 => withAlpha(GdsOpacity.opacity60.alpha);
  Color get opacity40 => withAlpha(GdsOpacity.opacity40.alpha);
  Color get opacity20 => withAlpha(GdsOpacity.opacity20.alpha);
  Color get opacity10 => withAlpha(GdsOpacity.opacity10.alpha);

  /// '#FFFFFF'와 같은 16진수 색상 코드로 변환합니다.
  String toHex({bool includeHashSign = true}) {
    final r = (this.r * 255).round().toRadixString(16).padLeft(2, '0').toUpperCase();
    final g = (this.g * 255).round().toRadixString(16).padLeft(2, '0').toUpperCase();
    final b = (this.b * 255).round().toRadixString(16).padLeft(2, '0').toUpperCase();
    return '#$r$g$b';
  }

  /// 주어진 값이 null이 아닐 때만 [withAlpha]를 적용합니다.
  Color withAlphaIf(int? value) {
    return value != null ? withAlpha(value) : this;
  }
}
