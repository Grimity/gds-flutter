import 'package:gds_flutter/gds_flutter.dart';

/// 버튼의 상태별 스타일을 정의하는 레코드.
typedef GdsButtonStyleSet = ({
  GdsButtonStyle enabled,
  GdsButtonStyle disabled,
  GdsButtonStyle loading,
});

/// 버튼의 상태별 색상 스타일을 정의하는 인터페이스.
class GdsButtonStyle {
  const GdsButtonStyle({
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.iconColor,
  });

  final GdsColor? backgroundColor;
  final GdsColor? borderColor;
  final GdsColor? textColor;
  final GdsColor? iconColor;

  /// 지정한 속성만 변경한 새로운 스타일을 반환합니다.
  GdsButtonStyle copyWith({
    GdsColor? backgroundColor,
    GdsColor? borderColor,
    GdsColor? textColor,
    GdsColor? iconColor,
  }) {
    return .new(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      textColor: textColor ?? this.textColor,
      iconColor: iconColor ?? this.iconColor,
    );
  }
}
