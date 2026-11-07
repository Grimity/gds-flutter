// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:animations/animations.dart' hide FadeThroughTransition;
import 'package:flutter/widgets.dart';
import 'package:gds_flutter/foundation/foundation.dart';
import 'package:transition_switcher/transition_switcher.dart';

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
    assert(
      value is! List,
      'List는 내용이 동일하더라도 매번 다른 값으로 비교됩니다. '
      '여러 값을 전환 기준으로 사용하려면 record를 사용하세요.',
    );

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
      child: KeyedSubtree(key: ValueKey(value), child: child),
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
    assert(
      value is! List,
      'List는 내용이 동일하더라도 매번 다른 값으로 비교됩니다. '
      '여러 값을 전환 기준으로 사용하려면 record를 사용하세요.',
    );

    return TransitionSwitcher(
      key: key,
      switchInDuration: animation.duration,
      switchInCurve: animation.curve,
      layoutBuilder: (entries) {
        return _layoutBuilder(alignment, entries);
      },
      transitionBuilder: FadeThroughTransition.builder,
      child: KeyedSubtree(key: ValueKey(value), child: child),
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
    assert(
      value is! List,
      'List는 내용이 동일하더라도 매번 다른 값으로 비교됩니다. '
      '여러 값을 전환 기준으로 사용하려면 record를 사용하세요.',
    );

    return TransitionSwitcher(
      key: key,
      switchInDuration: animation.duration,
      switchInCurve: animation.curve,
      layoutBuilder: (entries) {
        return _layoutBuilder(alignment, entries);
      },
      transitionBuilder: CrossFadeTransition.builder,
      child: KeyedSubtree(key: ValueKey(value), child: child),
    );
  }

  /// 현재 위젯을 기준으로 크기를 결정하고, 이전 위젯을 겹쳐 표시하는 빌더.
  static Widget _layoutBuilder(
    Alignment alignment,
    List<Widget> entries, {
    Key? key,
  }) {
    return TransitionStack(
      key: key,
      alignment: alignment,
      children: entries,
    );
  }
}

/// 디자인 시스템에서 전환 애니메이션을 구현하는 슬리버.
abstract class GdsSliverTransition {
  /// 페이드스루 전환 애니메이션을 구현하는 슬리버.
  static Widget fadeThrough<T>({
    Key? key,
    required T value,
    required Widget child,
    Alignment alignment = .center,
    GdsAnimation animation = .normal,
  }) {
    assert(
      value is! List,
      'List는 내용이 동일하더라도 매번 다른 값으로 비교됩니다. '
      '여러 값을 전환 기준으로 사용하려면 record를 사용하세요.',
    );

    return SliverTransitionSwitcher(
      key: key,
      switchInDuration: animation.duration,
      switchInCurve: animation.curve,
      transitionBuilder: SliverFadeThroughTransition.builder,
      sliver: KeyedSubtree(key: ValueKey(value), child: child),
    );
  }

  /// 페이드 교차 전환 애니메이션을 구현하는 슬리버.
  static Widget crossFade<T>({
    Key? key,
    required T value,
    required Widget child,
    Alignment alignment = .center,
    GdsAnimation animation = .normal,
  }) {
    assert(
      value is! List,
      'List는 내용이 동일하더라도 매번 다른 값으로 비교됩니다. '
      '여러 값을 전환 기준으로 사용하려면 record를 사용하세요.',
    );

    return SliverTransitionSwitcher(
      key: key,
      switchInDuration: animation.duration,
      switchInCurve: animation.curve,
      transitionBuilder: SliverCrossFadeTransition.builder,
      sliver: KeyedSubtree(key: ValueKey(value), child: child),
    );
  }
}
