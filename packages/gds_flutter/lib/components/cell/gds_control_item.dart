import 'package:flutter/widgets.dart';
import 'package:gds_flutter/components/cell/gds_cell_frame.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 컨트롤 아이템의 크기와 시각적 스타일을 나타내는 열거형.
enum GdsControlItemVariant {
  bold(.subtitle1),
  normal(.label2);

  const new(this.typography);

  final GdsTypography typography;
}

/// https://www.figma.com/design/P1ouNc7cOpjW3MDU3wYdvI/Grimity_Design-System?node-id=11481-167344&t=560u07u7OqOdBEGo-4
abstract class GdsControlItem {
  /// 항목의 선택 여부를 토글로 표시하고 변경하는 위젯.
  static Widget toggle({
    Key? key,
    required GdsControlItemVariant variant,
    GdsCellStatus status = .enabled,
    required String label,
    required VoidCallback onTap,
  }) {
    final value = status == .selected;

    return _frame(
      key: key,
      variant: variant,
      status: status,
      label: label,
      onTap: onTap,
      child: GdsToggle(value: value, enabled: status != .disabled),
    );
  }

  /// 항목의 선택 여부를 체크박스로 표시하고 변경하는 위젯.
  static Widget checkBox({
    Key? key,
    required GdsControlItemVariant variant,
    GdsCellStatus status = .enabled,
    required String label,
    required VoidCallback onTap,
  }) {
    final value = status == .selected;

    return _frame(
      key: key,
      variant: variant,
      status: status,
      label: label,
      onTap: onTap,
      child: GdsCheckBox(size: .md, value: value, enabled: status != .disabled),
    );
  }

  /// 항목의 선택 여부를 라디오로 표시하고 변경하는 위젯.
  static Widget radio({
    Key? key,
    required GdsControlItemVariant variant,
    GdsCellStatus status = .enabled,
    required String label,
    required VoidCallback onTap,
  }) {
    final value = status == .selected;

    return _frame(
      key: key,
      variant: variant,
      status: status,
      label: label,
      onTap: onTap,
      child: GdsRadio(value: value, enabled: status != .disabled),
    );
  }

  /// 항목의 선택 여부를 체크 아이콘으로 표시하고 변경하는 위젯.
  static Widget checkMark({
    Key? key,
    required GdsControlItemVariant variant,
    GdsCellStatus status = .enabled,
    required String label,
    required VoidCallback onTap,
  }) {
    final value = status == .selected;

    return _frame(
      key: key,
      variant: variant,
      status: status,
      label: label,
      onTap: onTap,
      child: GdsCheckMark(value: value, enabled: status != .disabled),
    );
  }

  /// 컨트롤과 라벨을 함께 표시하는 위젯.
  static Widget _frame({
    Key? key,
    required GdsControlItemVariant variant,
    GdsCellStatus status = .enabled,
    required String label,
    required Widget child,
    required VoidCallback onTap,
  }) {
    assert(status != .negative);

    const enabled = GdsCellStyle(textColor: .textGrayBold);

    return GdsCellFrame(
      key: key,
      enabledStyle: enabled,
      selectedStyle: enabled,
      disabledStyle: const GdsCellStyle(textColor: .textGraySubtler),
      status: status,
      onTap: onTap,
      label: label,
      labelStyle: variant.typography,
      padding: 16.all,
      trailingWidget: child,
    );
  }
}
