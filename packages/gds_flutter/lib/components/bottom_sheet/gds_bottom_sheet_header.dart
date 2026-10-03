import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 바텀 시트의 제목과 닫기 버튼을 표시하는 헤더 위젯.
class GdsBottomSheetHeader extends StatelessWidget {
  const new({
    super.key,
    required this.title,
    required this.onBack,
  });

  final String? title;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final hasTitle = title != null;

    return GdsContainer(
      height: GdsControlSize.xl.value,
      padding: .symmetric(horizontal: 20),
      alignment: .center,
      child: Row(
        spacing: 12,
        children: [
          if (hasTitle) ...[
            // 좌측에 뒤로가기 아이콘 표시.
            GdsIcon.chevronLeftTightThick.build(size: 24, color: .iconGrayBold),

            // 좌측에 헤더 제목 표시.
            GdsText(title!, color: .textGrayBold, style: .title3),
          ],

          Expanded(child: SizedBox.shrink()),

          // 우측에 닫기 버튼 표시.
          GdsButton.icon(type: .normal, onTap: onBack, icon: .x),
        ],
      ),
    );
  }
}
