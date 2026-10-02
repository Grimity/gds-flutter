import 'package:gds_flutter/gds_flutter.dart';

/// 디자인 시스템에서 제공하는 [GdsBorder]에 대한 유틸리티 확장.
extension GdsBorderExtension on GdsBorder {
  /// 기존 테두리를 지정된 값으로 변경한 복사본을 반환합니다.
  GdsBorder copyWith({GdsColor? color, double? width}) {
    return .new(
      color: color ?? this.color,
      top: top > 0 ? width ?? top : top,
      left: left > 0 ? width ?? left : left,
      right: right > 0 ? width ?? right : right,
      bottom: bottom > 0 ? width ?? bottom : bottom,
    );
  }
}
