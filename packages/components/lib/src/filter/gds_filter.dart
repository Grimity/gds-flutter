import 'package:flutter/widgets.dart';
import 'package:gds_components/src/common/common.dart';
import 'package:gds_foundation/gds_foundation.dart';
import 'package:gds_tokens/gds_tokens.dart';

import '../button/gds_button_state.dart';

enum GdsFilterType { outline, text }

class GdsFilterStyle {
  const GdsFilterStyle._();

  static Color backgroundColor(
    GdsSemanticColor colors,
    GdsFilterType type,
    GdsButtonState state,
  ) => switch ((type, state)) {
    (GdsFilterType.outline, GdsButtonState.enabled) => colors.surface.base,
    (GdsFilterType.outline, GdsButtonState.focused) => colors.surface.base,
    (GdsFilterType.outline, GdsButtonState.hovered) => colors.surface.graySubtlest,
    (GdsFilterType.outline, GdsButtonState.pressed) => colors.surface.base,
    (GdsFilterType.outline, GdsButtonState.disabled) => colors.surface.base,

    (GdsFilterType.text, GdsButtonState.enabled) => GdsColors.transparent,
    (GdsFilterType.text, GdsButtonState.focused) => GdsColors.transparent,
    (GdsFilterType.text, GdsButtonState.hovered) => colors.surface.graySubtlest,
    (GdsFilterType.text, GdsButtonState.pressed) => GdsColors.transparent,
    (GdsFilterType.text, GdsButtonState.disabled) => GdsColors.transparent,
  };

  static BoxBorder? border(
    GdsSemanticColor colors,
    GdsFilterType type,
    GdsButtonState state,
  ) => switch ((type, state)) {
    (GdsFilterType.outline, GdsButtonState.enabled) => Border.all(
      color: colors.border.graySubtle,
      width: 1,
    ),
    (GdsFilterType.outline, GdsButtonState.focused) => Border.all(
      color: colors.border.grayNormal,
      width: 2,
    ),
    (GdsFilterType.outline, GdsButtonState.hovered) => Border.all(
      color: colors.border.graySubtle,
      width: 1,
    ),
    (GdsFilterType.outline, GdsButtonState.pressed) => Border.all(
      color: colors.border.grayBold,
      width: 1,
    ),
    (GdsFilterType.outline, GdsButtonState.disabled) => Border.all(
      color: colors.border.graySubtler,
      width: 1,
    ),
    (GdsFilterType.text, GdsButtonState.enabled) => null,
    (GdsFilterType.text, GdsButtonState.focused) => Border.all(
      color: colors.border.grayNormal,
      width: 2,
    ),
    (GdsFilterType.text, GdsButtonState.hovered) => null,
    (GdsFilterType.text, GdsButtonState.pressed) => null,
    (GdsFilterType.text, GdsButtonState.disabled) => null,
  };

  static BorderRadiusGeometry? borderRadius(GdsFilterType type) => switch (type) {
    GdsFilterType.outline => BorderRadius.circular(GdsRadius.sm),
    GdsFilterType.text => null,
  };

  static Color textColor(
    GdsSemanticColor colors,
    GdsButtonState state,
  ) => switch (state) {
    GdsButtonState.enabled => colors.text.grayBold,
    GdsButtonState.focused => colors.text.grayBold,
    GdsButtonState.hovered => colors.text.grayBold,
    GdsButtonState.pressed => colors.text.grayBold,
    GdsButtonState.disabled => colors.text.graySubtler,
  };

  static Color iconColor(
    GdsSemanticColor colors,
    GdsButtonState state,
  ) => switch (state) {
    GdsButtonState.enabled => colors.icon.grayBold,
    GdsButtonState.focused => colors.icon.grayBold,
    GdsButtonState.hovered => colors.icon.grayBold,
    GdsButtonState.pressed => colors.icon.grayBold,
    GdsButtonState.disabled => colors.icon.graySubtler,
  };

  static double height(GdsFilterType type) => switch (type) {
    GdsFilterType.outline => 42,
    GdsFilterType.text => 32,
  };

  static EdgeInsets get padding => const EdgeInsets.only(left: 12, right: 10);

  static double get gap => GdsSpacing.spacing8;

  static TextStyle get textStyle => GdsTypography.label3;

  static GdsIcon icon(bool expanded) => expanded ? GdsIcon.chevronUp : GdsIcon.chevronDown;
}

class GdsFilter extends StatefulWidget {
  final String text;
  final GdsFilterType type;
  final bool expanded;
  final bool enabled;
  final VoidCallback? onTap;

  const GdsFilter({
    super.key,
    required this.text,
    this.type = GdsFilterType.outline,
    this.expanded = false,
    this.enabled = true,
    this.onTap,
  });

  @override
  State<GdsFilter> createState() => _GdsFilterState();
}

class _GdsFilterState extends State<GdsFilter> {
  bool _isHovered = false;
  bool _isPressed = false;
  bool _isFocused = false;

  bool get _isInteractive => widget.enabled;

  GdsButtonState get _state {
    if (!widget.enabled) return GdsButtonState.disabled;
    if (_isPressed) return GdsButtonState.pressed;
    if (_isFocused) return GdsButtonState.focused;
    if (_isHovered) return GdsButtonState.hovered;
    return GdsButtonState.enabled;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final state = _state;
    final type = widget.type;

    return Focus(
      canRequestFocus: _isInteractive,
      skipTraversal: !_isInteractive,
      onFocusChange: (focused) => setState(() => _isFocused = focused),
      child: MouseRegion(
        cursor: _isInteractive ? SystemMouseCursors.click : SystemMouseCursors.basic,
        onEnter: _isInteractive ? (_) => setState(() => _isHovered = true) : null,
        onExit: _isInteractive ? (_) => setState(() => _isHovered = false) : null,
        child: GdsGesture(
          onTapDown: _isInteractive ? (_) => setState(() => _isPressed = true) : null,
          onTapUp: _isInteractive ? (_) => setState(() => _isPressed = false) : null,
          onTapCancel: _isInteractive ? () => setState(() => _isPressed = false) : null,
          onTap: _isInteractive && widget.onTap != null ? widget.onTap : null,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: GdsFilterStyle.backgroundColor(colors, type, state),
              border: GdsFilterStyle.border(colors, type, state),
              borderRadius: GdsFilterStyle.borderRadius(type),
            ),
            child: SizedBox(
              height: GdsFilterStyle.height(type),
              child: Padding(
                padding: GdsFilterStyle.padding,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        widget.text,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GdsFilterStyle.textStyle.copyWith(
                          color: GdsFilterStyle.textColor(colors, state),
                        ),
                      ),
                    ),
                    SizedBox(width: GdsFilterStyle.gap),
                    GdsFilterStyle.icon(widget.expanded).build(
                      color: GdsFilterStyle.iconColor(colors, state),
                      width: GdsIconSize.v16,
                      height: GdsIconSize.v16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
