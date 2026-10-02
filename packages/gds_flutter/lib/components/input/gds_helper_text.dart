import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 헬퍼 텍스트 표시 상태를 나타내는 열거형.
enum GdsHelperTextStatus {
  enabled(color: .textGrayBold, icon: null),
  error(color: .statusNegative, icon: .x),
  success(color: .statusPositive, icon: .check);

  const GdsHelperTextStatus({
    required this.color,
    required this.icon,
  });

  final GdsColor color;
  final GdsIcon? icon;
}

/// 입력 필드의 상태를 안내하는 헬퍼 텍스트 위젯.
class GdsHelperText extends StatelessWidget {
  const GdsHelperText({
    super.key,
    required this.text,
    required this.status,
  });

  final String text;
  final GdsHelperTextStatus status;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 2,
      children: [
        // 아이콘 표시.
        if (status.icon != null) ...[
          status.icon!.build(size: 16, color: status.color),
        ],

        // 텍스트 표시.
        GdsText(text, color: status.color, style: .caption1),
      ],
    );
  }
}
