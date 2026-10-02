import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 구분선의 시각적 스타일을 나타내는 열거형.
enum GdsDividerVariant {
  brand(.borderPrimaryNormal),
  primary(.borderGraySubtle),
  secondary(.borderGraySubtler);

  const GdsDividerVariant(this.color);

  /// 구분선의 색상을 나타내는 값.
  final GdsColor color;
}

/// 디자인 시스템에서 사용하는 구분선 위젯.
class GdsDivider extends StatelessWidget {
  const GdsDivider({
    super.key,
    this.bold = false,
    this.vertical = false,
    this.extent = .infinity,
    this.margin = .zero,
    required this.variant,
  });

  final bool bold;
  final bool vertical;
  final double extent;
  final EdgeInsets margin;
  final GdsDividerVariant variant;

  @override
  Widget build(BuildContext context) {
    assert(!bold || !vertical, '세로 방향으로는 굵게 표시할 수 없습니다.');
    final thickness = bold ? 12.0 : 1.0; // 선 굵기

    return Padding(
      padding: margin,
      child: GdsContainer(
        width: vertical ? thickness : extent,
        height: vertical ? extent : thickness,
        color: variant.color,
      ),
    );
  }

  /// 주어진 [children] 사이에 구분선을 삽입한 위젯 목록을 반환합니다.
  List<Widget> separated(List<Widget> children) {
    return children.expand((element) => [element, GdsDot()]).toList()..removeLast();
  }
}
