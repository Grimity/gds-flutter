import 'package:flutter/material.dart';
import 'package:gds_components/src/common/widget/gds_toast_host.dart';
import 'package:gds_foundation/gds_foundation.dart';

/// 디자인 시스템 전반에서 공통으로 사용하는 [Scaffold] 래퍼입니다.
class GdsScaffold extends StatelessWidget {
  const GdsScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.drawer,
  });

  /// [Scaffold]의 [body]에 해당하는 위젯입니다.
  final Widget body;

  /// [Scaffold]의 [appBar]에 해당하는 위젯입니다.
  final Widget? appBar;

  /// [Scaffold.endDrawer]에 해당하는 위젯입니다.
  final Widget? drawer;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final content = GdsToastHost(child: body);

    final Widget child;

    // appBar가 제공된 경우 Column으로 감쌉니다.
    if (appBar != null) {
      child = Column(
        children: [
          appBar!,
          Expanded(child: content),
        ],
      );
    } else {
      child = content;
    }

    return Scaffold(
      backgroundColor: colors.bg.primary,
      endDrawer: drawer,
      body: SafeArea(child: child),
    );
  }
}
