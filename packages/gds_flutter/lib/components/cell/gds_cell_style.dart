import 'package:gds_flutter/gds_flutter.dart';

/// 셀의 상태별 색상과 테두리 스타일을 정의하는 인터페이스.
class GdsCellStyle {
  const new({
    this.backgroundColor,
    this.border,
    this.iconColor,
    required this.textColor,
  });

  final GdsColor? backgroundColor;
  final GdsBorder? border;
  final GdsColor? iconColor;
  final GdsColor textColor;

  /// 지정한 속성만 변경한 새로운 스타일을 반환합니다.
  GdsCellStyle copyWith({
    GdsColor? backgroundColor,
    GdsBorder? border,
    GdsColor? textColor,
    GdsColor? iconColor,
  }) {
    return .new(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      border: border ?? this.border,
      textColor: textColor ?? this.textColor,
      iconColor: iconColor ?? this.iconColor,
    );
  }
}
