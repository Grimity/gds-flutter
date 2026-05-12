import 'package:flutter/material.dart';
import 'package:gds_foundation/gds_foundation.dart';

/// 디자인 시스템 전반에서 공통으로 사용하는 [Scaffold] 래퍼입니다.
class GdsScaffold extends StatelessWidget {
  const GdsScaffold({
    super.key,
    required this.body,
    this.appBar,
  });

  /// [Scaffold]의 [body]에 해당하는 위젯입니다.
  final Widget body;

  /// [Scaffold]의 [appBar]에 해당하는 위젯입니다.
  final Widget? appBar;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final Widget child;

    // appBar가 제공된 경우 NestedScrollView로 감싸고, 그렇지 않으면 body를 그대로 사용합니다.
    if (appBar != null) {
      child = NestedScrollView(headerSliverBuilder: (_, _) => [appBar!], body: body);
    } else {
      child = body;
    }

    return Scaffold(
      backgroundColor: colors.bg.primary,
      body: child,
    );
  }
}
