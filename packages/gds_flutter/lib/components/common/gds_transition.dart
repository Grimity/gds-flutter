import 'package:animations/animations.dart';
import 'package:flutter/widgets.dart';
import 'package:gds_flutter/foundation/foundation.dart';

/// 디자인 시스템에서 전환 애니메이션을 구현하는 위젯.
abstract class GdsTransition {
  /// 주어진 값에 따라 자식 위젯에 전환 애니메이션을 적용하는 위젯.
  static Widget builder<T>({
    Key? key,
    required T value,
    required ValueWidgetBuilder<T> builder,
    Widget? child,
    GdsAnimation animation = .normal,
  }) {
    return TweenAnimationBuilder<T>(
      key: key,
      tween: .new(begin: value, end: value),
      duration: animation.duration,
      curve: animation.curve,
      builder: builder,
      child: child,
    );
  }

  /// 축 기반 전환 애니메이션을 구현하는 위젯.
  static Widget sharedAxis<T>({
    Key? key,
    required SharedAxisTransitionType transitionType,
    required T value,
    required Widget child,
    Alignment alignment = .center,
    GdsAnimation animation = .normal,
  }) {
    return PageTransitionSwitcher(
      key: key,
      duration: animation.duration,
      layoutBuilder: (entries) {
        return _layoutBuilder(alignment, entries);
      },
      transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
        return SharedAxisTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          fillColor: GdsAtomicColor.transparent,
          transitionType: transitionType,
          child: child,
        );
      },
      child: KeyedSubtree(key: ValueKey(value.toString()), child: child),
    );
  }

  /// 페이드스루 전환 애니메이션을 구현하는 위젯.
  static Widget fadeThrough<T>({
    Key? key,
    required T value,
    required Widget child,
    Alignment alignment = .center,
    GdsAnimation animation = .normal,
  }) {
    return PageTransitionSwitcher(
      key: key,
      duration: animation.duration,
      layoutBuilder: (entries) {
        return _layoutBuilder(alignment, entries);
      },
      transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
        return FadeThroughTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          fillColor: GdsAtomicColor.transparent,
          child: child,
        );
      },
      child: KeyedSubtree(key: ValueKey(value.toString()), child: child),
    );
  }

  /// 페이드 교차 전환 애니메이션을 구현하는 위젯.
  static Widget crossFade<T>({
    Key? key,
    required T value,
    required Widget child,
    Alignment alignment = .center,
    GdsAnimation animation = .normal,
  }) {
    return AnimatedSwitcher(
      key: key,
      duration: animation.duration,
      switchInCurve: animation.curve,
      switchOutCurve: animation.curve,
      layoutBuilder: (current, previous) {
        return _layoutBuilder(alignment, [...previous, ?current]);
      },
      child: KeyedSubtree(key: ValueKey(value.toString()), child: child),
    );
  }

  static Widget _layoutBuilder(Alignment alignment, List<Widget> entries, {Key? key}) {
    return Stack(key: key, alignment: alignment, children: entries);
  }
}
