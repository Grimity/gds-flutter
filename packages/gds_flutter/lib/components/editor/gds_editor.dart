import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 에디터 툴바에서 선택된 툴의 상태를 나타내는 열거형.
enum GdsEditorStatus {
  none,
  plus,
  fontStyle,
  fontColor,
  fontBgColor,
}

/// 에디터와 툴바, 옵션 패널을 연동하고 구성하는 위젯.
class GdsEditor extends StatelessWidget {
  const new({
    super.key,
    required this.status,
    required this.toolbar,
    required this.panel,
  });

  final GdsEditorStatus status;
  final GdsEditorToolbar toolbar;
  final GdsEditorPanel panel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      children: [
        // 상단에 툴바 표시
        toolbar,

        // 상태에 따른 하단 패널 표시
        GdsContainer(
          color: .surfaceGraySubtlest,
          child: GdsFoldable.builder(
            alignment: .bottomCenter,
            visible: status != .none,
            axis: .vertical,
            builder: (_) {
              return GdsTransition.sharedAxis(
                transitionType: .vertical,
                value: status,
                child: panel,
              );
            },
          ),
        ),
      ],
    );
  }
}
