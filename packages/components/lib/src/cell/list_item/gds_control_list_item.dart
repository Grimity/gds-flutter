part of '../gds_list_item.dart';

enum _GdsControlListItemType { checkBox, radio, checkMark }

class GdsControlListItem extends GdsListItem {
  static const double _height = 40;

  final String text;
  final GdsListItemState state;
  final VoidCallback onTap;
  final EdgeInsets? padding;
  final _GdsControlListItemType _type;

  const GdsControlListItem.checkbox({
    super.key,
    required this.text,
    required this.state,
    required this.onTap,
    this.padding,
  }) : _type = _GdsControlListItemType.checkBox;

  const GdsControlListItem.radio({
    super.key,
    required this.text,
    required this.state,
    required this.onTap,
    this.padding,
  }) : _type = _GdsControlListItemType.radio;

  const GdsControlListItem.checkmark({
    super.key,
    required this.text,
    required this.state,
    required this.onTap,
    this.padding,
  }) : _type = _GdsControlListItemType.checkMark;

  Widget _buildControl({
    required bool selected,
    required bool enabled,
  }) {
    return switch (_type) {
      _GdsControlListItemType.checkBox => GdsCheckbox(
        isChecked: selected,
        enabled: enabled,
        onTap: onTap,
      ),
      _GdsControlListItemType.radio => GdsRadioButton(
        isSelected: selected,
        enabled: enabled,
        onTap: onTap,
      ),
      _GdsControlListItemType.checkMark => GdsCheckmark(
        isChecked: selected,
        enabled: enabled,
        onTap: onTap,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final style = _GdsControlListItemStyle.from(colors, state: state);
    final control = _buildControl(
      selected: style.isControlSelected,
      enabled: !state.isDisabled,
    );

    EdgeInsets padding = EdgeInsets.symmetric(
      horizontal: GdsSpacing.spacing12,
      vertical: GdsSpacing.spacing8,
    );

    if (this.padding != null) {
      padding.add(this.padding!);
    }

    return IgnorePointer(
      ignoring: state.isDisabled,
      child: GdsGesture(
        onTap: onTap,
        child: SizedBox(
          height: _height,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: style.backgroundColor,
              border: style.border,
            ),
            child: Padding(
              padding: padding,
              child: Row(
                children: [
                  control,
                  const SizedBox(width: GdsSpacing.spacing8),
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
      ),
    );
  }
}

class _GdsControlListItemStyle {
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final double borderWidth;
  final bool isControlSelected;

  const _GdsControlListItemStyle({
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
    required this.borderWidth,
    required this.isControlSelected,
  });

  BoxBorder? get border {
    if (borderColor == null) return null;

    return Border.all(
      color: borderColor!,
      width: borderWidth,
    );
  }

  static _GdsControlListItemStyle from(
    GdsSemanticColor colors, {
    required GdsListItemState state,
  }) {
    return switch (state) {
      GdsListItemState.enabled => _GdsControlListItemStyle(
        backgroundColor: colors.surface.base,
        textColor: colors.text.grayBold,
        borderColor: null,
        borderWidth: 0,
        isControlSelected: false,
      ),
      GdsListItemState.focused => _GdsControlListItemStyle(
        backgroundColor: colors.surface.base,
        textColor: colors.text.grayBold,
        borderColor: colors.border.graySubtle,
        borderWidth: 2,
        isControlSelected: false,
      ),
      GdsListItemState.hovered => _GdsControlListItemStyle(
        backgroundColor: colors.surface.graySubtlest,
        textColor: colors.text.grayBold,
        borderColor: null,
        borderWidth: 0,
        isControlSelected: false,
      ),
      GdsListItemState.pressed => _GdsControlListItemStyle(
        backgroundColor: colors.surface.base,
        textColor: colors.text.grayBold,
        borderColor: null,
        borderWidth: 0,
        isControlSelected: true,
      ),
      GdsListItemState.disabled => _GdsControlListItemStyle(
        backgroundColor: colors.surface.base,
        textColor: colors.text.graySubtler,
        borderColor: null,
        borderWidth: 0,
        isControlSelected: false,
      ),
    };
  }
}
