import 'package:flutter/material.dart';
import 'package:gds_foundation/gds_foundation.dart';

class GdsPopupRoute<T> extends ModalRoute<T> {
  GdsPopupRoute({
    required this.child,
    this.isBarrierDismissible = false,
  });

  final Widget child;
  final bool isBarrierDismissible;

  @override
  Color get barrierColor => GdsColors.black.withAlpha((0.4 * 255).toInt());

  @override
  bool get barrierDismissible => isBarrierDismissible;

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
      child: Padding(
        padding: EdgeInsets.all(GdsSpacing.spacing20),
        child: Center(
          child: FadeTransition(
            opacity: curvedAnimation,
            child: child,
          ),
        ),
      ),
    );
  }
}
