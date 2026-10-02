import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 선택형 컨트롤에서 공통으로 사용하는 스타일을 정의하는 인터페이스.
abstract class GdsControl {
  /// 선택 및 활성화 상태에 맞는 아이콘 색상을 반환합니다.
  static GdsColor colorOf(bool value, bool enabled) {
    return value
        ? (enabled ? .iconPrimaryNormal : .iconPrimarySubtler)
        : (enabled ? .iconGraySubtler : .iconGraySubtlest);
  }

  /// 표시 여부에 따라 컨트롤 위젯을 가로 방향으로 접고 펼치는 위젯.
  static Widget foldable({
    Key? key,
    required bool visible,
    required GdsSpacing spacing,
    required Widget control,
  }) {
    return GdsFoldable.builder(
      key: key,
      alignment: .centerLeft,
      visible: visible,
      axis: .horizontal,
      builder: (context) {
        return Padding(
          padding: .only(right: spacing),
          child: control,
        );
      },
    );
  }
}
