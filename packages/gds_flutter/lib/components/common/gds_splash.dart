import 'package:animations/animations.dart';
import 'package:flutter/widgets.dart';
import 'package:gds_flutter/src/reveal_clipper.dart';

/// 화면이 중심에서 원형으로 펼쳐지며 전환되는 스플래시 효과를 적용하는 공통 위젯.
class GdsSplash<T> extends StatelessWidget {
  const new({
    super.key,
    required this.builder,
  });

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      duration: .new(milliseconds: 500),
      transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
        return ClipPath(
          clipper: RevealClipper(
            animation: primaryAnimation.drive(CurveTween(curve: Curves.ease)),
          ),
          child: child,
        );
      },
      child: builder(context),
    );
  }
}
