import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gds_components/src/common/common.dart';

class GdsIconTapScaleAnimation extends StatelessWidget {
  const GdsIconTapScaleAnimation({
    super.key,
    required this.controller,
    required this.child,
  });

  static const Duration _scaleDuration = Duration(milliseconds: 80);
  static const Offset _beginScale = Offset(1.0, 1.0);
  static const Offset _endScale = Offset(1.12, 1.12);

  final AnimationController controller;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child
        .animate(controller: controller)
        .scale(
          duration: _scaleDuration,
          curve: Curves.easeOut,
          begin: _beginScale,
          end: _endScale,
        )
        .then()
        .scale(
          duration: _scaleDuration,
          curve: Curves.easeIn,
          begin: _endScale,
          end: _beginScale,
        );
  }
}

class GdsIconAnimationButton extends HookWidget {
  const GdsIconAnimationButton({
    super.key,
    required this.child,
    required this.onTap,
  });

  final Widget child;
  final VoidCallback onTap;

  static const _animationDuration = Duration(milliseconds: 160);

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: _animationDuration,
    );

    return GdsGesture(
      onTap: () {
        onTap();
        animationController.forward(from: 0);
      },
      child: GdsIconTapScaleAnimation(
        controller: animationController,
        child: child,
      ),
    );
  }
}
