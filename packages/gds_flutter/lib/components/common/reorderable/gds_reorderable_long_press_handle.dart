// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

// ignore_for_file: gds_lints/prefer_gds_gesture

part of 'gds_reorderable.dart';

/// 길게 누르기 제스처로 정렬 항목에 대한 드래그 상태를 전달하는 위젯.
class GdsReorderableLongPressHandle extends StatelessWidget {
  const new({
    super.key,
    required this.index,
    required this.child,
  });

  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (details) {
        final notification = GdsReorderableStartNotification(
          index: index,
          globalPosition: details.globalPosition,
        );

        notification.notify(context);
        HapticFeedback.lightImpact();
      },
      onLongPressMoveUpdate: (details) {
        final notification = GdsReorderableUpdateNotification(
          globalPosition: details.globalPosition,
        );

        notification.notify(context);
      },
      onLongPressEnd: (details) {
        GdsReorderableEndNotification(canceled: false).notify(context);
      },
      onLongPressCancel: () {
        final notification = GdsReorderableEndNotification(canceled: true);

        // 해당 항목을 드래그하고 있을 경우에만.
        if (notification.renderObject(context).dragIndex == index) {
          notification.notify(context);
        }
      },
      child: child,
    );
  }
}
