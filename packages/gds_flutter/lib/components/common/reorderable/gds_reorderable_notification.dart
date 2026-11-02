// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

// ignore_for_file: library_private_types_in_public_api

part of 'gds_reorderable.dart';

/// 정렬 항목의 드래그 상태를 전달하는 알림.
abstract class GdsReorderableNotification {
  const new();

  /// 정렬 영역의 렌더 객체를 반환합니다.
  _RenderReorderable renderObject(BuildContext context) {
    return context.findAncestorRenderObjectOfType<_RenderReorderable>()!;
  }

  /// 정렬 영역의 렌더 객체에 드래그 상태를 전달합니다.
  void notify(BuildContext context);
}

/// 정렬 항목의 드래그 시작을 알리는 알림.
class GdsReorderableStartNotification extends GdsReorderableNotification {
  const new({
    required this.index,
    required this.globalPosition,
  });

  final int index;
  final Offset globalPosition;

  @override
  void notify(BuildContext context) {
    renderObject(context).dragStart(index, globalPosition);
  }
}

/// 정렬 항목의 드래그 위치 변경을 알리는 알림.
class GdsReorderableUpdateNotification extends GdsReorderableNotification {
  const new({
    required this.globalPosition,
  });

  final Offset globalPosition;

  @override
  void notify(BuildContext context) {
    renderObject(context).dragUpdate(globalPosition);
  }
}

/// 정렬 항목의 드래그 종료 혹은 취소를 알리는 알림.
class GdsReorderableEndNotification extends GdsReorderableNotification {
  const new({
    this.canceled = false,
  });

  final bool canceled;

  @override
  void notify(BuildContext context) {
    renderObject(context).dragEnd(canceled);
  }
}
