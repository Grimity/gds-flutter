import 'package:animations/animations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cached_transition/flutter_cached_transition.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 페이지 상태를 유지하며 전환 애니메이션을 적용하는 공통 위젯.
class GdsPageTransition<T> extends StatelessWidget {
  const new({
    super.key,
    this.animation = .slow,
    required this.child,
  });

  final GdsAnimation animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      clipBehavior: .hardEdge,
      child: CachedTransition(
        transitionBuilder: transitionBuilder,
        duration: animation.duration,
        curve: animation.curve,
        child: child,
      ),
    );
  }

  /// 페이지 전환 시 [child]에 수직 공유 축 전환 애니메이션을 적용하는 빌더.
  Widget transitionBuilder(
    Widget child,
    Animation<double> primaryAnimation,
    Animation<double> secondaryAnimation,
  ) {
    return SharedAxisTransition(
      transitionType: .vertical,
      animation: primaryAnimation,
      secondaryAnimation: secondaryAnimation,
      fillColor: GdsAtomicColor.transparent,
      child: child,
    );
  }
}
