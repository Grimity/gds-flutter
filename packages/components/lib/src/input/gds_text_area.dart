import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gds_foundation/gds_foundation.dart';
import 'package:gds_tokens/gds_tokens.dart';

enum GdsTextAreaState { enabled, filled, focused, error, disabled }

enum GdsTextAreaType {
  defaultField,
  underline,
  text,
  small;

  Color backgroundColor(GdsSemanticColor colors, GdsTextAreaState state) => switch (state) {
    GdsTextAreaState.error => colors.status.negative.withValues(
      alpha: GdsOpacity.opacity10,
    ),
    GdsTextAreaState.disabled => colors.surface.graySubtlest,
    _ => GdsColors.transparent,
  };

  Border? border(GdsSemanticColor colors, GdsTextAreaState state) {
    final color = _borderColor(colors, state);
    return switch (this) {
      GdsTextAreaType.defaultField || GdsTextAreaType.small => Border.all(color: color),
      GdsTextAreaType.underline => Border(bottom: BorderSide(color: color)),
      GdsTextAreaType.text => null,
    };
  }

  Color _borderColor(GdsSemanticColor colors, GdsTextAreaState state) => switch (state) {
    GdsTextAreaState.error => colors.status.negative,
    GdsTextAreaState.disabled => colors.border.graySubtler,
    _ => colors.border.graySubtle,
  };

  Color inputTextColor(GdsSemanticColor colors, GdsTextAreaState state) => switch (state) {
    GdsTextAreaState.disabled => colors.text.graySubtler,
    _ => colors.text.grayBold,
  };

  Color placeholderColor(GdsSemanticColor colors, GdsTextAreaState state) => switch (state) {
    GdsTextAreaState.disabled => colors.text.graySubtler,
    _ => colors.text.graySubtle,
  };

  Color cursorColor(GdsSemanticColor colors, GdsTextAreaState state) => switch (state) {
    GdsTextAreaState.error => colors.status.negative,
    _ => colors.status.info,
  };

  Color countCurrentColor(GdsSemanticColor colors, GdsTextAreaState state) =>
      state == GdsTextAreaState.disabled ? colors.text.graySubtler : colors.text.grayNormal;

  Color countRestColor(GdsSemanticColor colors, GdsTextAreaState state) =>
      state == GdsTextAreaState.disabled ? colors.text.graySubtler : colors.text.graySubtle;

  BorderRadius? get borderRadius => switch (this) {
    GdsTextAreaType.defaultField || GdsTextAreaType.small => BorderRadius.circular(GdsRadius.sm),
    _ => null,
  };

  EdgeInsets get padding => switch (this) {
    GdsTextAreaType.defaultField || GdsTextAreaType.underline => const EdgeInsets.fromLTRB(
      GdsSpacing.spacing16,
      GdsSpacing.spacing16,
      GdsSpacing.spacing16,
      GdsSpacing.spacing12,
    ),
    GdsTextAreaType.text => const EdgeInsets.fromLTRB(
      0,
      GdsSpacing.spacing16,
      0,
      GdsSpacing.spacing12,
    ),
    GdsTextAreaType.small => const EdgeInsets.symmetric(
      horizontal: GdsSpacing.spacing16,
      vertical: GdsSpacing.spacing10,
    ),
  };

  TextStyle get textStyle => switch (this) {
    GdsTextAreaType.small => GdsTypography.label4,
    _ => GdsTypography.label2,
  };

  double get gap => switch (this) {
    GdsTextAreaType.small => GdsSpacing.spacing2,
    _ => GdsSpacing.spacing4,
  };

  double? get containerHeight => switch (this) {
    GdsTextAreaType.underline || GdsTextAreaType.text => 240,
    GdsTextAreaType.small => 100,
    _ => null,
  };

  double? get contentHeight => switch (this) {
    GdsTextAreaType.defaultField => 106,
    _ => null,
  };

  double? get minContainerHeight => switch (this) {
    GdsTextAreaType.small => 40,
    _ => null,
  };
}

class GdsTextArea extends StatefulWidget {
  final GdsTextAreaType type;
  final String? placeholder;
  final int? maxLength;
  final bool enabled;
  final bool error;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;

  const GdsTextArea({
    super.key,
    this.placeholder,
    this.maxLength,
    this.enabled = true,
    this.error = false,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onEditingComplete,
  }) : type = GdsTextAreaType.defaultField;

  const GdsTextArea.underline({
    super.key,
    this.placeholder,
    this.maxLength,
    this.enabled = true,
    this.error = false,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onEditingComplete,
  }) : type = GdsTextAreaType.underline;

  const GdsTextArea.text({
    super.key,
    this.placeholder,
    this.maxLength,
    this.enabled = true,
    this.error = false,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onEditingComplete,
  }) : type = GdsTextAreaType.text;

  const GdsTextArea.sm({
    super.key,
    this.placeholder,
    this.maxLength,
    this.enabled = true,
    this.error = false,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onEditingComplete,
  }) : type = GdsTextAreaType.small;

  @override
  State<GdsTextArea> createState() => _GdsTextAreaState();
}

class _GdsTextAreaState extends State<GdsTextArea> {
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
  }

  @override
  void didUpdateWidget(GdsTextArea oldWidget) {
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

  GdsTextAreaState get _fieldState {
    if (!widget.enabled) return GdsTextAreaState.disabled;
    if (widget.error) return GdsTextAreaState.error;
    if (_isFocused) return GdsTextAreaState.focused;
    if (_controller.text.isNotEmpty) return GdsTextAreaState.filled;
    return GdsTextAreaState.enabled;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final type = widget.type;
    final state = _fieldState;

    return _buildContainer(colors, type, state);
  }

  Widget _buildContainer(
    GdsSemanticColor colors,
    GdsTextAreaType type,
    GdsTextAreaState state,
  ) {
    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildContent(colors, type, state),
        if (widget.maxLength != null) ...[
          SizedBox(height: type.gap),
          _buildCountBadge(colors, state),
        ],
      ],
    );

    final inner = Container(
      padding: type.padding,
      decoration: BoxDecoration(
        color: type.backgroundColor(colors, state),
        border: type.border(colors, state),
        borderRadius: type.borderRadius,
      ),
      child: column,
    );

    final containerHeight = type.containerHeight;
    if (containerHeight != null) {
      return SizedBox(height: containerHeight, child: inner);
    }
    return inner;
  }

  Widget _buildContent(
    GdsSemanticColor colors,
    GdsTextAreaType type,
    GdsTextAreaState state,
  ) {
    final editableText = _buildEditableText(colors, type, state);
    final contentHeight = type.contentHeight;

    if (contentHeight != null) {
      return SizedBox(
        height: contentHeight,
        child: _buildStack(colors, type, state, editableText),
      );
    }

    return Expanded(child: _buildStack(colors, type, state, editableText));
  }

  Widget _buildStack(
    GdsSemanticColor colors,
    GdsTextAreaType type,
    GdsTextAreaState state,
    Widget editableText,
  ) {
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        if (widget.placeholder != null && _controller.text.isEmpty)
          IgnorePointer(
            child: Text(
              widget.placeholder!,
              style: type.textStyle.copyWith(
                color: type.placeholderColor(colors, state),
              ),
            ),
          ),
        editableText,
      ],
    );
  }

  Widget _buildEditableText(
    GdsSemanticColor colors,
    GdsTextAreaType type,
    GdsTextAreaState state,
  ) {
    return EditableText(
      controller: _controller,
      focusNode: _focusNode,
      style: type.textStyle.copyWith(color: type.inputTextColor(colors, state)),
      cursorColor: type.cursorColor(colors, state),
      backgroundCursorColor: GdsColors.transparent,
      readOnly: !widget.enabled,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      maxLines: null,
      inputFormatters: widget.maxLength != null ? [LengthLimitingTextInputFormatter(widget.maxLength)] : null,
    );
  }

  Widget _buildCountBadge(GdsSemanticColor colors, GdsTextAreaState state) {
    final current = _controller.text.length;
    final max = widget.maxLength!;

    return Align(
      alignment: Alignment.centerRight,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$current',
              style: GdsTypography.label5.copyWith(
                color: widget.type.countCurrentColor(colors, state),
              ),
            ),
            TextSpan(
              text: '/$max',
              style: GdsTypography.label5.copyWith(
                color: widget.type.countRestColor(colors, state),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
