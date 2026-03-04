part of '../gds_list_item.dart';

class GdsIconListItem extends GdsListItem {
  static const double _height = 52;

  final String text;
  final GdsIcon? icon;
  final GdsListItemState state;
  final VoidCallback onTap;

  const GdsIconListItem({
    super.key,
    required this.text,
    this.icon,
    required this.state,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final style = _GdsIconListItemStyle.from(colors, state: state);

    return GestureDetector(
      onTap: state.isDisabled ? null : onTap,
      behavior: HitTestBehavior.opaque,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GdsIconListItemStyle {
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final Color? borderColor;
  final double borderWidth;

  const _GdsIconListItemStyle({
    required this.backgroundColor,
    required this.textColor,
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

  static _GdsIconListItemStyle from(
    GdsSemanticColor colors, {
    required GdsListItemState state,
  }) {
    return switch (state) {
      GdsListItemState.enabled => _GdsIconListItemStyle(
        backgroundColor: colors.surface.base,
        textColor: colors.text.grayNormal,
        iconColor: colors.icon.grayNormal,
        borderColor: null,
        borderWidth: 0,
      ),
      GdsListItemState.focused => _GdsIconListItemStyle(
        backgroundColor: colors.surface.base,
        textColor: colors.text.grayNormal,
        iconColor: colors.icon.grayNormal,
        borderColor: colors.border.graySubtle,
        borderWidth: 2,
      ),
      GdsListItemState.hovered => _GdsIconListItemStyle(
        backgroundColor: colors.surface.graySubtlest,
        textColor: colors.text.grayNormal,
        iconColor: colors.icon.grayNormal,
        borderColor: null,
        borderWidth: 0,
      ),
      GdsListItemState.pressed => _GdsIconListItemStyle(
        backgroundColor: colors.surface.graySubtlest,
        textColor: colors.text.grayBold,
        iconColor: colors.icon.grayBold,
        borderColor: null,
        borderWidth: 0,
      ),
      GdsListItemState.disabled => _GdsIconListItemStyle(
        backgroundColor: colors.surface.graySubtlest,
        textColor: colors.text.graySubtler,
        iconColor: colors.icon.graySubtler,
        borderColor: null,
        borderWidth: 0,
      ),
    };
  }
}
