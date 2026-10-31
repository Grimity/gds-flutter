// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/widgets.dart';

/// 스크롤 영역에서 자식이 화면 밖으로 나가도 상태를 유지하도록 하는 래퍼 위젯.
class KeepAliveWrapper extends StatefulWidget {
  const new({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<KeepAliveWrapper> createState() => _State();
}

class _State extends State<KeepAliveWrapper> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
