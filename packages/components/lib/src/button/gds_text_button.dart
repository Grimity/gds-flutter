import 'package:flutter/widgets.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_foundation/gds_foundation.dart';
import 'package:gds_tokens/gds_tokens.dart';

enum GdsTextButtonVariant {
  primary,
  assistive;

  Color backgroundColor(
    GdsSemanticColor colors,
    GdsButtonState state, {
    bool loading = false,
  }) {
    if (loading) return GdsColors.transparent;
    return switch ((this, state)) {
      (GdsTextButtonVariant.primary, GdsButtonState.enabled) =>
        GdsColors.transparent,
      (GdsTextButtonVariant.primary, GdsButtonState.focused) =>
        GdsColors.transparent,
      (GdsTextButtonVariant.primary, GdsButtonState.hovered) =>
        colors.surface.primarySubtlest,
      (GdsTextButtonVariant.primary, GdsButtonState.pressed) =>
        GdsColors.transparent,
      (GdsTextButtonVariant.primary, GdsButtonState.disabled) =>
        GdsColors.transparent,

      (GdsTextButtonVariant.assistive, GdsButtonState.enabled) =>
        GdsColors.transparent,
      (GdsTextButtonVariant.assistive, GdsButtonState.focused) =>
        GdsColors.transparent,
      (GdsTextButtonVariant.assistive, GdsButtonState.hovered) =>
        colors.surface.graySubtlest,
      (GdsTextButtonVariant.assistive, GdsButtonState.pressed) =>
        GdsColors.transparent,
      (GdsTextButtonVariant.assistive, GdsButtonState.disabled) =>
        GdsColors.transparent,
    };
  }

  Color textColor(GdsSemanticColor colors, GdsButtonState state) =>
      switch ((this, state)) {
        (GdsTextButtonVariant.primary, GdsButtonState.enabled) =>
          colors.text.primaryNormal,
        (GdsTextButtonVariant.primary, GdsButtonState.focused) =>
          colors.text.primaryNormal,
        (GdsTextButtonVariant.primary, GdsButtonState.hovered) =>
          colors.text.primaryNormal,
        (GdsTextButtonVariant.primary, GdsButtonState.pressed) =>
          colors.text.primaryNormal,
        (GdsTextButtonVariant.primary, GdsButtonState.disabled) =>
          colors.text.graySubtler,

        (GdsTextButtonVariant.assistive, GdsButtonState.enabled) =>
          colors.text.grayBold,
        (GdsTextButtonVariant.assistive, GdsButtonState.focused) =>
          colors.text.grayBold,
        (GdsTextButtonVariant.assistive, GdsButtonState.hovered) =>
          colors.text.grayBold,
        (GdsTextButtonVariant.assistive, GdsButtonState.pressed) =>
          colors.text.grayBold,
        (GdsTextButtonVariant.assistive, GdsButtonState.disabled) =>
          colors.text.graySubtler,
      };

  Color iconColor(GdsSemanticColor colors, GdsButtonState state) =>
      switch ((this, state)) {
        (GdsTextButtonVariant.primary, GdsButtonState.enabled) =>
          colors.icon.primaryNormal,
        (GdsTextButtonVariant.primary, GdsButtonState.focused) =>
          colors.icon.primaryNormal,
        (GdsTextButtonVariant.primary, GdsButtonState.hovered) =>
          colors.icon.primaryNormal,
        (GdsTextButtonVariant.primary, GdsButtonState.pressed) =>
          colors.icon.primaryNormal,
        (GdsTextButtonVariant.primary, GdsButtonState.disabled) =>
          colors.icon.graySubtler,

        (GdsTextButtonVariant.assistive, GdsButtonState.enabled) =>
          colors.icon.grayBold,
        (GdsTextButtonVariant.assistive, GdsButtonState.focused) =>
          colors.icon.grayBold,
        (GdsTextButtonVariant.assistive, GdsButtonState.hovered) =>
          colors.icon.grayBold,
        (GdsTextButtonVariant.assistive, GdsButtonState.pressed) =>
          colors.icon.grayBold,
        (GdsTextButtonVariant.assistive, GdsButtonState.disabled) =>
          colors.icon.graySubtler,
      };

  BoxBorder? border(
    GdsSemanticColor colors,
    GdsButtonState state, {
    bool loading = false,
  }) {
    if (loading) return null;
    return switch (state) {
      GdsButtonState.enabled => null,
      GdsButtonState.focused => Border.all(
        color: colors.border.grayNormal,
        width: 2,
      ),
      GdsButtonState.hovered => null,
      GdsButtonState.pressed => null,
      GdsButtonState.disabled => null,
    };
  }
}

enum GdsTextButtonSize {
  large,
  regular,
  small;

  double get iconSize => switch (this) {
    GdsTextButtonSize.large => GdsIconSize.v24,
    GdsTextButtonSize.regular => GdsIconSize.v20,
    GdsTextButtonSize.small => GdsIconSize.v16,
  };

  TextStyle get textStyle => switch (this) {
    GdsTextButtonSize.large => GdsTypography.label1,
    GdsTextButtonSize.regular => GdsTypography.label3,
    GdsTextButtonSize.small => GdsTypography.label6,
  };

  double get gap => switch (this) {
    GdsTextButtonSize.large => GdsSpacing.spacing6,
    GdsTextButtonSize.regular => GdsSpacing.spacing6,
    GdsTextButtonSize.small => GdsSpacing.spacing4,
  };
}

class GdsTextButton extends StatefulWidget {
  final String text;
  final GdsIcon? leadingIcon;
  final GdsIcon? trailingIcon;
  final GdsTextButtonSize size;
  final GdsTextButtonVariant variant;
  final VoidCallback? onPressed;
  final bool enabled;
  final bool loading;

  const GdsTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.size = GdsTextButtonSize.regular,
    this.variant = GdsTextButtonVariant.primary,
    this.enabled = true,
    this.loading = false,
    this.leadingIcon,
    this.trailingIcon,
  }) : assert(
         leadingIcon == null || trailingIcon == null,
         'leadingIcon과 trailingIcon을 동시에 사용할 수 없습니다.',
       );

  @override
  State<GdsTextButton> createState() => _GdsTextButtonState();
}

class _GdsTextButtonState extends State<GdsTextButton> {
  bool _isHovered = false;
  bool _isPressed = false;
  bool _isFocused = false;

  bool get _isInteractive => widget.enabled && !widget.loading;

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
    final size = widget.size;
    final state = _buttonState;
    final variant = widget.variant;

    return Focus(
      onFocusChange: (focused) => setState(() => _isFocused = focused),
      child: MouseRegion(
        cursor: _isInteractive
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTapDown: _isInteractive
              ? (_) => setState(() => _isPressed = true)
              : null,
          onTapUp: _isInteractive
              ? (_) => setState(() => _isPressed = false)
              : null,
          onTapCancel: _isInteractive
              ? () => setState(() => _isPressed = false)
              : null,
          onTap: _isInteractive ? widget.onPressed : null,
          child: Container(
            decoration: BoxDecoration(
              color: variant.backgroundColor(
                colors,
                state,
                loading: widget.loading,
              ),
              border: variant.border(colors, state, loading: widget.loading),
              borderRadius: BorderRadius.circular(GdsRadius.xs),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildChildren(colors, state, size, variant),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildChildren(
    GdsSemanticColor colors,
    GdsButtonState state,
    GdsTextButtonSize size,
    GdsTextButtonVariant variant,
  ) {
    if (widget.loading) {
      return [GdsCircularLoading(width: size.iconSize, height: size.iconSize)];
    }

    final children = <Widget>[];

    if (widget.leadingIcon != null) {
      children.add(
        widget.leadingIcon!.build(
          color: variant.iconColor(colors, state),
          width: size.iconSize,
          height: size.iconSize,
        ),
      );
      children.add(SizedBox(width: size.gap));
    }

    children.add(
      Text(
        widget.text,
        style: size.textStyle.copyWith(color: variant.textColor(colors, state)),
      ),
    );

    if (widget.trailingIcon != null) {
      children.add(SizedBox(width: size.gap));
      children.add(
        widget.trailingIcon!.build(
          color: variant.iconColor(colors, state),
          width: size.iconSize,
          height: size.iconSize,
        ),
      );
    }

    return children;
  }
}
