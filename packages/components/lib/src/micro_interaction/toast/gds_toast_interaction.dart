import 'dart:async';

import 'package:flutter/widgets.dart';

/// Figma prototype interaction for toast alert.
///
/// - State 1: hidden above the settled position.
/// - State 2: visible with a small downward overshoot.
/// - State 3: visible at the settled position.
/// - State 4: hidden in place.
class GdsToastInteraction extends StatefulWidget {
  const GdsToastInteraction({
    super.key,
    required this.child,
    this.visibleDuration = const Duration(seconds: 20),
    this.enterDuration = const Duration(milliseconds: 200),
    this.settleDuration = const Duration(milliseconds: 100),
    this.exitDuration = const Duration(milliseconds: 200),
    this.enterCurve = Curves.easeOut,
    this.settleCurve = Curves.easeOut,
    this.exitCurve = Curves.easeOut,
    this.initialOffsetY = defaultInitialOffsetY,
    this.overshootOffsetY = defaultOvershootOffsetY,
    this.onDismissed,
  });

  static const double defaultInitialOffsetY = -30;
  static const double defaultOvershootOffsetY = 6;

  /// Toast content to animate.
  final Widget child;

  /// Duration that the toast remains visible after entering and settling.
  final Duration visibleDuration;

  /// Duration for state 1 → state 2.
  final Duration enterDuration;

  /// Duration for state 2 → state 3.
  final Duration settleDuration;

  /// Duration for state 3 → state 4.
  final Duration exitDuration;

  /// Curve for state 1 → state 2.
  final Curve enterCurve;

  /// Curve for state 2 → state 3.
  final Curve settleCurve;

  /// Curve for state 3 → state 4.
  final Curve exitCurve;

  /// State 1 vertical offset, based on the Figma toast prototype.
  final double initialOffsetY;

  /// State 2 vertical overshoot, based on the Figma toast prototype.
  final double overshootOffsetY;

  /// Called after the exit animation completes.
  final VoidCallback? onDismissed;

  @override
  State<GdsToastInteraction> createState() => _GdsToastInteractionState();
}

class _GdsToastInteractionState extends State<GdsToastInteraction> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Timer? _dismissTimer;

  late Animation<double> _offsetYAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _configureAnimations();
    _play();
  }

  @override
  void didUpdateWidget(covariant GdsToastInteraction oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.visibleDuration != widget.visibleDuration ||
        oldWidget.enterDuration != widget.enterDuration ||
        oldWidget.settleDuration != widget.settleDuration ||
        oldWidget.exitDuration != widget.exitDuration ||
        oldWidget.initialOffsetY != widget.initialOffsetY ||
        oldWidget.overshootOffsetY != widget.overshootOffsetY ||
        oldWidget.enterCurve != widget.enterCurve ||
        oldWidget.settleCurve != widget.settleCurve ||
        oldWidget.exitCurve != widget.exitCurve) {
      _dismissTimer?.cancel();
      _configureAnimations();
      _play();
    }
  }

  @override
  void dispose() {
    _dismissTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _configureAnimations() {
    _controller.duration = widget.enterDuration + widget.settleDuration;
    _controller.reverseDuration = widget.exitDuration;

    _offsetYAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: widget.initialOffsetY,
          end: widget.overshootOffsetY,
        ).chain(CurveTween(curve: widget.enterCurve)),
        weight: widget.enterDuration.inMicroseconds.toDouble(),
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: widget.overshootOffsetY,
          end: 0,
        ).chain(CurveTween(curve: widget.settleCurve)),
        weight: widget.settleDuration.inMicroseconds.toDouble(),
      ),
    ]).animate(_controller);

    _opacityAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.4, curve: Curves.easeOut),
      reverseCurve: widget.exitCurve,
    );
  }

  void _play() {
    _controller
      ..reset()
      ..forward();

    _dismissTimer = Timer(widget.visibleDuration + widget.enterDuration + widget.settleDuration, () {
      if (!mounted) return;

      _controller.reverse().then((_) {
        if (mounted) {
          widget.onDismissed?.call();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _offsetYAnimation.value),
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: child,
          ),
        );
      },
    );
  }
}
