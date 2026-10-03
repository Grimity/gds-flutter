import 'package:flutter/material.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 위젯 옆에 또 다른 위젯을 오버레이 형태로 표시하기 위한 모달 라우트입니다.
class GdsPopoverRoute<T> extends ModalRoute<T> {
  new({
    required this.followerAnchor,
    required this.targetAnchor,
    required this.layerLink,
    required this.offset,
    required this.child,
  });

  final Alignment followerAnchor;
  final Alignment targetAnchor;
  final LayerLink layerLink;
  final Offset offset;
  final Widget child;

  /// 팝오버 전환에 적용되는 페이드 애니메이션입니다.
  static const fadeAnimation = GdsAnimation.normal;

  @override
  Color get barrierColor => GdsAtomicColor.transparent;

  @override
  bool get barrierDismissible => true;

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
    final CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: fadeAnimation.curve,
    );

    return Material(
      type: .transparency,
      child: UnconstrainedBox(
        alignment: .topLeft,
        child: CompositedTransformFollower(
          link: layerLink,
          offset: offset,
          followerAnchor: followerAnchor,
          targetAnchor: targetAnchor,
          showWhenUnlinked: false,
          child: FadeTransition(
            opacity: curvedAnimation,
            child: child,
          ),
        ),
      ),
    );
  }
}
