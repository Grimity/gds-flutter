import 'package:flutter/widgets.dart';
import 'package:gds_flutter/extensions/extensions.dart';

/// 모바일과 태블릿 UI를 각각 구성하는 적응형 위젯.
abstract class GdsAdaptiveWidget extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return context.whenDevice(
      mobile: buildMobile,
      tablet: buildTablet,
    )(context);
  }

  /// 모바일에서 표시할 위젯을 구성합니다.
  Widget buildMobile(BuildContext context);

  /// 태블릿에서 표시할 위젯을 구성합니다.
  Widget buildTablet(BuildContext context);
}
