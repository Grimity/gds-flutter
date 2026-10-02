import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 입력 필드의 크기와 콘텐츠 유형에 따른 배치 정보를 정의하는 인터페이스.
class GdsInputDecoration {
  const GdsInputDecoration({
    required this.typography,
    required this.spacing,
    this.border,
    this.radius,
    required this.padding,
    this.size = .none,
    this.alignment = .center,
  });

  final GdsTypography typography;
  final GdsSpacing spacing;
  final GdsBorder? border;
  final GdsRadius? radius;
  final EdgeInsets padding;

  /// 입력 필드에 적용하는 고정 크기.
  final GdsControlSize size;
  final CrossAxisAlignment alignment;

  /// 지정한 속성만 변경한 새로운 배치 정보를 반환합니다.
  GdsInputDecoration copyWith({
    GdsTypography? typography,
    GdsSpacing? spacing,
    GdsBorder? border,
    GdsRadius? radius,
    EdgeInsets? padding,
    GdsControlSize? size,
    CrossAxisAlignment? alignment,
  }) {
    return .new(
      typography: typography ?? this.typography,
      spacing: spacing ?? this.spacing,
      border: border ?? this.border,
      radius: radius ?? this.radius,
      padding: padding ?? this.padding,
      size: size ?? this.size,
      alignment: alignment ?? this.alignment,
    );
  }
}
