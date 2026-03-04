part of '../gds_list_item.dart';

class GdsOptionCardListItem extends GdsListItem {
  static const double _height = 52;

  final String text;
  final GdsIcon? icon;
  final GdsListItemState state;
  final VoidCallback onTap;

  const GdsOptionCardListItem({
    super.key,
    required this.text,
    this.icon,
    required this.state,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final style = _GdsOptionCardListItemStyle.from(colors, state: state);

    return GestureDetector(
      onTap: state.isDisabled ? null : onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: _height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: style.backgroundColor,
            borderRadius: BorderRadius.circular(GdsRadius.sm),
            border: style.border,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: GdsSpacing.spacing16),
            child: Row(
              children: [
                if (icon != null) ...[
                  icon!.build(
                    color: style.iconColor,
                    width: GdsIconSize.defaultSize,
                    height: GdsIconSize.defaultSize,
                  ),
                  const SizedBox(width: GdsSpacing.spacing8),
                ],
                Expanded(
                  child: Text(
                    text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GdsTypography.label1.copyWith(color: style.textColor),
                  ),
                ),
                if (style.showTrailingCheck) ...[
                  const SizedBox(width: GdsSpacing.spacing8),
                  GdsIcon.check.build(
                    color: style.trailingIconColor,
                    width: GdsIconSize.defaultSize,
                    height: GdsIconSize.defaultSize,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GdsOptionCardListItemStyle {
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final Color borderColor;
  final double borderWidth;
  final bool showTrailingCheck;
  final Color trailingIconColor;

  const _GdsOptionCardListItemStyle({
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
    required this.borderColor,
    required this.borderWidth,
    required this.showTrailingCheck,
    required this.trailingIconColor,
  });

  BoxBorder get border {
    return Border.all(
      color: borderColor,
      width: borderWidth,
    );
  }

  static _GdsOptionCardListItemStyle from(
    GdsSemanticColor colors, {
    required GdsListItemState state,
  }) {
    return switch (state) {
      GdsListItemState.enabled => _GdsOptionCardListItemStyle(
        backgroundColor: colors.surface.base,
        textColor: colors.text.grayBold,
        iconColor: colors.icon.grayBold,
        borderColor: colors.border.graySubtle,
        borderWidth: 1,
        showTrailingCheck: false,
        trailingIconColor: colors.icon.primaryNormal,
      ),
      GdsListItemState.focused => _GdsOptionCardListItemStyle(
        backgroundColor: colors.surface.base,
        textColor: colors.text.grayBold,
        iconColor: colors.icon.grayBold,
        borderColor: colors.border.graySubtle,
        borderWidth: 2,
        showTrailingCheck: false,
        trailingIconColor: colors.icon.primaryNormal,
      ),
      GdsListItemState.hovered => _GdsOptionCardListItemStyle(
        backgroundColor: colors.surface.graySubtlest,
        textColor: colors.text.grayBold,
        iconColor: colors.icon.grayBold,
        borderColor: colors.border.grayNormal,
        borderWidth: 1,
        showTrailingCheck: false,
        trailingIconColor: colors.icon.primaryNormal,
      ),
      GdsListItemState.pressed => _GdsOptionCardListItemStyle(
        backgroundColor: colors.surface.primarySubtlest,
        textColor: colors.text.primaryNormal,
        iconColor: colors.icon.primaryNormal,
        borderColor: colors.border.primaryNormal,
        borderWidth: 1,
        showTrailingCheck: true,
        trailingIconColor: colors.icon.primaryNormal,
      ),
      GdsListItemState.disabled => _GdsOptionCardListItemStyle(
        backgroundColor: colors.surface.graySubtlest,
        textColor: colors.text.graySubtler,
        iconColor: colors.icon.graySubtler,
        borderColor: colors.border.graySubtler,
        borderWidth: 1,
        showTrailingCheck: false,
        trailingIconColor: colors.icon.primaryNormal,
      ),
    };
  }
}
