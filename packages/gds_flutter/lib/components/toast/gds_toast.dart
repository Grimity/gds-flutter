// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 상단에 간단한 경고 혹은 안내 메시지를 표시하는 토스트 위젯.
class GdsToast extends StatelessWidget {
  const new({
    super.key,
    this.status = .none,
    required this.message,
  }) : assert(message.length != 0);

  final GdsToastStatus status;
  final String message;

  @override
  Widget build(BuildContext context) {
    final hasIcon = status.icon != null;

    return ClipRRect(
      borderRadius: GdsRadius.full.geometry,
      child: BackdropFilter(
        filter: .blur(sigmaX: 4, sigmaY: 4),
        child: GdsContainer(
          padding: !hasIcon
              ? .symmetric(vertical: 10, horizontal: 12) //
              : .all(10).copyWith(right: 12),
          opacity: .opacity80,
          radius: .full,
          color: .bgBlack,
          child: Row(
            mainAxisSize: .min,
            spacing: 4,
            children: [
              // 아이콘 표시
              if (hasIcon) ...[
                status.icon!.build(size: 16, color: status.color),
              ],

              // 메세지 표시
              GdsText(message, color: .textWhite, style: .label5),
            ],
          ),
        ),
      ),
    );
  }

  /// 현재 화면의 오버레이에 토스트를 표시합니다.
  void open() {
    // 화면 교체 시에도 새 화면의 오버레이가 준비된 뒤 표시할 수 있도록 함.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      late final OverlayEntry entry;

      GdsOverlay.current.insert(
        entry = OverlayEntry(
          builder: (context) {
            return GdsToastOverlay(toast: this, onDismissed: entry.remove);
          },
        ),
      );
    });

    WidgetsBinding.instance.ensureVisualUpdate();
  }

  /// 상태와 메시지를 지정해 현재 화면에 토스트를 표시합니다.
  static void show(
    String message, {
    GdsToastStatus status = .none,
  }) {
    GdsToast(status: status, message: message).open();
  }
}
