part of '../gds_control_item.dart';

class GdsRadioControlItem extends GdsControlItem {
  final String text;
  final GdsControlItemVariant variant;
  final GdsControlItemState state;
  final VoidCallback onTap;

  const GdsRadioControlItem({
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
      trailing: GdsRadioButton(
        isSelected: state.isPressed,
        enabled: !state.isDisabled,
        onTap: onTap,
      ),
    );
  }
}
