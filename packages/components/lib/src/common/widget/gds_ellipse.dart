import 'package:flutter/widgets.dart';
import 'package:gds_foundation/gds_foundation.dart';

/// 디자인 시스템 전반에서 공통으로 사용하는 둥근 점 위젯입니다.
class GdsEllipse extends StatelessWidget {
  const GdsEllipse({
    super.key,
    this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      height: 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color ?? context.gdsColors.surface.graySubtle,
      ),
    );
  }
}
