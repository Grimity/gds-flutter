import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:pervice/pervice.dart';

/// 라벨과 팝업의 열림 상태를 표시하는 필터 위젯.
class GdsFilter extends StatelessWidget {
  const new({
    super.key,
    required this.variant,
    required this.label,
    this.enabled = true,
    this.onTap,
  });

  final GdsFilterVariant variant;
  final String label;
  final bool enabled;
  final AsyncCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final open = context.stateOf(() => false);

    // 열려 있으면 위쪽, 닫혀 있으면 아래쪽 화살표 표시.
    final GdsIcon chevronIcon = open.value ? .chevronUpThick : .chevronDownThick;

    // 활성화 여부에 맞는 필터 스타일 적용.
    final style = enabled ? variant.enabled : variant.disabled;

    return IgnorePointer(
      ignoring: !enabled,
      child: GdsGesture(
        onTap: () async {
          if (onTap == null) return;

          // 별도 UI가 열리는 동안 열림 상태 반영.
          try {
            open.value = true;
            await onTap!();
          } finally {
            open.value = false;
          }
        },
        child: GdsContainer(
          animation: .fast,
          height: variant.size.value,
          radius: variant.radius,
          border: style.border,
          color: style.backgroundColor,
          padding: .only(left: 12, right: 10),
          child: Row(
            mainAxisSize: .min,
            spacing: 8,
            children: [
              // 좌측에 라벨 표시.
              GdsText(
                label,
                style: .label3,
                color: style.textColor,
              ),

              // 우측에 팝업의 열림 상태에 따른 화살표 표시.
              GdsTransition.fadeThrough(
                value: open.value,
                child: chevronIcon.build(
                  size: 16,
                  color: style.iconColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
