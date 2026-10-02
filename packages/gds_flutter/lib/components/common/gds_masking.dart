import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/src/edge_clipper.dart';

/// 스크롤 가능한 자식의 시작과 끝 지점에 페이드 마스크를 표시하는 위젯.
class GdsMasking extends StatefulWidget {
  const GdsMasking({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<GdsMasking> createState() => _GdsMaskingState();
}

class _GdsMaskingState extends State<GdsMasking> {
  /// 스크롤 시작 지점에 마스크를 표시할지 여부.
  bool canMaskAtStart = false;

  /// 스크롤 끝 지점에 마스크를 표시할지 여부.
  bool canMaskAtEnd = false;

  /// 마스크를 적용할 스크롤 방향.
  Axis? axis;

  /// 스크롤 위치에 따라 마스킹 적용 여부를 계산하여 상태를 변경합니다.
  void updateMask(ScrollMetrics metrics) {
    final newAxis = metrics.axis;
    final needsMasking = metrics.maxScrollExtent > 0;

    // 현재 스크롤 위치가 시작점·끝점에서 떨어져 있는지 확인.
    final isNotAtStart = metrics.pixels > metrics.minScrollExtent;
    final isNotAtEnd = metrics.pixels < metrics.maxScrollExtent;

    // 스크롤 가능한 영역이 남아 있는 방향에만 마스크를 표시.
    final newCanMaskAtStart = needsMasking && isNotAtStart;
    final newCanMaskAtEnd = needsMasking && isNotAtEnd;

    final axisChanged = axis != newAxis;
    final maskAtStartChanged = canMaskAtStart != newCanMaskAtStart;
    final maskAtEndChanged = canMaskAtEnd != newCanMaskAtEnd;

    // 마스크 상태가 바뀐 경우에만 다시 리빌드.
    if (axisChanged || maskAtStartChanged || maskAtEndChanged) {
      setState(() {
        axis = newAxis;
        canMaskAtStart = newCanMaskAtStart;
        canMaskAtEnd = newCanMaskAtEnd;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: .passthrough,
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            updateMask(notification.metrics);
            return false;
          },
          child: NotificationListener<ScrollMetricsNotification>(
            onNotification: (notification) {
              updateMask(notification.metrics);
              return false;
            },
            child: ClipRect(
              clipper: EdgeClipper(
                top: axis == .vertical ? canMaskAtStart : false,
                bottom: axis == .vertical ? canMaskAtEnd : false,
                left: axis == .horizontal ? canMaskAtStart : false,
                right: axis == .horizontal ? canMaskAtEnd : false,
              ),
              child: widget.child,
            ),
          ),
        ),

        if (axis != null) ...[
          // 상단 혹은 좌측에서 마스킹 표시
          Positioned(
            top: 0,
            left: 0,
            right: axis == .vertical ? 0 : null,
            bottom: axis == .vertical ? null : 0,
            child: buildMasking(
              visible: canMaskAtStart,
              begin: axis == .vertical ? .topCenter : .centerLeft,
              end: axis == .vertical ? .bottomCenter : .centerRight,
            ),
          ),

          // 하단 혹은 우측에서 마스킹 표시
          Positioned(
            top: axis == .vertical ? null : 0,
            left: axis == .vertical ? 0 : null,
            right: 0,
            bottom: 0,
            child: buildMasking(
              visible: canMaskAtEnd,
              begin: axis == .vertical ? .bottomCenter : .centerRight,
              end: axis == .vertical ? .topCenter : .centerLeft,
            ),
          ),
        ],
      ],
    );
  }

  /// 지정한 방향과 표시 상태에 맞춰 페이드 마스크를 표시하는 위젯.
  Widget buildMasking({
    required bool visible,
    required Alignment begin,
    required Alignment end,
  }) {
    return GdsFadable.builder(
      type: .fade,
      visible: visible,
      animation: .normal,
      builder: (context) {
        final baseColor = GdsColor.surfaceBase.of(context);

        return IgnorePointer(
          // ignore: gds_lints/prefer_gds_container
          child: Container(
            width: axis == .vertical ? .infinity : 40,
            height: axis == .vertical ? 40 : .infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: begin,
                end: end,
                colors: [
                  baseColor.withAlpha(255),
                  baseColor.withAlpha(0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
