// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:paint_order_flex/paint_order_flex.dart';

part 'gds_reorderable_drag_handle.dart';
part 'gds_reorderable_long_press_handle.dart';
part 'gds_reorderable_notification.dart';

/// 자식 위젯을 가로 혹은 세로로 배치하는 정렬 위젯.
class GdsReorderable extends StatelessWidget {
  const new({
    super.key,
    required this.axis,
    this.spacing = 0,
    this.header,
    this.footer,
    this.scroll = false,
    this.indicatorColor = .borderPrimaryNormal,
    required this.onReorder,
    required this.itemCount,
    required this.itemBuilder,
  }) : assert(spacing >= 0);

  final Axis axis;
  final GdsSpacing spacing;
  final Widget? header;
  final Widget? footer;
  final bool scroll;
  final GdsColor indicatorColor;
  final ReorderCallback onReorder;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  @override
  Widget build(BuildContext context) {
    final reorderable = _Reorderable(
      key: key,
      axis: axis,
      spacing: spacing,
      onReorder: onReorder,
      indicatorColor: indicatorColor.of(context),
      children: .generate(itemCount, (index) {
        return Builder(
          builder: (context) {
            return itemBuilder(context, index);
          },
        );
      }),
    );

    // 배치 방향에 따라 헤더, 정렬 항목, 푸터 표시.
    final child = PaintOrderFlex(
      mainAxisSize: .min,
      direction: axis,
      spacing: spacing,
      children: [
        ?header,

        // 드래그 중인 항목이 헤더와 푸터보다 위에 표시되도록 지정.
        PaintOrder(order: 1, child: reorderable),
        ?footer,
      ],
    );

    return GdsScrollable(
      enabled: scroll,
      scrollDirection: axis,
      clipBehavior: .none,
      child: child,
    );
  }
}

class _Reorderable extends MultiChildRenderObjectWidget {
  const new({
    super.key,
    super.children,
    required this.axis,
    required this.spacing,
    required this.onReorder,
    required this.indicatorColor,
  });

  final Axis axis;
  final double spacing;
  final ReorderCallback onReorder;
  final Color indicatorColor;

  @override
  _RenderReorderable createRenderObject(BuildContext context) {
    return _RenderReorderable(
      axis: axis,
      spacing: spacing,
      onReorder: onReorder,
      indicatorColor: indicatorColor,
      scrollable: Scrollable.maybeOf(context, axis: axis),
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderReorderable renderObject) {
    renderObject
      ..axis = axis
      ..spacing = spacing
      ..onReorder = onReorder
      ..indicatorColor = indicatorColor
      ..scrollable = Scrollable.maybeOf(context, axis: axis);
  }
}

class _RenderReorderable extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, _ParentData>, RenderBoxContainerDefaultsMixin<RenderBox, _ParentData> {
  new({
    required this._axis,
    required this._spacing,
    required this._indicatorColor,
    required this.onReorder,
    this._scrollable,
  });

  ReorderCallback onReorder;

  /// 정렬 영역을 포함하는 상위 스크롤 영역.
  ScrollableState? _scrollable;

  set scrollable(ScrollableState? value) {
    if (identical(_scrollable, value)) return;
    stopAutoScroll();
    _scrollable = value;
    startAutoScroll();
  }

  /// 드래그 항목이 가장자리에 도달하면 자동으로 스크롤해주는 스크롤러.
  EdgeDraggingAutoScroller? autoScroller;

  /// 드래그 중에만 스크롤 위치 변경과 자동 스크롤을 연결합니다.
  void startAutoScroll() {
    _scrollable?.position.addListener(markNeedsPaint);
    autoScroller = null;

    if (_scrollable != null) {
      autoScroller = EdgeDraggingAutoScroller(
        _scrollable!,
        velocityScalar: 30,
        onScrollViewScrolled: updateAutoScroll,
      );
    }
  }

  /// 자동 스크롤을 멈추고 스크롤 위치 변경 구독을 해제합니다.
  void stopAutoScroll() {
    autoScroller?.stopAutoScroll();
    autoScroller = null;
    _scrollable?.position.removeListener(markNeedsPaint);
  }

  /// 드래그 항목이 스크롤 영역의 가장자리를 넘으면 자동 스크롤합니다.
  void updateAutoScroll() {
    final rect = MatrixUtils.transformRect(
      getTransformTo(null),
      dragPosition & dragChild!.size,
    );

    final EdgeInsets margin = switch (axis) {
      .vertical => const .symmetric(vertical: 40),
      .horizontal => const .symmetric(horizontal: 40),
    };

    autoScroller?.startAutoScrollIfNecessary(margin.inflateRect(rect));
  }

  @override
  void detach() {
    stopAutoScroll();
    super.detach();
  }

  /// 항목이 삽입될 위치를 표시하는 안내선의 색상.
  Color _indicatorColor;

  set indicatorColor(Color value) {
    if (_indicatorColor == value) return;
    _indicatorColor = value;
    markNeedsPaint();
  }

  /// 드래그 중인 항목의 인덱스.
  int? dragIndex;

  /// 드래그 중인 포인터의 마지막 전역 위치.
  Offset? dragGlobalPosition;

  /// 항목의 시작점을 기준으로 포인터가 잡은 위치.
  Offset? grabOffset;

  /// 드래그를 시작한 항목의 기존 배치 위치.
  Offset? dragOrigin;

  /// 드래그 중인 항목의 렌더 객체.
  RenderBox? dragChild;

  /// 현재 항목을 드래그하고 있는지 여부.
  bool get isDragging => dragIndex != null;

  /// 다른 드래그가 없으면 주어진 항목의 드래그 상태를 저장합니다.
  void dragStart(int index, Offset globalPosition) {
    assert(!isDragging);
    assert(index >= 0 && index < childCount);
    RenderBox? child = firstChild;
    for (var i = 0; i < index; i++) {
      child = (child!.parentData! as _ParentData).nextSibling;
    }

    dragChild = child!;
    dragOrigin = (child.parentData! as _ParentData).offset;
    grabOffset = globalToLocal(globalPosition) - dragOrigin!;
    dragIndex = index;
    dragGlobalPosition = globalPosition;
    markNeedsLayout();
    startAutoScroll();
  }

  /// 드래그 중인 포인터의 위치를 갱신합니다.
  void dragUpdate(Offset globalPosition) {
    assert(isDragging);
    dragGlobalPosition = globalPosition;
    markNeedsPaint();
    updateAutoScroll();
  }

  /// 드래그가 종료되거나 취소되면 저장한 상태를 해제합니다.
  void dragEnd(bool canceled) {
    assert(isDragging);
    stopAutoScroll();
    final oldIndex = dragIndex!;
    final newIndex = insertionSlot(dragChild!, dragPosition).index;

    dragIndex = null;
    dragGlobalPosition = null;
    grabOffset = null;
    dragOrigin = null;
    dragChild = null;
    markNeedsLayout();

    // 드래그를 완료하고 항목의 순서가 변경되었을 경우.
    if (!canceled && oldIndex != newIndex) {
      onReorder(oldIndex, newIndex);
    }
  }

  /// 스크롤 이동을 반영하여 포인터가 잡은 위치를 유지하는 배치 위치.
  Offset get dragPosition {
    final position = globalToLocal(dragGlobalPosition!) - grabOffset!;
    return switch (axis) {
      .vertical => Offset(dragOrigin!.dx, position.dy),
      .horizontal => Offset(position.dx, dragOrigin!.dy),
    };
  }

  Axis _axis;

  Axis get axis => _axis;

  set axis(Axis value) {
    if (_axis == value) return;
    _axis = value;
    markNeedsLayout();
  }

  double _spacing;

  double get spacing => _spacing;

  set spacing(double value) {
    if (_spacing == value) return;
    _spacing = value;
    markNeedsLayout();
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _ParentData) {
      child.parentData = _ParentData();
    }
  }

  /// 배치 방향으로는 크기를 제한하지 않고 반대 방향의 최대 크기만.
  BoxConstraints childConstraints(BoxConstraints constraints) {
    return switch (axis) {
      .horizontal => .new(maxHeight: constraints.maxHeight),
      .vertical => .new(maxWidth: constraints.maxWidth),
    };
  }

  @override
  void performLayout() {
    final childConstraints = this.childConstraints(constraints);

    var mainExtent = 0.0;
    var crossExtent = 0.0;
    var index = 0;
    var layoutCount = 0;

    RenderBox? child = firstChild;

    while (child != null) {
      final parentData = child.parentData! as _ParentData;
      final Size childSize;

      child.layout(childConstraints, parentUsesSize: true);
      childSize = child.size;

      crossExtent = max(
        crossExtent,
        axis == .horizontal ? childSize.height : childSize.width,
      );

      // 드래그 중인 항목은 나머지 항목의 배치 공간에서 제외.
      if (index != dragIndex) {
        if (layoutCount > 0) {
          mainExtent += spacing;
        }

        parentData.offset = switch (axis) {
          .horizontal => Offset(mainExtent, 0),
          .vertical => Offset(0, mainExtent),
        };

        mainExtent += axis == .horizontal ? childSize.width : childSize.height;
        layoutCount++;
      }

      child = parentData.nextSibling;
      index++;
    }

    size = constraints.constrain(switch (axis) {
      .horizontal => Size(mainExtent, crossExtent),
      .vertical => Size(crossExtent, mainExtent),
    });
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    RenderBox? child = firstChild;

    // 드래그 중인 항목을 제외한 나머지 항목을 순서대로 표시.
    while (child != null) {
      final parentData = child.parentData! as _ParentData;

      if (child != dragChild) {
        context.paintChild(child, offset + parentData.offset);
      }

      child = parentData.nextSibling;
    }

    // 드래그 중인 항목이 있는 경우.
    if (dragChild case final child?) {
      final position = dragPosition;

      // 해당 항목이 삽입될 위치에 안내선 표시.
      paintIndicator(context.canvas, offset, child, position);

      // 해당 항목을 이동한 위치에서 가장 앞으로 표시.
      context.paintChild(child, offset + position);
    }
  }

  /// 드래그 항목의 중심을 기준으로 제거 후 삽입할 인덱스와 선의 위치를 반환합니다.
  ({int index, double position}) insertionSlot(RenderBox draggedChild, Offset position) {
    final center = axis == .vertical
        ? position.dy + draggedChild.size.height / 2
        : position.dx + draggedChild.size.width / 2;

    var index = 0;
    var linePosition = 0.0;

    for (RenderBox? child = firstChild; child != null; child = childAfter(child)) {
      if (child == draggedChild) continue;

      final parentData = child.parentData! as _ParentData;

      // 배치 방향을 기준으로 항목의 시작 위치 조회.
      final start = switch (axis) {
        .vertical => parentData.offset.dy,
        .horizontal => parentData.offset.dx,
      };

      // 배치 방향을 기준으로 항목의 크기 조회.
      final extent = switch (axis) {
        .vertical => child.size.height,
        .horizontal => child.size.width,
      };

      // 드래그 중인 항목의 중심이 현재 항목의 중심보다 앞에 있을 경우.
      if (center < start + extent / 2) {
        return (index: index, position: start - spacing / 2);
      }

      linePosition = start + extent + spacing / 2;
      index++;
    }

    return (index: index, position: linePosition);
  }

  /// 삽입할 인덱스에 대응하는 위치에 안내선을 표시합니다.
  void paintIndicator(
    Canvas canvas,
    Offset offset,
    RenderBox draggedChild,
    Offset position,
  ) {
    final insertionPosition = insertionSlot(draggedChild, position).position;

    final Rect rect = switch (axis) {
      .vertical => .fromLTWH(
        offset.dx,
        offset.dy + insertionPosition,
        size.width,
        1,
      ),

      .horizontal => .fromLTWH(
        offset.dx + insertionPosition,
        offset.dy,
        1,
        size.height,
      ),
    };

    canvas.drawRect(rect, Paint()..color = _indicatorColor);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }
}

class _ParentData extends ContainerBoxParentData<RenderBox> {}
