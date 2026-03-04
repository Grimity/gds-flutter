import 'package:flutter/widgets.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_foundation/gds_foundation.dart';
import 'package:gds_tokens/gds_tokens.dart';

enum GdsOutlinedButtonSize {
  large,
  regular,
  small;

  double get iconSize => switch (this) {
    GdsOutlinedButtonSize.large => GdsIconSize.v24,
    GdsOutlinedButtonSize.regular => GdsIconSize.v20,
    GdsOutlinedButtonSize.small => GdsIconSize.v16,
  };

  TextStyle get textStyle => switch (this) {
    GdsOutlinedButtonSize.large => GdsTypography.label1,
    GdsOutlinedButtonSize.regular => GdsTypography.label3,
    GdsOutlinedButtonSize.small => GdsTypography.label3,
  };

  double get gap => switch (this) {
    GdsOutlinedButtonSize.large => GdsSpacing.spacing6,
    GdsOutlinedButtonSize.regular => GdsSpacing.spacing6,
    GdsOutlinedButtonSize.small => GdsSpacing.spacing4,
  };

  double get verticalPadding => switch (this) {
    GdsOutlinedButtonSize.large => 14,
    GdsOutlinedButtonSize.regular => 11,
    GdsOutlinedButtonSize.small => GdsSpacing.spacing8,
  };

  double get horizontalPadding => switch (this) {
    GdsOutlinedButtonSize.large => GdsSpacing.spacing20,
    GdsOutlinedButtonSize.regular => GdsSpacing.spacing16,
    GdsOutlinedButtonSize.small => GdsSpacing.spacing12,
  };

  double get iconSideHorizontalPadding => switch (this) {
    GdsOutlinedButtonSize.large => GdsSpacing.spacing16,
    GdsOutlinedButtonSize.regular => GdsSpacing.spacing12,
    GdsOutlinedButtonSize.small => GdsSpacing.spacing10,
  };
}

class GdsOutlinedButtonStyle {
  const GdsOutlinedButtonStyle._();

  static Color backgroundColor(
    GdsSemanticColor colors,
    GdsButtonState state, {
    bool loading = false,
  }) {
    if (loading) return GdsColors.transparent;
    return switch (state) {
      GdsButtonState.enabled => GdsColors.transparent,
      GdsButtonState.focused => GdsColors.transparent,
      GdsButtonState.hovered => colors.surface.graySubtlest,
      GdsButtonState.pressed => colors.surface.graySubtler,
      GdsButtonState.disabled => GdsColors.transparent,
    };
  }

  static Color textColor(GdsSemanticColor colors, GdsButtonState state) => switch (state) {
    GdsButtonState.enabled => colors.text.grayBold,
    GdsButtonState.focused => colors.text.grayBold,
    GdsButtonState.hovered => colors.text.grayBold,
    GdsButtonState.pressed => colors.text.grayBold,
    GdsButtonState.disabled => colors.text.graySubtler,
  };

  static Color iconColor(GdsSemanticColor colors, GdsButtonState state) => switch (state) {
    GdsButtonState.enabled => colors.icon.grayBold,
    GdsButtonState.focused => colors.icon.grayBold,
    GdsButtonState.hovered => colors.icon.grayBold,
    GdsButtonState.pressed => colors.icon.grayBold,
    GdsButtonState.disabled => colors.icon.graySubtler,
  };

  static BoxBorder border(
    GdsSemanticColor colors,
    GdsButtonState state, {
    bool loading = false,
  }) {
    if (loading) return Border.all(color: colors.border.grayNormal, width: 1);
    return switch (state) {
      GdsButtonState.enabled => Border.all(
        color: colors.border.graySubtle,
        width: 1,
      ),
      GdsButtonState.focused => Border.all(
        color: colors.border.grayNormal,
        width: 2,
      ),
      GdsButtonState.hovered => Border.all(
        color: colors.border.grayNormal,
        width: 1,
      ),
      GdsButtonState.pressed => Border.all(
        color: colors.border.grayNormal,
        width: 1,
      ),
      GdsButtonState.disabled => Border.all(
        color: colors.border.graySubtler,
        width: 1,
      ),
    };
  }

  static EdgeInsets padding(
    GdsOutlinedButtonSize size, {
    required bool isIconOnly,
    required bool loading,
    required bool hasLeadingIcon,
    required bool hasTrailingIcon,
  }) {
    final vp = size.verticalPadding;
    final hp = size.horizontalPadding;

    if (isIconOnly) return EdgeInsets.all(vp);
    if (loading) return EdgeInsets.symmetric(horizontal: hp, vertical: vp);

    if (hasLeadingIcon) {
      return EdgeInsets.fromLTRB(size.iconSideHorizontalPadding, vp, hp, vp);
    }

    if (hasTrailingIcon) {
      return EdgeInsets.fromLTRB(hp, vp, size.iconSideHorizontalPadding, vp);
    }

    return EdgeInsets.symmetric(horizontal: hp, vertical: vp);
  }
}

class GdsOutlinedButton extends StatefulWidget {
  final String? text;
  final GdsIcon? leadingIcon;
  final GdsIcon? trailingIcon;

  /// null이면 버튼 상태 색상을 따르고, 값이 있으면 해당 색상을 아이콘에 우선 적용합니다.
  final Color? iconColor;
  final GdsOutlinedButtonSize size;
  final VoidCallback? onPressed;
  final bool enabled;
  final bool loading;
  final bool expanded;

  const GdsOutlinedButton({
    super.key,
    required String this.text,
    required this.onPressed,
    this.size = GdsOutlinedButtonSize.regular,
    this.enabled = true,
    this.loading = false,
    this.expanded = false,
    this.leadingIcon,
    this.trailingIcon,
    this.iconColor,
  }) : assert(
         leadingIcon == null || trailingIcon == null,
         'leadingIcon과 trailingIcon을 동시에 사용할 수 없습니다.',
       );

  const GdsOutlinedButton.icon({
    super.key,
    required GdsIcon icon,
    required this.onPressed,
    this.size = GdsOutlinedButtonSize.regular,
    this.enabled = true,
    this.loading = false,
    this.expanded = false,
    this.iconColor,
  }) : text = null,
       leadingIcon = icon,
       trailingIcon = null;

  bool get _isIconOnly => text == null;

  @override
  State<GdsOutlinedButton> createState() => _GdsOutlinedButtonState();
}

class _GdsOutlinedButtonState extends State<GdsOutlinedButton> with SingleTickerProviderStateMixin {
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

    return Focus(
      onFocusChange: (focused) => setState(() => _isFocused = focused),
      child: MouseRegion(
        cursor: _isInteractive ? SystemMouseCursors.click : SystemMouseCursors.basic,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
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
              color: GdsOutlinedButtonStyle.backgroundColor(
                colors,
                state,
                loading: widget.loading,
              ),
              border: GdsOutlinedButtonStyle.border(
                colors,
                state,
                loading: widget.loading,
              ),
              borderRadius: BorderRadius.circular(GdsRadius.sm),
            ),
            padding: GdsOutlinedButtonStyle.padding(
              size,
              isIconOnly: widget._isIconOnly,
              loading: widget.loading,
              hasLeadingIcon: widget.leadingIcon != null,
              hasTrailingIcon: widget.trailingIcon != null,
            ),
            child: Row(
              mainAxisSize: widget.expanded ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildChildren(colors, state, size),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildChildren(
    GdsSemanticColor colors,
    GdsButtonState state,
    GdsOutlinedButtonSize size,
  ) {
    if (widget.loading) {
      return [GdsCircularLoading(width: size.iconSize, height: size.iconSize)];
    }

    if (widget._isIconOnly) {
      final icon = widget.leadingIcon!.build(
        color: widget.iconColor ?? GdsOutlinedButtonStyle.iconColor(colors, state),
        width: size.iconSize,
        height: size.iconSize,
      );

      return [
        GdsIconTapScaleAnimation(
          controller: _iconAnimationController,
          child: icon,
        ),
      ];
    }

    final children = <Widget>[];

    if (widget.leadingIcon != null) {
      final leadingIcon = widget.leadingIcon!.build(
        color: widget.iconColor ?? GdsOutlinedButtonStyle.iconColor(colors, state),
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
        widget.text!,
        style: size.textStyle.copyWith(
          color: GdsOutlinedButtonStyle.textColor(colors, state),
        ),
      ),
    );

    if (widget.trailingIcon != null) {
      final trailingIcon = widget.trailingIcon!.build(
        color: widget.iconColor ?? GdsOutlinedButtonStyle.iconColor(colors, state),
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
