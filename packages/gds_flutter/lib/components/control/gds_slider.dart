// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:pervice/pervice.dart';

/// 슬라이더의 값이 변경된 사유.
enum GdsSliderChangeReason {
  initial,
  tap,
  drag,
  external,
}

/// 슬라이더의 현재 값과 변경 사유를 나타내는 상태.
typedef GdsSliderState = ({
  double value,
  GdsSliderChangeReason reason,
});

/// 지정한 범위 안에서 값을 조절할 수 있는 슬라이더 위젯.
class GdsSlider extends StatelessWidget {
  const new({
    super.key,
    this.min = 0,
    this.max = 1,
    this.value,
    this.initialValue,
    this.onChanged,
  }) : assert(min < max),
       assert(value == null || (value >= min && value <= max)),
       assert(initialValue == null || (initialValue >= min && initialValue <= max));

  final double min;
  final double max;
  final double? value;
  final double? initialValue;
  final ValueChanged<double>? onChanged;

  /// 슬라이더의 트랙 높이와 핸들의 지름에 적용되는 크기.
  static const size = 16.0;

  @override
  Widget build(BuildContext context) {
    final state = context.stateOf<GdsSliderState>(
      () => (value: initialValue ?? min, reason: .initial),
    );

    // 외부에서 전달한 값이 현재 값과 다를 경우.
    if (value case final value? when state.value.value != value) {
      state.value = (value: value, reason: .external);
    }

    // 현재 값을 0부터 1 사이의 상대 위치로 변환.
    final relPosition = (state.value.value - min) / (max - min);

    // 값과 변경 사유를 갱신하고 변경된 값을 알림.
    void setValue(double newValue, GdsSliderChangeReason reason) {
      state.value = (value: newValue.clamp(min, max), reason: reason);
      onChanged?.call(state.value.value);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;

        // ignore: gds_lints/prefer_gds_gesture
        return GestureDetector(
          onTapUp: (details) {
            setValue(min + details.localPosition.dx / maxWidth * (max - min), .tap);
          },
          onHorizontalDragStart: (details) {
            setValue(state.value.value, .drag);
          },
          onHorizontalDragEnd: (details) {
            setValue(state.value.value, .drag);
          },
          onHorizontalDragUpdate: (details) {
            setValue(state.value.value + details.delta.dx / maxWidth * (max - min), .drag);
          },
          child: GdsContainer(
            width: .infinity,
            height: size,
            radius: .full,
            color: .borderGraySubtle,
            alignment: .centerLeft,
            child: GdsContainer(
              width: size + (maxWidth - size) * relPosition,
              color: .surfaceInverse,
              radius: .full,
              animation: switch (state.value.reason) {
                .initial => .none,
                .tap => .fast,
                .drag => .none,
                .external => .none,
              },
            ),
          ),
        );
      },
    );
  }
}
