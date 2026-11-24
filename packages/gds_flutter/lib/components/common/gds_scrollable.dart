// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/widgets.dart';

/// 스크롤이 활성화했을 때만 자식을 스크롤 영역으로 감싸는 위젯.
class GdsScrollable extends StatelessWidget {
  const new({
    super.key,
    this.enabled = true,
    this.scrollDirection = .vertical,
    this.clipBehavior = .hardEdge,
    this.padding,
    required this.child,
  });

  final bool enabled;
  final Axis scrollDirection;
  final Clip clipBehavior;
  final EdgeInsets? padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (enabled) {
      return SingleChildScrollView(
        scrollDirection: scrollDirection,
        clipBehavior: clipBehavior,
        padding: padding,
        child: child,
      );
    }

    return child;
  }
}
