import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 버튼의 레이아웃 유형을 나타내는 열거형.
enum GdsButtonType {
  iconOnly,
  textOnly,
  leadingIcon,
  trailingIcon,
}

/// 버튼의 크기와 콘텐츠 유형에 따른 배치 정보를 정의하는 인터페이스.
class GdsButtonDecoration {
  const new({
    this.iconOnly = .zero,
    this.textOnly = .zero,
    this.leadingIcon = .zero,
    this.trailingIcon = .zero,
    required this.typography,
    required this.iconSize,
    required this.spacing,
    required this.radius,
    this.size = .none,
  });

  final EdgeInsets iconOnly;
  final EdgeInsets textOnly;
  final EdgeInsets leadingIcon;
  final EdgeInsets trailingIcon;
  final GdsTypography typography;
  final GdsSpacing iconSize;
  final GdsSpacing spacing;
  final GdsRadius radius;
  final GdsControlSize size;

  /// 주어진 버튼 유형에 해당하는 콘텐츠 여백을 반환합니다.
  EdgeInsets of(GdsButtonType type) => switch (type) {
    .iconOnly => iconOnly,
    .textOnly => textOnly,
    .leadingIcon => leadingIcon,
    .trailingIcon => trailingIcon,
  };

  /// 지정한 속성만 변경한 새로운 배치 정보를 반환합니다.
  GdsButtonDecoration copyWith({
    EdgeInsets? iconOnly,
    EdgeInsets? textOnly,
    EdgeInsets? leadingIcon,
    EdgeInsets? trailingIcon,
    GdsTypography? typography,
    GdsSpacing? iconSize,
    GdsSpacing? spacing,
    GdsRadius? radius,
    GdsControlSize? size,
  }) {
    return .new(
      iconOnly: iconOnly ?? this.iconOnly,
      textOnly: textOnly ?? this.textOnly,
      leadingIcon: leadingIcon ?? this.leadingIcon,
      trailingIcon: trailingIcon ?? this.trailingIcon,
      typography: typography ?? this.typography,
      iconSize: iconSize ?? this.iconSize,
      spacing: spacing ?? this.spacing,
      radius: radius ?? this.radius,
      size: size ?? this.size,
    );
  }
}
