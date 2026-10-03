import 'package:flutter/material.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 위젯 옆에 또 다른 위젯을 오버레이 형태로 표시하기 위한 모달 라우트입니다.
class GdsPopupRoute<T> extends ModalRoute<T> {
  new({
    required this.barrierDismissible,
    required this.child,
  });

  final Widget child;

  /// 팝업 전환에 적용되는 페이드 애니메이션입니다.
  static const fadeAnimation = GdsAnimation.normal;

  @override
  final bool barrierDismissible;

  @override
  Color get barrierColor => GdsAtomicColor.black.opacity40;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => fadeAnimation.duration;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: fadeAnimation.curve,
    );

    return Material(
      type: .transparency,
      child: GdsContainer(
        padding: .all(16),
        alignment: .center,
        child: FadeTransition(
          opacity: curvedAnimation,
          child: child,
        ),
      ),
    );
  }
}
