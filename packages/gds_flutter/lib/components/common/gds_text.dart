// ignore_for_file: gds_lints/prefer_gds_text

import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 디자인 시스템 전반에서 공통으로 사용하는 [Text] 래퍼 위젯.
class GdsText extends StatelessWidget {
  const new(
    String this.text, {
    super.key,
    required this.color,
    required this.style,
    this.animation = .normal,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.strutStyle,
    this.textDirection,
  }) : span = null;

  /// 여러 스타일이 적용된 텍스트를 표시하는 위젯.
  const new rich(
    InlineSpan this.span, {
    super.key,
    required this.color,
    required this.style,
    this.animation = .normal,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.strutStyle,
    this.textDirection,
  }) : text = null;

  final String? text;
  final InlineSpan? span;
  final GdsColor color;
  final GdsTypography style;
  final GdsAnimation animation;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      duration: animation.duration,
      curve: animation.curve,
      style: style.style.copyWith(color: color.of(context)),
      child: span == null
          ? Text(
              text!,
              maxLines: maxLines,
              overflow: overflow,
              textAlign: textAlign,
              strutStyle: strutStyle,
              textDirection: textDirection,
            )
          : Text.rich(
              span!,
              maxLines: maxLines,
              overflow: overflow,
              textAlign: textAlign,
              strutStyle: strutStyle,
              textDirection: textDirection,
            ),
    );
  }
}

/// 디자인 시스템 전반에서 공통으로 사용하는 [TextSpan].
class GdsTextSpan extends TextSpan {
  new(
    String? text,
    BuildContext context, {
    GdsColor? color,
    GdsTypography? style,
    super.children,
  }) : super(
         text: text,
         style: style?.style.copyWith(color: color?.of(context)),
       );
}
