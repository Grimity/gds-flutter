import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 하단 내비게이션용 원형 버튼 위젯.
class GdsBottomNavigationButton extends StatelessWidget {
  const GdsBottomNavigationButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  /// 원형 버튼의 정적 너비와 높이.
  static const size = 54.0;

  @override
  Widget build(BuildContext context) {
    return GdsGesture(
      onTap: onTap,
      child: GdsContainer(
        alignment: .center,
        width: size,
        height: size,
        shadow: .level2,
        shape: .circle,
        color: .surfacePrimaryNormal,
        child: GdsIcon.plus.build(size: 24, color: .iconWhite),
      ),
    );
  }
}
