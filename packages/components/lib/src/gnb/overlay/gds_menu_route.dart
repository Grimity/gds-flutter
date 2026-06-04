import 'package:flutter/material.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_foundation/gds_foundation.dart';

/// 메뉴를 오버레이에 표시하기 위한 모달 라우트입니다.
class GdsMenuRoute<T> extends ModalRoute<T> {
  GdsMenuRoute({
    required this.child,
    required this.position,
    required this.layerLink,
  });

  /// 오버레이에 표시할 메뉴 위젯
  final Widget child;

  /// 기준 위젯에 맞춰 메뉴를 배치할 가로 위치
  final GdsMenuPosition position;

  /// 기준 위젯과 메뉴 오버레이를 연결하는 링크
  final LayerLink layerLink;

  @override
  Color get barrierColor => GdsColors.transparent;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    );

    return Material(
      type: MaterialType.transparency,
      child: UnconstrainedBox(
        alignment: Alignment.topLeft,
        child: CompositedTransformFollower(
          link: layerLink,
          offset: Offset(0, GdsSpacing.spacing8),
          showWhenUnlinked: false,
          followerAnchor: position.followerAnchor,
          targetAnchor: position.targetAnchor,
          child: FadeTransition(
            opacity: curvedAnimation,
            child: child,
          ),
        ),
      ),
    );
  }
}

extension on GdsMenuPosition {
  Alignment get targetAnchor {
    return switch (this) {
      GdsMenuPosition.left => Alignment.bottomLeft,
      GdsMenuPosition.right => Alignment.bottomRight,
      GdsMenuPosition.center => Alignment.bottomCenter,
    };
  }

  Alignment get followerAnchor {
    return switch (this) {
      GdsMenuPosition.left => Alignment.topLeft,
      GdsMenuPosition.right => Alignment.topRight,
      GdsMenuPosition.center => Alignment.topCenter,
    };
  }
}
