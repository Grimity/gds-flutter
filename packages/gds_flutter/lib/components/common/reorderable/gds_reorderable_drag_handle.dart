// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

// ignore_for_file: gds_lints/prefer_gds_gesture

part of 'gds_reorderable.dart';

/// 드래그 제스처로 정렬 항목에 대한 드래그 상태를 전달하는 위젯.
class GdsReorderableDragHandle extends StatelessWidget {
  const new({
    super.key,
    required this.index,
    required this.child,
  });

  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final reorderable = context.findAncestorWidgetOfExactType<GdsReorderable>();
    if (reorderable == null) {
      throw StateError('GdsReorderableDragHandle은 GdsReorderable 내부에서만 사용해야 합니다.');
    }

    if (reorderable.axis == .vertical) {
      return GestureDetector(
        onVerticalDragStart: (details) => onDragStart(context, details),
        onVerticalDragUpdate: (details) => onDragUpdate(context, details),
        onVerticalDragEnd: (_) => onDragEnd(context, false),
        onVerticalDragCancel: () => onDragEnd(context, true),
        child: child,
      );
    } else {
      return GestureDetector(
        onHorizontalDragStart: (details) => onDragStart(context, details),
        onHorizontalDragUpdate: (details) => onDragUpdate(context, details),
        onHorizontalDragEnd: (_) => onDragEnd(context, false),
        onHorizontalDragCancel: () => onDragEnd(context, true),
        child: child,
      );
    }
  }

  /// 항목의 드래그 시작을 알립니다.
  void onDragStart(BuildContext context, DragStartDetails details) {
    final notification = GdsReorderableStartNotification(
      index: index,
      globalPosition: details.globalPosition,
    );

    notification.notify(context);
  }

  /// 드래그 중인 포인터의 위치 변경을 알립니다.
  void onDragUpdate(BuildContext context, DragUpdateDetails details) {
    final notification = GdsReorderableUpdateNotification(
      globalPosition: details.globalPosition,
    );

    notification.notify(context);
  }

  /// 해당 항목의 드래그 종료 혹은 취소를 알립니다.
  void onDragEnd(BuildContext context, bool canceled) {
    final notification = GdsReorderableEndNotification(canceled: canceled);

    // 해당 항목을 드래그하고 있을 경우에만.
    if (notification.renderObject(context).dragIndex == index) {
      notification.notify(context);
    }
  }
}
