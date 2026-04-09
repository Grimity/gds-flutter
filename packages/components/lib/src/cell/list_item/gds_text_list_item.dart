part of '../gds_list_item.dart';

enum GdsTextListItemSize {
  large,
  medium;

  double get height => switch (this) {
    GdsTextListItemSize.large => 52,
    GdsTextListItemSize.medium => 40,
  };
}

class GdsTextListItem extends GdsListItem {
  final String text;
  final GdsListItemState state;
  final bool isNegative;
  final VoidCallback onTap;
  final GdsTextListItemSize size;

  const GdsTextListItem({
    super.key,
    required this.text,
    required this.state,
    required this.isNegative,
    required this.onTap,
    required this.size,
  });

  const GdsTextListItem.large({
    super.key,
    required this.text,
    required this.state,
    required this.isNegative,
    required this.onTap,
  }) : size = GdsTextListItemSize.large;

  const GdsTextListItem.medium({
    super.key,
    required this.text,
    required this.state,
    required this.isNegative,
    required this.onTap,
  }) : size = GdsTextListItemSize.medium;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final style = _GdsTextListItemStyle.from(
      colors,
      state: state,
      isNegative: isNegative,
    );
    final textStyle = GdsTypography.label1.copyWith(color: style.textColor);

    return GdsGesture(
      onTap: state.isDisabled ? null : onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: style.backgroundColor,
          border: style.border,
        ),
        child: SizedBox(
          height: size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: GdsSpacing.spacing16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle,
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

class _GdsTextListItemStyle {
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final double borderWidth;
  final bool showTrailingCheck;
  final Color trailingIconColor;

  const _GdsTextListItemStyle({
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
    required this.borderWidth,
    required this.showTrailingCheck,
    required this.trailingIconColor,
  });

  BoxBorder? get border {
    if (borderColor == null) return null;

    return Border.all(
      color: borderColor!,
      width: borderWidth,
    );
  }

  static _GdsTextListItemStyle from(
    GdsSemanticColor colors, {
    required GdsListItemState state,
    required bool isNegative,
  }) {
    if (isNegative) {
      return _GdsTextListItemStyle(
        backgroundColor: colors.surface.base,
        textColor: colors.status.negative,
        borderColor: null,
        borderWidth: 0,
        showTrailingCheck: false,
        trailingIconColor: colors.icon.primaryNormal,
      );
    }

    return switch (state) {
      GdsListItemState.enabled => _GdsTextListItemStyle(
        backgroundColor: colors.surface.base,
        textColor: colors.text.grayBold,
        borderColor: null,
        borderWidth: 0,
        showTrailingCheck: false,
        trailingIconColor: colors.icon.primaryNormal,
      ),
      GdsListItemState.focused => _GdsTextListItemStyle(
        backgroundColor: colors.surface.base,
        textColor: colors.text.grayBold,
        borderColor: colors.border.graySubtle,
        borderWidth: 2,
        showTrailingCheck: false,
        trailingIconColor: colors.icon.primaryNormal,
      ),
      GdsListItemState.hovered => _GdsTextListItemStyle(
        backgroundColor: colors.surface.graySubtlest,
        textColor: colors.text.grayBold,
        borderColor: null,
        borderWidth: 0,
        showTrailingCheck: false,
        trailingIconColor: colors.icon.primaryNormal,
      ),
      GdsListItemState.pressed => _GdsTextListItemStyle(
        backgroundColor: colors.surface.base,
        textColor: colors.text.primaryNormal,
        borderColor: null,
        borderWidth: 0,
        showTrailingCheck: true,
        trailingIconColor: colors.icon.primaryNormal,
      ),
      GdsListItemState.disabled => _GdsTextListItemStyle(
        backgroundColor: colors.surface.graySubtlest,
        textColor: colors.text.graySubtler,
        borderColor: null,
        borderWidth: 0,
        showTrailingCheck: false,
        trailingIconColor: colors.icon.primaryNormal,
      ),
    };
  }
}
