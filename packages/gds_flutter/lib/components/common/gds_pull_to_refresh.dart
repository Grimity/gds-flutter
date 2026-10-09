import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_refresh_indicator/flutter_refresh_indicator.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 디자인 시스템 전반에서 공통으로 사용하는 [PullToRefresh] 래퍼 위젯.
class GdsPullToRefresh extends StatelessWidget {
  const new({
    super.key,
    required this.onRefresh,
    required this.enabled,
    required this.child,
  });

  final AsyncCallback onRefresh;
  final bool enabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        progressIndicatorTheme: .new(
          // 전경 색상.
          color: GdsColor.surfaceGraySubtler.of(context),

          // 배경 색상.
          refreshBackgroundColor: GdsColor.graphicBold.of(context),
        ),
      ),
      child: PullToRefresh(
        onRefresh: onRefresh,
        enabled: enabled,
        child: child,
      ),
    );
  }
}
