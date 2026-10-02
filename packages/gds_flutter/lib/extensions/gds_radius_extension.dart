import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 디자인 시스템에서 제공하는 [GdsRadius]에 대한 유틸리티 확장.
extension GdsRadiusExtension on GdsRadius {
  // Radius
  Radius get circular => Radius.circular(value);

  // BorderRadius
  BorderRadius get all => BorderRadius.circular(value);
  BorderRadius get top => BorderRadius.vertical(top: circular);
  BorderRadius get left => BorderRadius.horizontal(left: circular);
  BorderRadius get right => BorderRadius.horizontal(right: circular);
  BorderRadius get bottom => BorderRadius.vertical(bottom: circular);
}
