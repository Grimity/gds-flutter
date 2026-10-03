import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 디자인 시스템 컴포넌트에 적용할 테두리의 두께와 시맨틱 색상을 정의하는 인터페이스.
class GdsBorder {
  const new({
    this.top = 0,
    this.right = 0,
    this.bottom = 0,
    this.left = 0,
    this.color,
  });

  /// 모든 방향에 동일한 [width]를 적용한 테두리를 생성합니다.
  const new all({
    double width = 1,
    this.color,
  }) : top = width,
       right = width,
       bottom = width,
       left = width;

  final double top;
  final double right;
  final double bottom;
  final double left;

  /// 테두리에 적용할 시맨틱 색상.
  final GdsColor? color;

  /// 테두리가 컴포넌트 바깥으로 확장되지 않도록 안쪽에 정렬.
  static const double _strokeAlign = BorderSide.strokeAlignInside;

  /// 현재 테마의 색상을 반영한 [Border]를 반환합니다.
  Border of(BuildContext context) {
    final rawColor = color?.of(context) ?? (throw StateError('렌더링 시점에서는 색상이 무조건 정의되어 있어야 합니다.'));

    return Border(
      top: createSide(rawColor, top),
      right: createSide(rawColor, right),
      bottom: createSide(rawColor, bottom),
      left: createSide(rawColor, left),
    );
  }

  /// 주어진 색상과 두께로 한 방향의 [BorderSide]를 반환합니다.
  BorderSide createSide(Color color, double width) {
    return width > 0 ? .new(color: color, width: width, strokeAlign: _strokeAlign) : .none;
  }
}
