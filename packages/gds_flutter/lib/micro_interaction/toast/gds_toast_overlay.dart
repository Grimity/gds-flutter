import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 상단에 [GdsToast]를 오버레이로 표시할 때, 관련 애니메이션을 처리하는 위젯.
class GdsToastOverlay extends StatefulWidget {
  const new({
    super.key,
    required this.toast,
    this.duration = const .new(seconds: 20),
    this.animaton = .normal,
    this.slideExtent = 30,
    this.spacing = 8,
    this.onDismissed,
  });

  final GdsToast toast;
  final Duration duration;
  final GdsAnimation animaton;
  final double slideExtent;
  final GdsSpacing spacing;
  final VoidCallback? onDismissed;

  @override
  State<GdsToastOverlay> createState() => _State();
}

class _State extends State<GdsToastOverlay> with TickerProviderStateMixin {
  late final fadeIn = AnimationController(vsync: this, duration: widget.animaton.duration);
  late final fadeOut = AnimationController(vsync: this, duration: widget.animaton.duration);

  @override
  void initState() {
    super.initState();

    // 페이드 애니메이션 시작.
    fadeIn.forward();

    // 지정한 노출 시간 후 페이드 아웃 애니메이션을 실행하고 이후 오버레이 제거.
    Timer(widget.duration, () {
      fadeOut.forward().then((_) => widget.onDismissed?.call());
    });
  }

  @override
  void dispose() {
    fadeIn.dispose();
    fadeOut.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: .transparency,
      child: IgnorePointer(
        child: Align(
          alignment: .topCenter,
          child: Padding(
            padding: .only(top: widget.spacing),
            child: AnimatedBuilder(
              animation: .merge([fadeIn, fadeOut]),
              child: widget.toast,
              builder: (context, child) {
                // 토스트가 나타날 때는 아래에서 위로, 사라질 때는 위로 이동하도록 함.
                final slideExtent = widget.slideExtent;
                final fadeInProgress = widget.animaton.curve.transform(fadeIn.value);
                final fadeOutProgress = widget.animaton.curve.transform(fadeOut.value);
                final fadeInOffset = slideExtent * (1 - fadeInProgress);
                final fadeOutOffset = slideExtent * fadeOutProgress;
                final offsetY = fadeInOffset - fadeOutOffset;
                final opacity = fadeInProgress - fadeOutProgress;

                return Transform.translate(
                  offset: .new(0, offsetY),
                  child: Opacity(
                    opacity: opacity,
                    child: child,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
