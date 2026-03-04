import 'package:flutter/widgets.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_foundation/gds_foundation.dart';
import 'package:gds_tokens/gds_tokens.dart';

enum GdsSolidButtonSize {
  large,
  regular,
  small;

  double get iconSize => switch (this) {
    GdsSolidButtonSize.large => GdsIconSize.v24,
    GdsSolidButtonSize.regular => GdsIconSize.v20,
    GdsSolidButtonSize.small => GdsIconSize.v16,
  };

  TextStyle get textStyle => switch (this) {
    GdsSolidButtonSize.large => GdsTypography.label1,
    GdsSolidButtonSize.regular => GdsTypography.label3,
    GdsSolidButtonSize.small => GdsTypography.label3,
  };

  double get gap => switch (this) {
    GdsSolidButtonSize.large => GdsSpacing.spacing6,
    GdsSolidButtonSize.regular => GdsSpacing.spacing6,
    GdsSolidButtonSize.small => GdsSpacing.spacing4,
  };

  double get verticalPadding => switch (this) {
    GdsSolidButtonSize.large => 14,
    GdsSolidButtonSize.regular => 11,
    GdsSolidButtonSize.small => GdsSpacing.spacing8,
  };

  double get horizontalPadding => switch (this) {
    GdsSolidButtonSize.large => GdsSpacing.spacing20,
    GdsSolidButtonSize.regular => GdsSpacing.spacing16,
    GdsSolidButtonSize.small => GdsSpacing.spacing12,
  };

  double get iconSideHorizontalPadding => switch (this) {
    GdsSolidButtonSize.large => GdsSpacing.spacing16,
    GdsSolidButtonSize.regular => GdsSpacing.spacing12,
    GdsSolidButtonSize.small => GdsSpacing.spacing10,
  };
}

class GdsSolidButtonStyle {
  const GdsSolidButtonStyle._();

  static Color backgroundColor(
    GdsSemanticColor colors,
    GdsButtonState state, {
    bool loading = false,
  }) {
    if (loading) return colors.surface.graySubtler;
    return switch (state) {
      GdsButtonState.enabled => colors.surface.inverse,
      GdsButtonState.focused => colors.surface.inverse,
      GdsButtonState.hovered => colors.surface.grayBold,
      GdsButtonState.pressed => colors.surface.inverse,
      GdsButtonState.disabled => colors.surface.graySubtlest,
    };
  }

  static Color textColor(GdsSemanticColor colors, GdsButtonState state) => switch (state) {
    GdsButtonState.enabled => colors.text.inverse,
    GdsButtonState.focused => colors.text.inverse,
    GdsButtonState.hovered => colors.text.inverse,
    GdsButtonState.pressed => colors.text.inverse,
    GdsButtonState.disabled => colors.text.graySubtler,
  };

  static Color iconColor(GdsSemanticColor colors, GdsButtonState state) => switch (state) {
    GdsButtonState.enabled => colors.icon.inverse,
    GdsButtonState.focused => colors.icon.inverse,
    GdsButtonState.hovered => colors.icon.inverse,
    GdsButtonState.pressed => colors.icon.inverse,
    GdsButtonState.disabled => colors.icon.graySubtler,
  };

  static BoxBorder? border(
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

  static EdgeInsets padding(
    GdsSolidButtonSize size, {
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

class GdsSolidButton extends StatefulWidget {
  final String? text;
  final GdsIcon? leadingIcon;
  final GdsIcon? trailingIcon;

  /// null이면 버튼 상태 색상을 따르고, 값이 있으면 해당 색상을 아이콘에 우선 적용합니다.
  final Color? iconColor;
  final GdsSolidButtonSize size;
  final VoidCallback? onPressed;
  final bool enabled;
  final bool loading;
  final bool expanded;

  const GdsSolidButton({
    super.key,
    required String this.text,
    required this.onPressed,
    this.size = GdsSolidButtonSize.regular,
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

  const GdsSolidButton.icon({
    super.key,
    required GdsIcon icon,
    required this.onPressed,
    this.size = GdsSolidButtonSize.regular,
    this.enabled = true,
    this.loading = false,
    this.expanded = false,
    this.iconColor,
  }) : text = null,
       leadingIcon = icon,
       trailingIcon = null;

  bool get _isIconOnly => text == null;

  @override
  State<GdsSolidButton> createState() => _GdsSolidButtonState();
}

class _GdsSolidButtonState extends State<GdsSolidButton> with SingleTickerProviderStateMixin {
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
              color: GdsSolidButtonStyle.backgroundColor(
                colors,
                state,
                loading: widget.loading,
              ),
              border: GdsSolidButtonStyle.border(
                colors,
                state,
                loading: widget.loading,
              ),
              borderRadius: BorderRadius.circular(GdsRadius.sm),
            ),
            padding: GdsSolidButtonStyle.padding(
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
    GdsSolidButtonSize size,
  ) {
    if (widget.loading) {
      return [GdsCircularLoading(width: size.iconSize, height: size.iconSize)];
    }

    if (widget._isIconOnly) {
      final icon = widget.leadingIcon!.build(
        color: widget.iconColor ?? GdsSolidButtonStyle.iconColor(colors, state),
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
        color: widget.iconColor ?? GdsSolidButtonStyle.iconColor(colors, state),
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
          color: GdsSolidButtonStyle.textColor(colors, state),
        ),
      ),
    );

    if (widget.trailingIcon != null) {
      final trailingIcon = widget.trailingIcon!.build(
        color: widget.iconColor ?? GdsSolidButtonStyle.iconColor(colors, state),
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
