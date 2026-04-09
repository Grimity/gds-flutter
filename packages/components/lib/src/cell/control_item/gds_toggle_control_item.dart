part of '../gds_control_item.dart';

class GdsToggleControlItem extends GdsControlItem {
  final String text;
  final GdsControlItemVariant variant;
  final GdsControlItemState state;
  final VoidCallback onTap;

  const GdsToggleControlItem({
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
      trailing: GdsToggle(
        isOn: state.isPressed,
        enabled: !state.isDisabled,
        onTap: onTap,
      ),
    );
  }
}
