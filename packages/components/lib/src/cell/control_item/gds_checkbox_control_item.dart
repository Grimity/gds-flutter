part of '../gds_control_item.dart';

class GdsCheckboxControlItem extends GdsControlItem {
  final String text;
  final GdsControlItemVariant variant;
  final GdsControlItemState state;
  final VoidCallback onTap;

  const GdsCheckboxControlItem({
    super.key,
    required this.text,
    this.variant = GdsControlItemVariant.bold,
    required this.state,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _GdsControlItemFrame(
      text: text,
      variant: variant,
      state: state,
      trailing: GdsCheckbox(
        isChecked: state.isPressed,
        enabled: !state.isDisabled,
        onTap: onTap,
      ),
    );
  }
}
