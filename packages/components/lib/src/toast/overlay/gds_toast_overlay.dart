import 'package:flutter/widgets.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_foundation/gds_foundation.dart';

class GdsToastOverlay extends StatefulWidget {
  const GdsToastOverlay({
    super.key,
    required this.toast,
    this.duration = const Duration(seconds: 20),
    this.fadeDuration = const Duration(milliseconds: 200),
    this.fadeCurve = Curves.easeOut,
    this.fadeExtent = GdsSpacing.spacing12,
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

class _GdsToastOverlayState extends State<GdsToastOverlay> with SingleTickerProviderStateMixin {
  late final AnimationController _animation = AnimationController(vsync: this, duration: widget.fadeDuration);
  late final CurvedAnimation _curvedAnimation = CurvedAnimation(parent: _animation, curve: widget.fadeCurve);

  @override
  void initState() {
    super.initState();

    // 토스트가 나타나는 애니메이션을 시작합니다.
    _animation.forward();

    // 지정된 시간 이후에 토스트가 사라지는 애니메이션을 시작합니다.
    Future.delayed(widget.duration, () {
      _animation.reverse().then((value) {
        if (mounted) {
          widget.onDismissed?.call();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final animValue = _curvedAnimation.value;

        return Transform.translate(
          offset: Offset(0, (widget.fadeExtent * animValue) - widget.fadeExtent),
          child: Opacity(
            opacity: animValue,
            child: widget.toast,
          ),
        );
      },
    );
  }
}
