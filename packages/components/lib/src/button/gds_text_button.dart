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
      (GdsTextButtonVariant.primary, GdsButtonState.enabled) => GdsColors.transparent,
      (GdsTextButtonVariant.primary, GdsButtonState.focused) => GdsColors.transparent,
      (GdsTextButtonVariant.primary, GdsButtonState.hovered) => colors.surface.primarySubtlest,
      (GdsTextButtonVariant.primary, GdsButtonState.pressed) => GdsColors.transparent,
      (GdsTextButtonVariant.primary, GdsButtonState.disabled) => GdsColors.transparent,

      (GdsTextButtonVariant.assistive, GdsButtonState.enabled) => GdsColors.transparent,
      (GdsTextButtonVariant.assistive, GdsButtonState.focused) => GdsColors.transparent,
      (GdsTextButtonVariant.assistive, GdsButtonState.hovered) => colors.surface.graySubtlest,
      (GdsTextButtonVariant.assistive, GdsButtonState.pressed) => GdsColors.transparent,
      (GdsTextButtonVariant.assistive, GdsButtonState.disabled) => GdsColors.transparent,
    };
  }

  Color textColor(GdsSemanticColor colors, GdsButtonState state, GdsTextButtonSize size) =>
      switch ((this, state, size)) {
        (GdsTextButtonVariant.primary, GdsButtonState.enabled, _) => colors.text.primaryNormal,
        (GdsTextButtonVariant.primary, GdsButtonState.focused, _) => colors.text.primaryNormal,
        (GdsTextButtonVariant.primary, GdsButtonState.hovered, _) => colors.text.primaryNormal,
        (GdsTextButtonVariant.primary, GdsButtonState.pressed, _) => colors.text.primaryNormal,
        (GdsTextButtonVariant.primary, GdsButtonState.disabled, _) => colors.text.graySubtler,

        (GdsTextButtonVariant.assistive, GdsButtonState.enabled, GdsTextButtonSize.small) => colors.text.graySubtle,
        (GdsTextButtonVariant.assistive, GdsButtonState.focused, GdsTextButtonSize.small) => colors.text.graySubtle,

        (GdsTextButtonVariant.assistive, GdsButtonState.enabled, _) => colors.text.grayBold,
        (GdsTextButtonVariant.assistive, GdsButtonState.focused, _) => colors.text.grayBold,
        (GdsTextButtonVariant.assistive, GdsButtonState.hovered, _) => colors.text.grayBold,
        (GdsTextButtonVariant.assistive, GdsButtonState.pressed, _) => colors.text.grayBold,
        (GdsTextButtonVariant.assistive, GdsButtonState.disabled, _) => colors.text.graySubtler,
      };

  Color iconColor(GdsSemanticColor colors, GdsButtonState state, GdsTextButtonSize size) =>
      switch ((this, state, size)) {
        (GdsTextButtonVariant.primary, GdsButtonState.enabled, _) => colors.icon.primaryNormal,
        (GdsTextButtonVariant.primary, GdsButtonState.focused, _) => colors.icon.primaryNormal,
        (GdsTextButtonVariant.primary, GdsButtonState.hovered, _) => colors.icon.primaryNormal,
        (GdsTextButtonVariant.primary, GdsButtonState.pressed, _) => colors.icon.primaryNormal,
        (GdsTextButtonVariant.primary, GdsButtonState.disabled, _) => colors.icon.graySubtler,

        (GdsTextButtonVariant.assistive, GdsButtonState.enabled, GdsTextButtonSize.small) => colors.icon.graySubtle,
        (GdsTextButtonVariant.assistive, GdsButtonState.focused, GdsTextButtonSize.small) => colors.icon.graySubtle,

        (GdsTextButtonVariant.assistive, GdsButtonState.enabled, _) => colors.icon.grayBold,
        (GdsTextButtonVariant.assistive, GdsButtonState.focused, _) => colors.icon.grayBold,
        (GdsTextButtonVariant.assistive, GdsButtonState.hovered, _) => colors.icon.grayBold,
        (GdsTextButtonVariant.assistive, GdsButtonState.pressed, _) => colors.icon.grayBold,
        (GdsTextButtonVariant.assistive, GdsButtonState.disabled, _) => colors.icon.graySubtler,
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

  /// null이면 버튼 상태 색상을 따르고, 값이 있으면 해당 색상을 아이콘에 우선 적용합니다.
  final Color? iconColor;

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
    this.iconColor,
  }) : assert(
         leadingIcon == null || trailingIcon == null,
         'leadingIcon과 trailingIcon을 동시에 사용할 수 없습니다.',
       );

  @override
  State<GdsTextButton> createState() => _GdsTextButtonState();
}

class _GdsTextButtonState extends State<GdsTextButton> with SingleTickerProviderStateMixin {
  static const _iconAnimationDuration = Duration(milliseconds: 160);

  late final AnimationController _iconAnimationController;
  bool _isHovered = false;
  bool _isPressed = false;
  bool _isFocused = false;

  bool get _isInteractive => widget.enabled && !widget.loading;

  bool get _hasIcon => widget.leadingIcon != null || widget.trailingIcon != null;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = AnimationController(
      vsync: this,
      duration: _iconAnimationDuration,
    );
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

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
        cursor: _isInteractive ? SystemMouseCursors.click : SystemMouseCursors.basic,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GdsGesture(
          onTapDown: _isInteractive ? (_) => setState(() => _isPressed = true) : null,
          onTapUp: _isInteractive ? (_) => setState(() => _isPressed = false) : null,
          onTapCancel: _isInteractive ? () => setState(() => _isPressed = false) : null,
          onTap: _isInteractive && widget.onPressed != null
              ? () {
                  widget.onPressed?.call();
                  if (_hasIcon) {
                    _iconAnimationController.forward(from: 0);
                  }
                }
              : null,
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
      final leadingIcon = widget.leadingIcon!.build(
        color: widget.iconColor ?? variant.iconColor(colors, state, size),
        width: size.iconSize,
        height: size.iconSize,
      );

      children.add(
        GdsIconTapScaleAnimation(
          controller: _iconAnimationController,
          child: leadingIcon,
        ),
      );
      children.add(SizedBox(width: size.gap));
    }

    children.add(
      Text(
        widget.text,
        style: size.textStyle.copyWith(color: variant.textColor(colors, state, size)),
      ),
    );

    if (widget.trailingIcon != null) {
      final trailingIcon = widget.trailingIcon!.build(
        color: widget.iconColor ?? variant.iconColor(colors, state, size),
        width: size.iconSize,
        height: size.iconSize,
      );

      children.add(SizedBox(width: size.gap));
      children.add(
        GdsIconTapScaleAnimation(
          controller: _iconAnimationController,
          child: trailingIcon,
        ),
      );
    }

    return children;
  }
}
