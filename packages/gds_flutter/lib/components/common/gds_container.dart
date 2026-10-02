// ignore_for_file: gds_lints/prefer_gds_container

import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 디자인 시스템 전반에서 공통으로 사용하는 [Container] 래퍼 위젯.
class GdsContainer extends StatelessWidget {
  const GdsContainer({
    super.key,
    this.width,
    this.height,
    this.minWidth,
    this.minHeight,
    this.maxWidth,
    this.maxHeight,
    this.color,
    this.opacity,
    this.border,
    this.radius,
    this.shadow,
    this.shape = .rectangle,
    this.padding,
    this.margin,
    this.alignment,
    this.animation = .normal,
    this.clip = false,
    this.child,
  });

  final double? width;
  final double? height;
  final double? minWidth;
  final double? minHeight;
  final double? maxWidth;
  final double? maxHeight;
  final GdsColor? color;
  final GdsOpacity? opacity;
  final GdsBorder? border;
  final GdsRadius? radius;
  final GdsShadow? shadow;
  final BoxShape shape;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Alignment? alignment;
  final GdsAnimation animation;
  final bool clip;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final Clip clipBehavior = clip ? .antiAlias : .none;

    // 크기 제약.
    final constraints = BoxConstraints(
      minWidth: minWidth ?? 0,
      minHeight: minHeight ?? 0,
      maxWidth: maxWidth ?? double.infinity,
      maxHeight: maxHeight ?? double.infinity,
    );

    // 기본 외형 베이스.
    final decoration = BoxDecoration(
      shape: shape,
      borderRadius: radius?.all,
    );

    return Stack(
      children: [
        // 뒤쪽은 배경색, 그림자 표시
        Positioned.fill(
          child: AnimatedContainer(
            duration: animation.duration,
            curve: animation.curve,
            decoration: decoration.copyWith(
              color: color?.of(context).withAlphaIf(opacity?.alpha),
              boxShadow: shadow != null ? [shadow!.outer] : null,
            ),
          ),
        ),

        // 레이아웃(e.g. 크기, 정렬)
        AnimatedContainer(
          duration: animation.duration,
          curve: animation.curve,
          width: width,
          height: height,
          constraints: constraints,
          padding: padding,
          margin: margin,
          alignment: alignment,
          decoration: decoration,
          clipBehavior: clipBehavior,
          child: child,
        ),

        // 앞쪽은 보더 표시
        Positioned.fill(
          child: IgnorePointer(
            ignoring: true,
            child: AnimatedContainer(
              duration: animation.duration,
              curve: animation.curve,
              decoration: decoration.copyWith(border: border?.of(context)),
              clipBehavior: clipBehavior,
            ),
          ),
        ),
      ],
    );
  }
}
