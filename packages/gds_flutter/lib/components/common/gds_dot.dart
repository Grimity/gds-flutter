import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 디자인 시스템 전반에서 공통으로 사용하는 중점(dot) 위젯.
class GdsDot extends StatelessWidget {
  const GdsDot({
    super.key,
    this.size = 2,
  }) : assert(size > 0, 'size는 음수가 될 수 없습니다.');

  /// 중점(dot)의 가로/세로 크기.
  final double size;

  @override
  Widget build(BuildContext context) => GdsContainer(
    width: size,
    height: size,
    color: .surfaceGraySubtle,
    shape: .circle,
  );

  /// 주어진 [children] 사이에 중점을 삽입한 위젯 목록을 반환합니다.
  static List<Widget> separated(List<Widget> children) {
    return children.expand((element) => [element, GdsDot()]).toList()..removeLast();
  }
}
