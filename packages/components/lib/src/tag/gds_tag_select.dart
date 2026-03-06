import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_foundation/gds_foundation.dart';
import 'package:gds_tokens/gds_tokens.dart';

enum GdsTagSelectState { enabled, filled, focused, full }

enum GdsTagSelectSize {
  medium,
  small;

  double get minHeight => switch (this) {
    GdsTagSelectSize.medium => 52,
    GdsTagSelectSize.small => 44,
  };

  EdgeInsets get padding => switch (this) {
    GdsTagSelectSize.medium => const EdgeInsets.all(8),
    GdsTagSelectSize.small => const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
  };

  GdsTagSize get tagSize => switch (this) {
    GdsTagSelectSize.medium => GdsTagSize.medium,
    GdsTagSelectSize.small => GdsTagSize.small,
  };
}

class GdsTagSelect extends StatefulWidget {
  final GdsTagSelectSize size;
  final List<String> tags;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final void Function(int index, String tag)? onTagRemove;

  const GdsTagSelect.medium({
    super.key,
    required this.tags,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.onTagRemove,
  }) : size = GdsTagSelectSize.medium;

  const GdsTagSelect.small({
    super.key,
    required this.tags,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.onTagRemove,
  }) : size = GdsTagSelectSize.small;

  @override
  State<GdsTagSelect> createState() => _GdsTagSelectState();
}

class _GdsTagSelectState extends State<GdsTagSelect> {
  static const double _focusedInputWidth = 80;
  static const double _spacing = 6;
  static const double _runSpacing = 6;
  static const int _maxTagCount = 10;
  static const String _placeholder = '#태그 추가';

  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _ownsController = false;
  bool _ownsFocusNode = false;
  bool _isFocused = false;
  String? _pendingSubmittedTag;

  bool get _isFull => widget.tags.length >= _maxTagCount;

  bool get _hasDraft => _controller.text.trim().isNotEmpty;

  GdsTagSelectState get _state {
    if (_isFull) return GdsTagSelectState.full;
    if (_isFocused) return GdsTagSelectState.focused;
    if (widget.tags.isEmpty && !_hasDraft) {
      return GdsTagSelectState.enabled;
    }
    return GdsTagSelectState.filled;
  }

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
  void didUpdateWidget(covariant GdsTagSelect oldWidget) {
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

    _clearPendingSubmittedTagIfAccepted(oldWidget.tags);

    if (_isFull && _focusNode.hasFocus) {
      _focusNode.unfocus();
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

  void _onTextChange() {
    setState(() {});
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _handleTextChanged(String value) {
    if (_pendingSubmittedTag != null && value.trim() != _pendingSubmittedTag) {
      _pendingSubmittedTag = null;
    }
    widget.onChanged?.call(value);
  }

  void _handleSubmitted(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return;
    _pendingSubmittedTag = trimmed;
    widget.onSubmitted?.call(trimmed);
  }

  void _clearPendingSubmittedTagIfAccepted(List<String> oldTags) {
    final pendingSubmittedTag = _pendingSubmittedTag;
    if (pendingSubmittedTag == null) return;

    final oldPendingCount = _tagCount(oldTags, pendingSubmittedTag);
    final newPendingCount = _tagCount(widget.tags, pendingSubmittedTag);
    final didAcceptPendingTag = widget.tags.length > oldTags.length || newPendingCount > oldPendingCount;

    if (!didAcceptPendingTag) return;

    if (_controller.text.trim() == pendingSubmittedTag) {
      _controller.clear();
    }

    _pendingSubmittedTag = null;

    if (!_isFull) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || widget.tags.length >= _maxTagCount) return;
        _focusNode.requestFocus();
      });
    }
  }

  int _tagCount(List<String> tags, String tag) => tags.where((item) => item == tag).length;

  void _handleRemoveTag(int index) {
    if (index < 0 || index >= widget.tags.length) return;
    widget.onTagRemove?.call(index, widget.tags[index]);
  }

  void _requestFocus() {
    if (_state == GdsTagSelectState.full) return;
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final state = _state;

    return GestureDetector(
      onTap: _requestFocus,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(GdsRadius.sm),
          border: Border.all(color: colors.border.graySubtler),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: widget.size.minHeight),
          child: Padding(
            padding: widget.size.padding,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _buildContent(colors, state),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(GdsSemanticColor colors, GdsTagSelectState state) {
    final showInputSlot = _isFocused || _hasDraft;
    final showPlaceholder = !showInputSlot && state != GdsTagSelectState.full;

    return Wrap(
      spacing: _spacing,
      runSpacing: _runSpacing,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (int i = 0; i < widget.tags.length; i++) _buildTag(i),
        if (showPlaceholder) _buildPlaceholder(colors),
        _buildInputSlot(colors, isVisible: showInputSlot),
      ],
    );
  }

  Widget _buildPlaceholder(GdsSemanticColor colors) {
    return Text(
      _placeholder,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GdsTypography.label4.copyWith(color: colors.text.graySubtle),
    );
  }

  Widget _buildInputSlot(GdsSemanticColor colors, {required bool isVisible}) {
    return SizedBox(
      width: isVisible ? _focusedInputWidth : 0,
      child: IgnorePointer(
        ignoring: !isVisible,
        child: Row(
          children: [
            Text(
              '#',
              style: GdsTypography.label4.copyWith(color: colors.text.graySubtle),
            ),
            Expanded(
              child: EditableText(
                controller: _controller,
                focusNode: _focusNode,
                style: GdsTypography.label4.copyWith(color: colors.text.grayBold),
                cursorColor: colors.status.info,
                backgroundCursorColor: GdsColors.transparent,
                onEditingComplete: () {},
                onChanged: _handleTextChanged,
                onSubmitted: _handleSubmitted,
                textInputAction: TextInputAction.done,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(int index) {
    return GdsTag.icon(
      text: widget.tags[index],
      icon: GdsIcon.xMark,
      size: widget.size.tagSize,
      state: GdsTagState.enabled,
      onTap: () => _handleRemoveTag(index),
    );
  }
}
