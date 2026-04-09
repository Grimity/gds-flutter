part of '../gds_list_item.dart';

class GdsPickerCardListItem extends GdsListItem {
  final String text;
  final GdsListItemState state;
  final VoidCallback onTap;

  const GdsPickerCardListItem({
    super.key,
    required this.text,
    required this.state,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final style = _GdsPickerCardListItemStyle.from(colors, state);
    final textStyle = GdsTypography.label4.copyWith(color: style.textColor);

    return GdsGesture(
      onTap: state.isDisabled ? null : onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: style.backgroundColor,
          borderRadius: BorderRadius.circular(GdsRadius.sm),
          border: Border.all(
            color: style.borderColor,
            width: style.borderWidth,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: GdsSpacing.spacing4,
            vertical: GdsSpacing.spacing6,
          ),
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}

class _GdsPickerCardListItemStyle {
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final double borderWidth;

  const _GdsPickerCardListItemStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.borderWidth,
  });

  static _GdsPickerCardListItemStyle from(GdsSemanticColor colors, GdsListItemState state) => switch (state) {
    GdsListItemState.enabled => _GdsPickerCardListItemStyle(
      backgroundColor: colors.surface.base,
      borderColor: colors.border.graySubtle,
      textColor: colors.text.grayBold,
      borderWidth: 1,
    ),
    GdsListItemState.focused => _GdsPickerCardListItemStyle(
      backgroundColor: colors.surface.base,
      borderColor: colors.border.graySubtle,
      textColor: colors.text.grayBold,
      borderWidth: 2,
    ),
    GdsListItemState.hovered => _GdsPickerCardListItemStyle(
      backgroundColor: colors.surface.graySubtlest,
      borderColor: colors.border.grayNormal,
      textColor: colors.text.grayBold,
      borderWidth: 1,
    ),
    GdsListItemState.pressed => _GdsPickerCardListItemStyle(
      backgroundColor: colors.surface.primarySubtlest,
      borderColor: colors.border.primaryNormal,
      textColor: colors.text.primaryNormal,
      borderWidth: 1,
    ),
    GdsListItemState.disabled => _GdsPickerCardListItemStyle(
      backgroundColor: colors.surface.graySubtlest,
      borderColor: colors.border.graySubtler,
      textColor: colors.text.graySubtler,
      borderWidth: 1,
    ),
  };
}
