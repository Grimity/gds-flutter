import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gds_foundation/gds_foundation.dart';
import 'package:gds_tokens/gds_tokens.dart';

enum GdsTextFieldState { enabled, filled, focused, error, success, disabled }

enum GdsTextFieldSize {
  medium,
  small;

  double height(GdsTextFieldType type) => switch (this) {
    GdsTextFieldSize.medium => type == GdsTextFieldType.search ? 48 : 52,
    GdsTextFieldSize.small => 42,
  };

  EdgeInsets padding(GdsTextFieldType type) => switch (type) {
    GdsTextFieldType.title => EdgeInsets.fromLTRB(
      this == GdsTextFieldSize.medium ? GdsSpacing.spacing12 : 0,
      0,
      this == GdsTextFieldSize.medium ? GdsSpacing.spacing12 : 0,
      GdsSpacing.spacing12,
    ),
    GdsTextFieldType.search => const EdgeInsets.symmetric(
      horizontal: GdsSpacing.spacing16,
    ),
    GdsTextFieldType.defaultField ||
    GdsTextFieldType.count => EdgeInsets.symmetric(
      horizontal: this == GdsTextFieldSize.medium
          ? GdsSpacing.spacing16
          : GdsSpacing.spacing12,
    ),
  };

  TextStyle textStyle(GdsTextFieldType type) => switch (type) {
    GdsTextFieldType.title =>
      this == GdsTextFieldSize.medium
          ? GdsTypography.title2
          : GdsTypography.label2,
    GdsTextFieldType.defaultField ||
    GdsTextFieldType.count ||
    GdsTextFieldType.search =>
      this == GdsTextFieldSize.medium
          ? GdsTypography.label2
          : GdsTypography.label4,
  };
}

enum GdsTextFieldType {
  defaultField,
  count,
  search,
  title;

  Color backgroundColor(GdsSemanticColor colors, GdsTextFieldState state) {
    if (this == GdsTextFieldType.search) return colors.surface.graySubtlest;
    if (this == GdsTextFieldType.title) return GdsColors.transparent;
    return switch (state) {
      GdsTextFieldState.error => colors.status.negative.withValues(
        alpha: GdsOpacity.opacity10,
      ),
      GdsTextFieldState.disabled => colors.surface.graySubtlest,
      GdsTextFieldState.enabled => GdsColors.transparent,
      GdsTextFieldState.filled => GdsColors.transparent,
      GdsTextFieldState.focused => GdsColors.transparent,
      GdsTextFieldState.success => GdsColors.transparent,
    };
  }

  Border border(GdsSemanticColor colors, GdsTextFieldState state) {
    final color = _borderColor(colors, state);
    if (this == GdsTextFieldType.title) {
      return Border(bottom: BorderSide(color: color));
    }
    return Border.all(color: color);
  }

  Color _borderColor(GdsSemanticColor colors, GdsTextFieldState state) {
    if (this == GdsTextFieldType.search) {
      return switch (state) {
        GdsTextFieldState.disabled => colors.border.graySubtler,
        GdsTextFieldState.enabled => colors.border.graySubtle,
        GdsTextFieldState.filled => colors.border.graySubtle,
        GdsTextFieldState.focused => colors.border.graySubtle,
        GdsTextFieldState.error => colors.border.graySubtle,
        GdsTextFieldState.success => colors.border.graySubtle,
      };
    }
    return switch (state) {
      GdsTextFieldState.enabled => colors.border.graySubtle,
      GdsTextFieldState.filled => colors.border.graySubtle,
      GdsTextFieldState.focused => colors.status.info,
      GdsTextFieldState.error => colors.status.negative,
      GdsTextFieldState.success => colors.status.positive,
      GdsTextFieldState.disabled => colors.border.graySubtler,
    };
  }

  Color inputTextColor(GdsSemanticColor colors, GdsTextFieldState state) =>
      switch (state) {
        GdsTextFieldState.disabled => colors.text.graySubtler,
        GdsTextFieldState.enabled => colors.text.grayBold,
        GdsTextFieldState.filled => colors.text.grayBold,
        GdsTextFieldState.focused => colors.text.grayBold,
        GdsTextFieldState.error => colors.text.grayBold,
        GdsTextFieldState.success => colors.text.grayBold,
      };

  Color placeholderColor(GdsSemanticColor colors, GdsTextFieldState state) =>
      switch (state) {
        GdsTextFieldState.disabled => colors.text.graySubtler,
        GdsTextFieldState.enabled => colors.text.graySubtle,
        GdsTextFieldState.filled => colors.text.graySubtle,
        GdsTextFieldState.focused => colors.text.graySubtle,
        GdsTextFieldState.error => colors.text.graySubtle,
        GdsTextFieldState.success => colors.text.graySubtle,
      };

  Color cursorColor(GdsSemanticColor colors, GdsTextFieldState state) =>
      switch (state) {
        GdsTextFieldState.error => colors.status.negative,
        GdsTextFieldState.success => colors.status.positive,
        GdsTextFieldState.enabled => colors.status.info,
        GdsTextFieldState.filled => colors.status.info,
        GdsTextFieldState.focused => colors.status.info,
        GdsTextFieldState.disabled => colors.status.info,
      };

  // count / title 타입 전용
  Color countCurrentColor(GdsSemanticColor colors, GdsTextFieldState state) =>
      state == GdsTextFieldState.disabled
      ? colors.text.graySubtler
      : colors.text.grayNormal;

  Color countRestColor(GdsSemanticColor colors, GdsTextFieldState state) =>
      state == GdsTextFieldState.disabled
      ? colors.text.graySubtler
      : colors.text.graySubtle;

  BorderRadius? get borderRadius => switch (this) {
    GdsTextFieldType.title => null,
    _ => BorderRadius.circular(GdsRadius.sm),
  };

  GdsIcon? get leadingIcon => switch (this) {
    GdsTextFieldType.search => GdsIcon.magnifierOutline,
    _ => null,
  };

  GdsIcon? trailingIcon({required bool hasText}) => switch (this) {
    GdsTextFieldType.search => hasText ? GdsIcon.closeCircleFill : null,
    _ => null,
  };
}

class GdsTextField extends StatefulWidget {
  final GdsTextFieldType type;
  final GdsTextFieldSize size;
  final String? placeholder;
  final int? maxLength;
  final String? mentionUser;
  final bool enabled;
  final bool error;
  final bool success;
  final bool obscureText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onMentionClear;
  final TextInputAction? textInputAction;

  const GdsTextField({
    super.key,
    this.placeholder,
    this.mentionUser,
    this.onMentionClear,
    this.size = GdsTextFieldSize.medium,
    this.enabled = true,
    this.error = false,
    this.success = false,
    this.obscureText = false,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onEditingComplete,
    this.textInputAction,
  }) : type = GdsTextFieldType.defaultField,
       maxLength = null;

  const GdsTextField.count({
    super.key,
    required int this.maxLength,
    this.placeholder,
    this.size = GdsTextFieldSize.medium,
    this.enabled = true,
    this.error = false,
    this.success = false,
    this.obscureText = false,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onEditingComplete,
    this.textInputAction,
  }) : type = GdsTextFieldType.count,
       mentionUser = null,
       onMentionClear = null;

  const GdsTextField.search({
    super.key,
    this.placeholder,
    this.size = GdsTextFieldSize.medium,
    this.enabled = true,
    this.obscureText = false,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onEditingComplete,
    this.textInputAction = TextInputAction.search,
  }) : type = GdsTextFieldType.search,
       maxLength = null,
       mentionUser = null,
       onMentionClear = null,
       error = false,
       success = false;

  const GdsTextField.title({
    super.key,
    this.placeholder,
    this.maxLength,
    this.size = GdsTextFieldSize.medium,
    this.enabled = true,
    this.obscureText = false,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onEditingComplete,
    this.textInputAction,
  }) : type = GdsTextFieldType.title,
       mentionUser = null,
       onMentionClear = null,
       error = false,
       success = false;

  @override
  State<GdsTextField> createState() => _GdsTextFieldState();
}

class _GdsTextFieldState extends State<GdsTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _ownsController = false;
  bool _ownsFocusNode = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _initController();
    _initFocusNode();
  }

  void _initController() {
    if (widget.controller == null) {
      _controller = TextEditingController();
      _ownsController = true;
    } else {
      _controller = widget.controller!;
      _ownsController = false;
    }
    _controller.addListener(_onTextChange);
  }

  void _initFocusNode() {
    if (widget.focusNode == null) {
      _focusNode = FocusNode();
      _ownsFocusNode = true;
    } else {
      _focusNode = widget.focusNode!;
      _ownsFocusNode = false;
    }
    _focusNode.addListener(_onFocusChange);
    _focusNode.onKeyEvent = _onKeyEvent;
  }

  KeyEventResult _onKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controller.text.isEmpty &&
        widget.mentionUser != null) {
      widget.onMentionClear?.call();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  void didUpdateWidget(GdsTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _controller.removeListener(_onTextChange);
      if (_ownsController) _controller.dispose();
      _initController();
    }
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode.removeListener(_onFocusChange);
      if (_ownsFocusNode) _focusNode.dispose();
      _initFocusNode();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChange);
    _focusNode.removeListener(_onFocusChange);
    if (_ownsController) _controller.dispose();
    if (_ownsFocusNode) _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() => setState(() => _isFocused = _focusNode.hasFocus);

  void _onTextChange() => setState(() {});

  void _onClear() {
    _controller.clear();
    widget.onChanged?.call('');
  }

  GdsTextFieldState get _fieldState {
    if (!widget.enabled) return GdsTextFieldState.disabled;
    if (widget.error) return GdsTextFieldState.error;
    if (widget.success) return GdsTextFieldState.success;
    if (_isFocused || widget.mentionUser != null)
      return GdsTextFieldState.focused;
    if (_controller.text.isNotEmpty) return GdsTextFieldState.filled;
    return GdsTextFieldState.enabled;
  }

  bool get _hasCount =>
      widget.type == GdsTextFieldType.count ||
      (widget.type == GdsTextFieldType.title && widget.maxLength != null);

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final type = widget.type;
    final size = widget.size;
    final state = _fieldState;

    return Container(
      height: size.height(type),
      padding: size.padding(type),
      decoration: BoxDecoration(
        color: type.backgroundColor(colors, state),
        border: type.border(colors, state),
        borderRadius: type.borderRadius,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildChildren(colors, type, size, state),
      ),
    );
  }

  List<Widget> _buildChildren(
    GdsSemanticColor colors,
    GdsTextFieldType type,
    GdsTextFieldSize size,
    GdsTextFieldState state,
  ) {
    final children = <Widget>[];
    final leading = type.leadingIcon;
    final trailing = type.trailingIcon(hasText: _controller.text.isNotEmpty);

    if (leading != null) {
      children.add(
        leading.build(
          color: type.placeholderColor(colors, state),
          width: GdsIconSize.v20,
          height: GdsIconSize.v20,
        ),
      );
      children.add(const SizedBox(width: GdsSpacing.spacing8));
    }

    if (widget.mentionUser != null) {
      children.add(
        Text(
          '@[${widget.mentionUser}]',
          style: GdsTypography.label3.copyWith(
            color: colors.text.primaryNormal,
          ),
        ),
      );
      children.add(const SizedBox(width: GdsSpacing.spacing6));
    }

    children.add(
      Expanded(
        child: Stack(
          alignment: AlignmentDirectional.centerStart,
          children: [
            if (widget.placeholder != null && _controller.text.isEmpty)
              IgnorePointer(
                child: Text(
                  widget.placeholder!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: size
                      .textStyle(type)
                      .copyWith(color: type.placeholderColor(colors, state)),
                ),
              ),
            EditableText(
              controller: _controller,
              focusNode: _focusNode,
              style: size
                  .textStyle(type)
                  .copyWith(color: type.inputTextColor(colors, state)),
              cursorColor: type.cursorColor(colors, state),
              backgroundCursorColor: GdsColors.transparent,
              obscureText: widget.obscureText,
              readOnly: !widget.enabled,
              onChanged: widget.onChanged,
              onEditingComplete: widget.onEditingComplete,
              textInputAction: widget.textInputAction,
              maxLines: 1,
              inputFormatters: widget.maxLength != null
                  ? [LengthLimitingTextInputFormatter(widget.maxLength)]
                  : null,
            ),
          ],
        ),
      ),
    );

    if (_hasCount) {
      children.add(const SizedBox(width: GdsSpacing.spacing8));
      children.add(_buildCountBadge(colors, state));
    } else if (trailing != null) {
      children.add(const SizedBox(width: GdsSpacing.spacing8));
      children.add(
        GestureDetector(
          onTap: _onClear,
          child: trailing.build(
            color: type.placeholderColor(colors, state),
            width: GdsIconSize.v20,
            height: GdsIconSize.v20,
          ),
        ),
      );
    }

    return children;
  }

  Widget _buildCountBadge(GdsSemanticColor colors, GdsTextFieldState state) {
    final current = _controller.text.length;
    final max = widget.maxLength;

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$current',
            style: GdsTypography.label5.copyWith(
              color: widget.type.countCurrentColor(colors, state),
            ),
          ),
          if (max != null)
            TextSpan(
              text: '/$max',
              style: GdsTypography.label5.copyWith(
                color: widget.type.countRestColor(colors, state),
              ),
            ),
        ],
      ),
    );
  }
}
