import 'package:flutter/widgets.dart';
import 'package:gds_foundation/gds_foundation.dart';
import 'package:gds_tokens/gds_tokens.dart';

import 'gds_button_state.dart';

enum GdsIconButtonType {
  small,
  normal,
  outlined,
  solid;

  double get iconSize => switch (this) {
    GdsIconButtonType.small => GdsIconSize.v16,
    GdsIconButtonType.normal => GdsIconSize.v24,
    GdsIconButtonType.outlined => GdsIconSize.v16,
    GdsIconButtonType.solid => GdsIconSize.v16,
  };

  double get padding => switch (this) {
    GdsIconButtonType.small => GdsSpacing.spacing4,
    GdsIconButtonType.normal => GdsSpacing.spacing4,
    GdsIconButtonType.outlined => GdsSpacing.spacing8,
    GdsIconButtonType.solid => GdsSpacing.spacing8,
  };

  Color iconColor(GdsSemanticColor colors, GdsButtonState state) => switch ((
    this,
    state,
  )) {
    (GdsIconButtonType.small, GdsButtonState.enabled) => colors.icon.grayBold,
    (GdsIconButtonType.small, GdsButtonState.focused) => colors.icon.grayBold,
    (GdsIconButtonType.small, GdsButtonState.hovered) => colors.icon.grayBold,
    (GdsIconButtonType.small, GdsButtonState.pressed) => colors.icon.grayBold,
    (GdsIconButtonType.small, GdsButtonState.disabled) => colors.icon.graySubtler,

    (GdsIconButtonType.normal, GdsButtonState.enabled) => colors.icon.grayBold,
    (GdsIconButtonType.normal, GdsButtonState.focused) => colors.icon.grayBold,
    (GdsIconButtonType.normal, GdsButtonState.hovered) => colors.icon.grayBold,
    (GdsIconButtonType.normal, GdsButtonState.pressed) => colors.icon.grayBold,
    (GdsIconButtonType.normal, GdsButtonState.disabled) => colors.icon.graySubtler,

    (GdsIconButtonType.outlined, GdsButtonState.enabled) => colors.icon.grayBold,
    (GdsIconButtonType.outlined, GdsButtonState.focused) => colors.icon.grayBold,
    (GdsIconButtonType.outlined, GdsButtonState.hovered) => colors.icon.grayBold,
    (GdsIconButtonType.outlined, GdsButtonState.pressed) => colors.icon.grayBold,
    (GdsIconButtonType.outlined, GdsButtonState.disabled) => colors.icon.graySubtler,

    (GdsIconButtonType.solid, GdsButtonState.enabled) => colors.icon.white,
    (GdsIconButtonType.solid, GdsButtonState.focused) => colors.icon.white,
    (GdsIconButtonType.solid, GdsButtonState.hovered) => colors.icon.white,
    (GdsIconButtonType.solid, GdsButtonState.pressed) => colors.icon.white,
    (GdsIconButtonType.solid, GdsButtonState.disabled) => colors.icon.graySubtler,
  };

  Color? backgroundColor(
    GdsSemanticColor colors,
    GdsButtonState state,
  ) => switch ((this, state)) {
    (GdsIconButtonType.small, GdsButtonState.enabled) => null,
    (GdsIconButtonType.small, GdsButtonState.focused) => null,
    (GdsIconButtonType.small, GdsButtonState.hovered) => colors.surface.graySubtlest,
    (GdsIconButtonType.small, GdsButtonState.pressed) => colors.surface.graySubtler,
    (GdsIconButtonType.small, GdsButtonState.disabled) => null,

    (GdsIconButtonType.normal, GdsButtonState.enabled) => null,
    (GdsIconButtonType.normal, GdsButtonState.focused) => null,
    (GdsIconButtonType.normal, GdsButtonState.hovered) => colors.surface.graySubtlest,
    (GdsIconButtonType.normal, GdsButtonState.pressed) => colors.surface.graySubtler,
    (GdsIconButtonType.normal, GdsButtonState.disabled) => null,

    (GdsIconButtonType.outlined, GdsButtonState.enabled) => colors.surface.base,
    (GdsIconButtonType.outlined, GdsButtonState.focused) => colors.surface.base,
    (GdsIconButtonType.outlined, GdsButtonState.hovered) => colors.surface.graySubtlest,
    (GdsIconButtonType.outlined, GdsButtonState.pressed) => colors.surface.graySubtler,
    (GdsIconButtonType.outlined, GdsButtonState.disabled) => colors.surface.graySubtlest,

    (GdsIconButtonType.solid, GdsButtonState.enabled) => colors.bg.overlayBlack,
    (GdsIconButtonType.solid, GdsButtonState.focused) => colors.bg.overlayBlack,
    (GdsIconButtonType.solid, GdsButtonState.hovered) => colors.bg.overlayBlack,
    (GdsIconButtonType.solid, GdsButtonState.pressed) => colors.bg.overlayBlack,
    (GdsIconButtonType.solid, GdsButtonState.disabled) => colors.bg.overlayBlack,
  };

  BoxBorder? border(GdsSemanticColor colors, GdsButtonState state) => switch ((this, state)) {
    (GdsIconButtonType.small, GdsButtonState.enabled) => null,
    (GdsIconButtonType.small, GdsButtonState.focused) => Border.all(
      color: colors.border.grayNormal,
      width: 2,
    ),
    (GdsIconButtonType.small, GdsButtonState.hovered) => null,
    (GdsIconButtonType.small, GdsButtonState.pressed) => null,
    (GdsIconButtonType.small, GdsButtonState.disabled) => null,

    (GdsIconButtonType.normal, GdsButtonState.enabled) => null,
    (GdsIconButtonType.normal, GdsButtonState.focused) => Border.all(
      color: colors.border.grayNormal,
      width: 2,
    ),
    (GdsIconButtonType.normal, GdsButtonState.hovered) => null,
    (GdsIconButtonType.normal, GdsButtonState.pressed) => null,
    (GdsIconButtonType.normal, GdsButtonState.disabled) => null,

    (GdsIconButtonType.outlined, GdsButtonState.enabled) => Border.all(
      color: colors.border.graySubtle,
      width: 1,
    ),
    (GdsIconButtonType.outlined, GdsButtonState.focused) => Border.all(
      color: colors.border.grayNormal,
      width: 2,
    ),
    (GdsIconButtonType.outlined, GdsButtonState.hovered) => Border.all(
      color: colors.border.grayNormal,
      width: 1,
    ),
    (GdsIconButtonType.outlined, GdsButtonState.pressed) => Border.all(
      color: colors.border.grayNormal,
      width: 1,
    ),
    (GdsIconButtonType.outlined, GdsButtonState.disabled) => Border.all(
      color: colors.border.graySubtle,
      width: 1,
    ),

    (GdsIconButtonType.solid, GdsButtonState.enabled) => null,
    (GdsIconButtonType.solid, GdsButtonState.focused) => Border.all(
      color: colors.border.grayNormal,
      width: 1,
    ),
    (GdsIconButtonType.solid, GdsButtonState.hovered) => null,
    (GdsIconButtonType.solid, GdsButtonState.pressed) => null,
    (GdsIconButtonType.solid, GdsButtonState.disabled) => null,
  };
}

class GdsIconButton extends StatefulWidget {
  final GdsIcon icon;
  final VoidCallback? onPressed;
  final GdsIconButtonType type;
  final bool enabled;

  const GdsIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.type = GdsIconButtonType.normal,
    this.enabled = true,
  });

  const GdsIconButton.small({
    super.key,
    required this.icon,
    required this.onPressed,
    this.enabled = true,
  }) : type = GdsIconButtonType.small;

  const GdsIconButton.normal({
    super.key,
    required this.icon,
    required this.onPressed,
    this.enabled = true,
  }) : type = GdsIconButtonType.normal;

  const GdsIconButton.outlined({
    super.key,
    required this.icon,
    required this.onPressed,
    this.enabled = true,
  }) : type = GdsIconButtonType.outlined;

  const GdsIconButton.solid({
    super.key,
    required this.icon,
    required this.onPressed,
    this.enabled = true,
  }) : type = GdsIconButtonType.solid;

  @override
  State<GdsIconButton> createState() => _GdsIconButtonState();
}

class _GdsIconButtonState extends State<GdsIconButton> {
  bool _isHovered = false;
  bool _isPressed = false;
  bool _isFocused = false;

  GdsButtonState get _buttonState {
    if (!widget.enabled) return GdsButtonState.disabled;
    if (_isPressed) return GdsButtonState.pressed;
    if (_isFocused) return GdsButtonState.focused;
    if (_isHovered) return GdsButtonState.hovered;
    return GdsButtonState.enabled;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final type = widget.type;
    final state = _buttonState;

    return Focus(
      onFocusChange: (focused) => setState(() => _isFocused = focused),
      child: MouseRegion(
        cursor: widget.enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTapDown: widget.enabled ? (_) => setState(() => _isPressed = true) : null,
          onTapUp: widget.enabled ? (_) => setState(() => _isPressed = false) : null,
          onTapCancel: widget.enabled ? () => setState(() => _isPressed = false) : null,
          onTap: widget.enabled ? widget.onPressed : null,
          child: Container(
            decoration: BoxDecoration(
              color: type.backgroundColor(colors, state),
              border: type.border(colors, state),
              borderRadius: BorderRadius.circular(GdsRadius.full),
            ),
            padding: EdgeInsets.all(type.padding),
            child: widget.icon.build(
              color: type.iconColor(colors, state),
              width: type.iconSize,
              height: type.iconSize,
            ),
          ),
        ),
      ),
    );
  }
}
