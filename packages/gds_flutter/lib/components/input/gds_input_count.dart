import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 입력한 글자 수와 최대 글자 수를 표시하는 위젯.
class GdsInputCount extends StatelessWidget {
  const new({
    super.key,
    required this.count,
    required this.maxCount,
  });

  final int count;
  final int maxCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: .min,
      children: [
        GdsText(
          count.toString(),
          color: .textGrayNormal,
          style: .label5,
        ),
        GdsText(
          '/$maxCount',
          color: .textGraySubtle,
          style: .label5,
        ),
      ],
    );
  }
}
