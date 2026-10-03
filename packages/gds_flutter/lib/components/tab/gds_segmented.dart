import 'package:flutter/material.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 여러 항목 중 하나를 선택할 수 있는 분할 탭 위젯.
class GdsSegmented extends StatelessWidget {
  const new({
    super.key,
    required this.index,
    required this.items,
    required this.onChanged,
  });

  final int index;
  final List<String> items;
  final ValueChanged<int> onChanged;

  /// 선택 표시 영역에 적용할 애니메이션.
  static const animation = GdsAnimation.slow;

  @override
  Widget build(BuildContext context) {
    return GdsContainer(
      height: GdsControlSize.ml.value,
      color: .surfaceGraySubtler,
      radius: .sm,
      alignment: .center,
      child: Stack(
        children: [
          // 선택된 항목의 배경 표시.
          AnimatedSlide(
            offset: .new(index.toDouble(), 0),
            duration: animation.duration,
            curve: animation.curve,
            child: FractionallySizedBox(
              widthFactor: 1 / items.length,
              child: GdsContainer(
                color: .surfaceBase,
                radius: .sm,
                border: .all(color: .surfacePrimaryNormal, width: 1.5),
              ),
            ),
          ),

          // 각각의 탭 항목 표시.
          Row(children: items.indexedBuilder(buildTab)),
        ],
      ),
    );
  }

  /// 각 탭 항목 위젯.
  Widget buildTab(int index, String label) {
    final selected = this.index == index;

    return Expanded(
      child: GdsGesture(
        onTap: selected ? null : () => onChanged(index),
        child: Center(
          child: GdsText(
            label,
            color: .textGrayBold,
            style: selected ? .body1SB : .body2R,
          ),
        ),
      ),
    );
  }
}
