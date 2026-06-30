import 'dart:math';
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class GdsRenderTab extends MultiChildRenderObjectWidget {
  const GdsRenderTab({
    super.key,
    required this.offset,
    required this.dividerColor,
    required this.indicatorColor,
    required super.children,
  });

  final double offset;
  final Color dividerColor;
  final Color indicatorColor;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _GdsTabRenderBox(
      offset: offset,
      dividerColor: dividerColor,
      indicatorColor: indicatorColor,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) {
    (renderObject as _GdsTabRenderBox)
      ..offset = offset
      ..dividerColor = dividerColor
      ..indicatorColor = indicatorColor;
  }
}

typedef ContainerRenderObject = ContainerRenderObjectMixin<RenderBox, MultiChildLayoutParentData>;
typedef RenderBoxContainerDefaults = RenderBoxContainerDefaultsMixin<RenderBox, MultiChildLayoutParentData>;

class _GdsTabRenderBox extends RenderBox with ContainerRenderObject, RenderBoxContainerDefaults {
  _GdsTabRenderBox({
    required double offset,
    required Color dividerColor,
    required Color indicatorColor,
  }) {
    _offset = offset;
    _dividerColor = dividerColor;
    _indicatorColor = indicatorColor;
  }

  late double _offset;
  double get offset => _offset;
  set offset(double newIndex) {
    if (offset == newIndex) return;
    _offset = newIndex;
    markNeedsPaint();
  }

  late Color _dividerColor;
  Color get dividerColor => _dividerColor;
  set dividerColor(Color newColor) {
    if (dividerColor == newColor) return;
    _dividerColor = newColor;
    markNeedsLayout();
  }

  late Color _indicatorColor;
  Color get indicatorColor => _indicatorColor;
  set indicatorColor(Color newColor) {
    if (indicatorColor == newColor) return;
    _indicatorColor = newColor;
    markNeedsLayout();
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! MultiChildLayoutParentData) {
      child.parentData = MultiChildLayoutParentData();
    }
  }

  @override
  void performLayout() {
    RenderBox? child = firstChild;

    double width = 0;
    double height = 0;
    Offset childOffset = Offset.zero;

    while (child != null) {
      final childParentData = child.parentData as MultiChildLayoutParentData;

      child.layout(
        BoxConstraints(
          maxWidth: constraints.maxWidth,
          maxHeight: constraints.maxHeight,
        ),
        parentUsesSize: true,
      );

      width += child.size.width;
      height = max(child.size.height, height);

      childParentData.offset = childOffset;
      childOffset += Offset(child.size.width, 0);

      child = childParentData.nextSibling;
    }

    size = Size(width, height);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);

    if (childCount == 0) return;

    final Canvas canvas = context.canvas;
    final double thickness = 2.0;
    final double bottomY = offset.dy + size.height;

    // Divider
    final Paint dividerPaint = Paint()
      ..color = dividerColor
      ..strokeWidth = 1.0;

    canvas.drawLine(
      Offset(offset.dx, bottomY - 0.5),
      Offset(offset.dx + size.width, bottomY - 0.5),
      dividerPaint,
    );

    // Indicator
    final double currentPosition = _offset.clamp(0.0, (childCount - 1).toDouble());

    final int fromIndex = currentPosition.truncate();
    final int toIndex = (fromIndex + 1 < childCount) ? fromIndex + 1 : fromIndex;
    final double t = currentPosition - fromIndex;

    RenderBox? fromChild = firstChild;
    for (int i = 0; i < fromIndex; i++) {
      fromChild = (fromChild?.parentData as MultiChildLayoutParentData?)?.nextSibling;
    }

    RenderBox? toChild = firstChild;
    for (int i = 0; i < toIndex; i++) {
      toChild = (toChild?.parentData as MultiChildLayoutParentData?)?.nextSibling;
    }

    if (fromChild == null || toChild == null) return;

    final fromParentData = fromChild.parentData as MultiChildLayoutParentData;
    final toParentData = toChild.parentData as MultiChildLayoutParentData;

    // 출발지와 목적지 사이를 비율 t(0.0 ~ 1.0)에 따라 부드럽게 선형 보간
    final double indicatorLeft = lerpDouble(
      offset.dx + fromParentData.offset.dx,
      offset.dx + toParentData.offset.dx,
      t,
    )!;

    final double indicatorRight = lerpDouble(
      offset.dx + fromParentData.offset.dx + fromChild.size.width,
      offset.dx + toParentData.offset.dx + toChild.size.width,
      t,
    )!;

    final Paint indicatorPaint = Paint()
      ..color = indicatorColor
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTRB(
        indicatorLeft,
        bottomY - thickness,
        indicatorRight,
        bottomY,
      ),
      indicatorPaint,
    );
  }
}
