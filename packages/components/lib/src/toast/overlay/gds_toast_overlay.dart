import 'package:flutter/widgets.dart';
import 'package:gds_components/src/micro_interaction/toast/gds_toast_interaction.dart';
import 'package:gds_components/src/toast/gds_toast.dart';

class GdsToastOverlay extends StatefulWidget {
  const GdsToastOverlay({
    super.key,
    required this.toast,
    this.duration = const Duration(seconds: 20),
    this.fadeDuration = const Duration(milliseconds: 200),
    this.fadeCurve = Curves.easeOut,
    this.fadeExtent = -GdsToastInteraction.defaultInitialOffsetY,
    this.onDismissed,
  });

  /// 오버레이에 표시할 토스트 위젯
  final GdsToast toast;

  /// 토스트가 화면에 표시되는 시간
  final Duration duration;

  /// 토스트 페이드 애니메이션 시간
  final Duration fadeDuration;

  /// 토스트 페이드 애니메이션 곡선
  final Curve fadeCurve;

  /// 토스트 페이드 애니메이션 거리
  final double fadeExtent;

  /// 토스트가 사라질 때 호출되는 콜백
  final VoidCallback? onDismissed;

  @override
  State<GdsToastOverlay> createState() => _GdsToastOverlayState();
}

class _GdsToastOverlayState extends State<GdsToastOverlay> {
  @override
  Widget build(BuildContext context) {
    return GdsToastInteraction(
      visibleDuration: widget.duration,
      enterDuration: widget.fadeDuration,
      exitDuration: widget.fadeDuration,
      enterCurve: widget.fadeCurve,
      exitCurve: widget.fadeCurve,
      initialOffsetY: -widget.fadeExtent.abs(),
      onDismissed: widget.onDismissed,
      child: widget.toast,
    );
  }
}
