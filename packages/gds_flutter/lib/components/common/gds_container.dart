// ignore_for_file: gds_lints/prefer_gds_container

import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 디자인 시스템 전반에서 공통으로 사용하는 [Container] 래퍼 위젯.
class GdsContainer extends StatelessWidget {
  const new({
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
    this.borderRadius,
    this.radius,
    this.shadow,
    this.gradient,
    this.shape = .rectangle,
    this.padding,
    this.margin,
    this.alignment,
    this.animation = .normal,
    this.clip = false,
    this.child,
  }) : assert(
         radius == null || borderRadius == null,
         'radius와 borderRadius는 동시에 사용할 수 없습니다.',
       );

  final double? width;
  final double? height;
  final double? minWidth;
  final double? minHeight;
  final double? maxWidth;
  final double? maxHeight;
  final GdsColor? color;
  final GdsOpacity? opacity;
  final GdsBorder? border;
  final GdsBorderRadius? borderRadius;
  final GdsRadius? radius;
  final GdsShadow? shadow;
  final Gradient? gradient;
  final BoxShape shape;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Alignment? alignment;
  final GdsAnimation animation;
  final bool clip;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final Clip clipBehavior = clip ? .hardEdge : .none;

    // 크기 제약.
    final constraints = BoxConstraints(
      minWidth: minWidth ?? 0,
      minHeight: minHeight ?? 0,
      maxWidth: maxWidth ?? .infinity,
      maxHeight: maxHeight ?? .infinity,
    );

    // 기본 외형 베이스.
    final decoration = BoxDecoration(
      shape: shape,
      borderRadius: radius?.geometry ?? borderRadius?.geometry,
    );

    return Stack(
      children: [
        // 레이아웃(e.g. 크기, 정렬, 배경색, 그림자)
        AnimatedContainer(
          duration: animation.duration,
          curve: animation.curve,
          width: width,
          height: height,
          constraints: constraints,
          padding: padding,
          margin: margin,
          alignment: alignment,
          decoration: decoration.copyWith(
            color: color?.of(context).withAlphaIf(opacity?.alpha),
            gradient: gradient,
            boxShadow: shadow != null ? [shadow!.outer] : null,
          ),
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
