import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 주어진 ID에 해당하는 색상을 매핑하는 확장 클래스.
class IdColorMapper extends ColorMapper {
  const new(this.object);

  final Map<String, Color> object;

  @override
  Color substitute(
    String? id,
    String elementName,
    String attributeName,
    Color color,
  ) => object[id] ?? color;
}
