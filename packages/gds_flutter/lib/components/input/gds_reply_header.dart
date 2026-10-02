import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 답장할 사용자에 대한 정보를 표시하는 헤더 위젯.
class GdsReplyHeader extends StatelessWidget {
  const GdsReplyHeader({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 2,
      children: [
        // 아이콘 표시.
        GdsIcon.forward2.build(size: 16, color: .iconGraySubtle),

        // 텍스트 표시.
        GdsText(text, color: .textGraySubtle, style: .label6),
      ],
    );
  }
}
