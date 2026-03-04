import 'package:flutter/widgets.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_foundation/gds_foundation.dart';

part 'control_item/gds_toggle_control_item.dart';
part 'control_item/gds_checkbox_control_item.dart';
part 'control_item/gds_radio_control_item.dart';
part 'control_item/gds_checkmark_control_item.dart';

enum GdsControlItemVariant {
  bold,
  normal;

  TextStyle get textStyle => switch (this) {
    GdsControlItemVariant.bold => GdsTypography.subtitle1,
    GdsControlItemVariant.normal => GdsTypography.label2,
  };
}

enum GdsControlItemState {
  enabled,
  focused,
  pressed,
  disabled;

  bool get isDisabled => this == GdsControlItemState.disabled;

  bool get isPressed => this == GdsControlItemState.pressed;

  bool get isFocused => this == GdsControlItemState.focused;
}

abstract class GdsControlItem extends StatelessWidget {
  const GdsControlItem({super.key});

  const factory GdsControlItem.toggle({
    Key? key,
    required String text,
    GdsControlItemVariant variant,
    required GdsControlItemState state,
    required VoidCallback onTap,
  }) = GdsToggleControlItem;

  const factory GdsControlItem.checkbox({
    Key? key,
    required String text,
    GdsControlItemVariant variant,
    required GdsControlItemState state,
    required VoidCallback onTap,
  }) = GdsCheckboxControlItem;

  const factory GdsControlItem.radio({
    Key? key,
    required String text,
    GdsControlItemVariant variant,
    required GdsControlItemState state,
    required VoidCallback onTap,
  }) = GdsRadioControlItem;

  const factory GdsControlItem.checkmark({
    Key? key,
    required String text,
    GdsControlItemVariant variant,
    required GdsControlItemState state,
    required VoidCallback onTap,
  }) = GdsCheckmarkControlItem;
}

class _GdsControlItemFrame extends StatelessWidget {
  const _GdsControlItemFrame({
    required this.text,
    required this.variant,
    required this.state,
    required this.trailing,
  });

  static const double _height = 52;

  final String text;
  final GdsControlItemVariant variant;
  final GdsControlItemState state;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final textStyle = variant.textStyle.copyWith(
      color: state.isDisabled ? colors.text.graySubtler : colors.text.grayBold,
    );

    final trailingWidget = state.isDisabled ? IgnorePointer(child: trailing) : trailing;

    return SizedBox(
      width: double.infinity,
      height: _height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: state.isFocused
              ? Border.all(
                  color: colors.border.graySubtle,
                  width: 2,
                )
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textStyle,
              ),
            ),
            trailingWidget,
          ],
        ),
      ),
    );
  }
}
