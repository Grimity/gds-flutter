part of '../gds_list_item.dart';

class GdsRightIconListItem extends GdsListItem {
  static const double _height = 52;

  final String text;
  final String? subText;
  final GdsListItemState state;
  final VoidCallback onTap;

  const GdsRightIconListItem({
    super.key,
    required this.text,
    this.subText,
    required this.state,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final style = _GdsRightIconListItemStyle.from(colors, state: state);

    return GdsGesture(
      onTap: state.isDisabled ? null : onTap,
      child: SizedBox(
        height: _height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: style.backgroundColor,
            border: style.border,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: GdsSpacing.spacing16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GdsTypography.label1.copyWith(color: style.textColor),
                  ),
                ),
                const SizedBox(width: GdsSpacing.spacing8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (subText != null) ...[
                      Text(
                        subText!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GdsTypography.label6.copyWith(color: style.subTextColor),
                      ),
                      const SizedBox(width: GdsSpacing.spacing4),
                    ],
                    GdsIcon.chevronRight.build(
                      color: style.iconColor,
                      width: GdsIconSize.v20,
                      height: GdsIconSize.v20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GdsRightIconListItemStyle {
  final Color backgroundColor;
  final Color textColor;
  final Color subTextColor;
  final Color iconColor;
  final Color? borderColor;
  final double borderWidth;

  const _GdsRightIconListItemStyle({
    required this.backgroundColor,
    required this.textColor,
    required this.subTextColor,
    required this.iconColor,
    required this.borderColor,
    required this.borderWidth,
  });

  BoxBorder? get border {
    if (borderColor == null) return null;

    return Border.all(
      color: borderColor!,
      width: borderWidth,
    );
  }

  static _GdsRightIconListItemStyle from(
    GdsSemanticColor colors, {
    required GdsListItemState state,
  }) {
    return switch (state) {
      GdsListItemState.enabled => _GdsRightIconListItemStyle(
        backgroundColor: colors.surface.base,
        textColor: colors.text.grayBold,
        subTextColor: colors.text.graySubtle,
        iconColor: colors.icon.grayBold,
        borderColor: null,
        borderWidth: 0,
      ),
      GdsListItemState.focused => _GdsRightIconListItemStyle(
        backgroundColor: colors.surface.base,
        textColor: colors.text.grayBold,
        subTextColor: colors.text.graySubtle,
        iconColor: colors.icon.grayBold,
        borderColor: colors.border.graySubtle,
        borderWidth: 2,
      ),
      GdsListItemState.hovered => _GdsRightIconListItemStyle(
        backgroundColor: colors.surface.graySubtlest,
        textColor: colors.text.grayBold,
        subTextColor: colors.text.graySubtle,
        iconColor: colors.icon.grayBold,
        borderColor: null,
        borderWidth: 0,
      ),
      GdsListItemState.pressed => _GdsRightIconListItemStyle(
        backgroundColor: colors.surface.graySubtlest,
        textColor: colors.text.grayBold,
        subTextColor: colors.text.graySubtle,
        iconColor: colors.icon.grayBold,
        borderColor: null,
        borderWidth: 0,
      ),
      GdsListItemState.disabled => _GdsRightIconListItemStyle(
        backgroundColor: colors.surface.base,
        textColor: colors.text.graySubtler,
        subTextColor: colors.text.graySubtler,
        iconColor: colors.icon.graySubtler,
        borderColor: null,
        borderWidth: 0,
      ),
    };
  }
}
