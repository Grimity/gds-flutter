import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class GdsIconAnimationButton extends HookWidget {
  const GdsIconAnimationButton({
    super.key,
    required this.child,
    required this.onTap,
  });

  final Widget child;
  final VoidCallback onTap;

  static const hitTestBehavior = HitTestBehavior.opaque;

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 160),
    );

    return GestureDetector(
      behavior: hitTestBehavior,
      onTap: () {
        onTap();
        animationController.forward(from: 0);
      },
      child: child
          .animate(controller: animationController)
          .scale(
            duration: 80.ms,
            curve: Curves.easeOut,
            begin: const Offset(1.0, 1.0),
            end: const Offset(1.12, 1.12),
          )
          .then()
          .scale(
            duration: 80.ms,
            curve: Curves.easeIn,
            begin: const Offset(1.12, 1.12),
            end: const Offset(1.0, 1.0),
          ),
    );
  }
}
