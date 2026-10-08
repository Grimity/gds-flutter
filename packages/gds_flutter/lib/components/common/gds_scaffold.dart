// ignore_for_file: gds_lints/prefer_gds_scaffold

import 'package:flutter/material.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 디자인 시스템 전반에서 공통으로 사용하는 [Scaffold] 래퍼 위젯.
class GdsScaffold extends StatelessWidget {
  const new({
    super.key,
    required this.body,
    this.appBar,
    this.drawer,
    this.backgroundColor = .surfaceBase,
  });

  final Widget body;
  final Widget? appBar;
  final Widget? drawer;
  final GdsColor backgroundColor;

  @override
  Widget build(BuildContext context) {
    Widget child = GdsOverlay(child: body);

    // 앱 바가 제공된 경우 Column으로 래핑.
    if (appBar != null) {
      child = Column(
        children: [
          appBar!,
          Expanded(child: child),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor.of(context),
      endDrawer: drawer,
      body: SafeArea(child: child),
    );
  }

  /// 가장 가까운 [Scaffold]의 오른쪽 드로어를 엽니다.
  static void openDrawer(BuildContext context) {
    return Scaffold.of(context).openEndDrawer();
  }
}
