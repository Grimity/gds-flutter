import 'package:flutter/widgets.dart';
import 'package:gds_flutter/components/button/gds_button_decoration.dart';
import 'package:gds_flutter/components/button/gds_button_frame.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// https://www.figma.com/design/P1ouNc7cOpjW3MDU3wYdvI/Grimity_Design-System?node-id=11017-181907&m=dev
abstract class GdsButton {
  /// 텍스트와 아이콘을 함께 표시하는 버튼 위젯.
  @GdsSupportedSizes([.lg, .md, .sm])
  static Widget text({
    Key? key,
    LayerLink? layerLink,
    required GdsTextButtonType type,
    required GdsSize size,
    GdsTextButtonVariant? variant,
    VoidCallback? onTap,
    GdsButtonStatus status = .enabled,
    String? label,
    MainAxisSize? mainAxisSize,
    GdsIcon? leadingIcon,
    GdsIcon? trailingIcon,
    GdsColor? iconColor,
  }) {
    assert(
      type.supportsVariant ? variant != null : variant == null,
      '버튼 유형의 변형 스타일 지원 여부에 맞게 variant를 지정해야 합니다.',
    );

    // 지정한 variant에 해당하는 상태별 스타일을 선택.
    final styleSet = switch (variant) {
      .primary => type.primary,
      .assistive => type.assistive,
      _ => type.none,
    };

    if (styleSet == null) {
      throw StateError('지원하지 않는 버튼 유형과 variant 조합입니다.');
    }

    return GdsPopoverAnchor(
      key: key,
      layerLink: layerLink,
      child: GdsButtonFrame(
        enabledStyle: styleSet.enabled.copyWith(iconColor: iconColor),
        disabledStyle: styleSet.disabled,
        loadingStyle: styleSet.loading,
        decoration: size.when(
          lg: type.lgDecoration,
          md: type.mdDecoration,
          sm: type.smDecoration,
        ),
        status: status,
        onTap: onTap,
        label: label,
        mainAxisSize: mainAxisSize,
        leadingIcon: leadingIcon,
        trailingIcon: trailingIcon,
      ),
    );
  }

  /// 아이콘만을 표시하는 원형 버튼 위젯.
  static Widget icon({
    Key? key,
    LayerLink? layerLink,
    GdsButtonStatus status = .enabled,
    required GdsIconButtonType type,
    required GdsIcon icon,
    VoidCallback? onTap,
    GdsColor? color,
  }) {
    final decoration = GdsButtonDecoration(
      typography: .label1,
      iconSize: type.iconSize,
      spacing: 0,
      radius: .full,
      size: type.size,
    );

    return GdsPopoverAnchor(
      key: key,
      layerLink: layerLink,
      child: GdsButtonFrame(
        enabledStyle: type.enabled.copyWith(iconColor: color),
        disabledStyle: type.disabled,
        loadingStyle: type.loading,
        decoration: decoration,
        status: status,
        onTap: onTap,
        label: null,
        mainAxisSize: null,
        leadingIcon: icon,
        trailingIcon: null,
      ),
    );
  }
}
