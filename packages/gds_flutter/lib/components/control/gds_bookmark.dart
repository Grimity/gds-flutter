import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 북마크의 선택 여부를 아이콘으로 표시하고 변경하는 위젯.
class GdsBookmark extends StatelessWidget {
  const new({
    super.key,
    required this.value,
    required this.black,
    this.enabled = true,
    this.onChanged,
  });

  final bool value;
  final bool black;
  final bool enabled;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final GdsIcon icon = value ? .bookmarkFill : .bookmark;

    return GdsGesture(
      onTap: enabled && onChanged != null ? () => onChanged!(!value) : null,
      child: GdsTransition.crossFade(
        animation: .fast,
        value: [value, black, enabled],
        child: icon.build(
          size: 24,
          color: value ? .iconPrimaryNormal : (black ? .iconGrayBold : .iconGraySubtle),
        ),
      ),
    );
  }
}
