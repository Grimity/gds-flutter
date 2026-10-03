import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 입력 필드의 컨트롤러를 통해 위젯을 생성하는 함수.
typedef GdsInputWidgetBuilder = Widget? Function(BuildContext context, TextEditingController controller);

/// 입력 필드의 상태별 스타일을 정의하는 인터페이스.
class GdsInputStyle {
  const new({
    this.backgroundColor = .surfaceBase,
    this.backgroundOpacity,
    this.borderColor,
    this.cursorColor,
    this.textColor,
    this.leadingBuilder,
    this.trailingBuilder,
  });

  final GdsColor backgroundColor;
  final GdsOpacity? backgroundOpacity;
  final GdsColor? borderColor;
  final GdsColor? cursorColor;
  final GdsColor? textColor;
  final GdsInputWidgetBuilder? leadingBuilder;
  final GdsInputWidgetBuilder? trailingBuilder;

  /// 지정한 속성만 변경한 새로운 스타일을 반환합니다.
  GdsInputStyle copyWith({
    GdsColor? backgroundColor,
    GdsOpacity? backgroundOpacity,
    GdsColor? borderColor,
    GdsColor? cursorColor,
    GdsColor? textColor,
    GdsInputWidgetBuilder? leadingBuilder,
    GdsInputWidgetBuilder? trailingBuilder,
  }) {
    return .new(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      backgroundOpacity: backgroundOpacity ?? this.backgroundOpacity,
      borderColor: borderColor ?? this.borderColor,
      cursorColor: cursorColor ?? this.cursorColor,
      textColor: textColor ?? this.textColor,
      leadingBuilder: leadingBuilder ?? this.leadingBuilder,
      trailingBuilder: trailingBuilder ?? this.trailingBuilder,
    );
  }
}
