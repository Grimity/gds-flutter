import 'package:flutter/widgets.dart';
import 'package:gds_flutter/components/cell/gds_cell_frame.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// https://www.figma.com/design/P1ouNc7cOpjW3MDU3wYdvI/Grimity_Design-System?node-id=11198-8131&t=560u07u7OqOdBEGo-4
abstract class GdsListItem {
  /// 목록의 섹션 제목을 표시하는 위젯.
  static Widget section({Key? key, required String label}) {
    return GdsCellFrame(
      key: key,
      status: .enabled,
      label: label,
      labelStyle: .label6,
      enabledStyle: const .new(textColor: .textGrayNormal, backgroundColor: .surfaceGraySubtlest),
      selectedStyle: const .new(textColor: .textGrayNormal, backgroundColor: .surfaceGraySubtlest),
      disabledStyle: const .new(textColor: .textGrayNormal, backgroundColor: .surfaceGraySubtlest),
      padding: .symmetric(vertical: 6, horizontal: 24),
    );
  }

  /// 라벨과 우측의 보조 라벨 및 아이콘을 표시하는 위젯.
  static Widget rightIcon({
    Key? key,
    GdsCellStatus status = .enabled,
    required GdsIcon icon,
    required String label,
    required String iconLabel,
    VoidCallback? onTap,
  }) {
    assert(status != .negative);

    const enabled = GdsCellStyle(textColor: .textGrayBold, iconColor: .iconGrayBold);
    const disabled = GdsCellStyle(textColor: .textGraySubtler, iconColor: .iconGraySubtler);

    return GdsCellFrame(
      key: key,
      status: status,
      label: label,
      labelStyle: .label1,
      onTap: onTap,
      enabledStyle: enabled,
      disabledStyle: disabled,
      selectedStyle: enabled.copyWith(backgroundColor: .surfaceGraySubtlest),
      padding: 16.all,
      trailingWidget: Row(
        mainAxisSize: .min,
        spacing: 4,
        children: [
          GdsText(iconLabel, color: status == .disabled ? .textGraySubtler : .textGraySubtle, style: .label6),
          icon.build(size: 20, color: status == .disabled ? .iconGraySubtler : .iconGrayBold),
        ],
      ),
    );
  }

  /// 아이콘과 라벨을 테두리가 있는 카드 형태로 표시하는 위젯.
  static Widget optionCard({
    Key? key,
    GdsCellStatus status = .enabled,
    required GdsIcon icon,
    required String label,
    VoidCallback? onTap,
  }) {
    assert(status != .negative);

    final enabled = GdsCellStyle(
      textColor: .textGrayBold,
      iconColor: .iconGrayBold,
      border: .all(color: .borderGraySubtle),
    );

    final disabled = GdsCellStyle(
      textColor: .textGraySubtler,
      iconColor: .iconGraySubtler,
      backgroundColor: .surfaceGraySubtlest,
      border: .all(color: .borderGraySubtler),
    );

    return GdsCellFrame(
      key: key,
      status: status,
      label: label,
      labelStyle: .label1,
      onTap: onTap,
      enabledStyle: enabled,
      disabledStyle: disabled,
      selectedStyle: enabled.copyWith(
        backgroundColor: .surfacePrimarySubtlest,
        border: .all(color: .borderPrimaryNormal),
      ),
      padding: 16.all,
      radius: .sm,
      leadingWidget: icon.build(size: 20, color: status == .disabled ? .iconGraySubtler : .iconGrayBold),
    );
  }

  /// 좌측 아이콘과 라벨을 함께 표시하는 위젯.
  static Widget icon({
    Key? key,
    GdsCellStatus status = .enabled,
    required GdsIcon icon,
    required String label,
    VoidCallback? onTap,
  }) {
    assert(status != .negative);

    const enabled = GdsCellStyle(
      textColor: .textGrayNormal,
      iconColor: .iconGrayNormal,
    );

    return GdsCellFrame(
      key: key,
      status: status,
      label: label,
      labelStyle: .label1,
      onTap: onTap,
      enabledStyle: enabled,
      selectedStyle: const .new(
        textColor: .textGrayBold,
        iconColor: .iconGrayBold,
      ),
      disabledStyle: const .new(
        textColor: .textGraySubtler,
        iconColor: .iconGraySubtler,
        backgroundColor: .surfaceGraySubtlest,
      ),
      padding: 16.all,
      leadingWidget: icon.build(size: 20, color: status == .disabled ? .iconGraySubtler : .iconGrayNormal),
    );
  }

  /// 크기에 따른 여백으로 라벨을 표시하는 위젯.
  @GdsSupportedSizes([.lg, .md])
  static Widget text({
    Key? key,
    GdsCellStatus status = .enabled,
    required GdsSize size,
    required String label,
    VoidCallback? onTap,
  }) {
    const enabled = GdsCellStyle(textColor: .textGrayNormal);

    return GdsCellFrame(
      key: key,
      status: status,
      label: label,
      labelStyle: .label1,
      onTap: onTap,
      enabledStyle: enabled,
      selectedStyle: const .new(
        textColor: .textPrimaryNormal,
        iconColor: .iconPrimaryNormal,
      ),
      disabledStyle: const .new(textColor: .textGraySubtler, backgroundColor: .surfaceGraySubtlest),
      negativeStyle: const .new(textColor: .statusNegative),
      padding: size.when(
        lg: .all(16),
        md: .symmetric(vertical: 8, horizontal: 16),
      ),
    );
  }

  /// 라벨 너비에 맞춘 테두리 카드 형태의 위젯.
  static Widget pickerCard({
    Key? key,
    GdsCellStatus status = .enabled,
    required String label,
    VoidCallback? onTap,
  }) {
    assert(status != .negative);

    final enabled = GdsCellStyle(
      textColor: .textGrayNormal,
      border: .all(color: .borderGraySubtle),
    );

    return IntrinsicWidth(
      key: key,
      child: GdsCellFrame(
        status: status,
        label: label,
        labelStyle: .label4,
        onTap: onTap,
        enabledStyle: enabled,
        selectedStyle: const .new(
          textColor: .textPrimaryNormal,
          backgroundColor: .surfacePrimarySubtlest,
          border: .all(color: .borderPrimaryNormal),
        ),
        disabledStyle: const .new(
          textColor: .textGraySubtler,
          backgroundColor: .surfaceGraySubtlest,
          border: .all(color: .borderGraySubtler),
        ),
        padding: .symmetric(horizontal: 4),
        radius: .sm,
      ),
    );
  }

  /// 항목의 선택 여부를 체크박스로 표시하고 변경하는 위젯.
  static Widget checkBox({
    Key? key,
    GdsCellStatus status = .enabled,
    required String label,
    required VoidCallback onTap,
  }) {
    final value = status == .selected;

    return _input(
      key: key,
      status: status,
      label: label,
      onTap: onTap,
      child: GdsCheckBox(size: .md, value: value, enabled: status != .disabled),
    );
  }

  /// 항목의 선택 여부를 라디오로 표시하고 변경하는 위젯.
  static Widget radio({
    Key? key,
    GdsCellStatus status = .enabled,
    required String label,
    required VoidCallback onTap,
  }) {
    final value = status == .selected;

    return _input(
      key: key,
      status: status,
      label: label,
      onTap: onTap,
      child: GdsRadio(value: value, enabled: status != .disabled),
    );
  }

  /// 항목의 선택 여부를 체크 아이콘으로 표시하고 변경하는 위젯.
  static Widget checkMark({
    Key? key,
    GdsCellStatus status = .enabled,
    required String label,
    required VoidCallback onTap,
  }) {
    final value = status == .selected;

    return _input(
      key: key,
      status: status,
      label: label,
      onTap: onTap,
      child: GdsCheckMark(value: value, enabled: status != .disabled),
    );
  }

  /// 좌측 컨트롤과 라벨을 함께 표시하고 항목 전체의 탭을 처리하는 위젯.
  static Widget _input({
    Key? key,
    required GdsCellStatus status,
    required String label,
    required Widget child,
    required VoidCallback onTap,
  }) {
    assert(status != .negative);

    const enabled = GdsCellStyle(textColor: .textGrayNormal);

    return GdsCellFrame(
      key: key,
      status: status,
      label: label,
      labelStyle: .label4,
      onTap: onTap,
      enabledStyle: enabled,
      selectedStyle: enabled,
      disabledStyle: const GdsCellStyle(textColor: .textGraySubtler),
      padding: .symmetric(vertical: 8, horizontal: 16),
      leadingWidget: IgnorePointer(ignoring: true, child: child),
    );
  }
}
