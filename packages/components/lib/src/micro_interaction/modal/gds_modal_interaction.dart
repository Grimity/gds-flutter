import 'package:flutter/material.dart';
import 'package:gds_foundation/gds_foundation.dart';

/// Figma prototype interaction for modal opening.
///
/// - Trigger: onClick
/// - Action: navigate to
/// - Destination: space로 확인
/// - Animation: smart animate
/// - Curve: ease out
/// - Duration: 300ms
///
/// Usage:
///
/// ```dart
/// GdsModal(
///   title: '제목',
///   body: Container(child: Text('내용')),
/// ).open(context);
/// ```
class GdsModalInteraction {
  const GdsModalInteraction._();

  static const Duration transitionDuration = Duration(milliseconds: 300);
  static const Curve transitionCurve = Curves.easeOut;
  static const double transitionStartOffsetY = 56;

  /// 오버레이에 모달을 화면 중앙에 표시합니다.
  static Future<T?> open<T>(
    BuildContext context, {
    required Widget child,
    bool isBarrierDismissible = false,
  }) {
    return Navigator.of(context).push(
      _GdsModalInteractionRoute<T>(
        child: child,
        isBarrierDismissible: isBarrierDismissible,
      ),
    );
  }
}

/// Wraps a widget with the prototype's "onClick → navigate to → space로 확인" behavior.
class GdsModalTrigger extends StatelessWidget {
  const GdsModalTrigger({
    super.key,
    required this.child,
    required this.modalBuilder,
    this.isBarrierDismissible = false,
  });

  final Widget child;
  final Widget Function(BuildContext context) modalBuilder;
  final bool isBarrierDismissible;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => GdsModalInteraction.open<void>(
        context,
        child: modalBuilder(context),
        isBarrierDismissible: isBarrierDismissible,
      ),
      child: child,
    );
  }
}

class _GdsModalInteractionRoute<T> extends ModalRoute<T> {
  _GdsModalInteractionRoute({
    required this.child,
    required this.isBarrierDismissible,
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
  Duration get transitionDuration => GdsModalInteraction.transitionDuration;

  @override
  Duration get reverseTransitionDuration => GdsModalInteraction.transitionDuration;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: GdsModalInteraction.transitionCurve,
      reverseCurve: GdsModalInteraction.transitionCurve.flipped,
    );

    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: EdgeInsets.all(GdsSpacing.spacing20),
        child: Center(
          child: AnimatedBuilder(
            animation: curvedAnimation,
            child: child,
            builder: (context, child) {
              return Opacity(
                opacity: curvedAnimation.value,
                child: Transform.translate(
                  offset: Offset(
                    0,
                    (1 - curvedAnimation.value) * GdsModalInteraction.transitionStartOffsetY,
                  ),
                  child: child,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
