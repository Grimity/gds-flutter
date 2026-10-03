import 'package:gds_flutter/gds_flutter.dart';

/// 필터의 상태별 색상과 여러 스타일을 정의하는 인터페이스.
class GdsFilterStyle {
  const new({
    this.backgroundColor,
    this.iconColor = .iconGrayBold,
    this.textColor = .textGrayBold,
    this.border,
  });

  final GdsColor? backgroundColor;
  final GdsColor iconColor;
  final GdsColor textColor;
  final GdsBorder? border;
}
