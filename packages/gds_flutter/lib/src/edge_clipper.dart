import 'package:flutter/widgets.dart';

/// 지정한 방향에서만 자식의 페인팅 영역을 자르는 클리퍼.
class EdgeClipper extends CustomClipper<Rect> {
  const new({
    this.top = false,
    this.left = false,
    this.right = false,
    this.bottom = false,
  });

  final bool top;
  final bool left;
  final bool right;
  final bool bottom;

  /// 클리핑하지 않는 방향에 적용할 사실상 무한한 범위.
  static const unclippedExtent = 1e9;

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(
      left ? 0 : -unclippedExtent,
      top ? 0 : -unclippedExtent,
      right ? size.width : unclippedExtent,
      bottom ? size.height : unclippedExtent,
    );
  }

  @override
  bool shouldReclip(covariant EdgeClipper oldClipper) {
    return top != oldClipper.top ||
        left != oldClipper.left ||
        right != oldClipper.right ||
        bottom != oldClipper.bottom; //
  }
}
