import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_foundation/gds_foundation.dart';
import 'package:gds_tokens/gds_tokens.dart';

class GdsDmInput extends StatefulWidget {
  const GdsDmInput({
    super.key,
    this.enabled = true,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onEditingComplete,
    this.onCameraPressed,
    this.onButtonPressed,
    this.textInputAction,
  }) : replyUser = null,
       previewText = null;

  const GdsDmInput.answer({
    super.key,
    this.enabled = true,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onEditingComplete,
    this.onCameraPressed,
    this.onButtonPressed,
    this.textInputAction,
    required this.replyUser,
    required this.previewText,
  });

  final bool enabled;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onCameraPressed;
  final VoidCallback? onButtonPressed;
  final TextInputAction? textInputAction;

  /// answer state
  final String? replyUser;
  final String? previewText;

  @override
  State<GdsDmInput> createState() => _GdsDmInputState();
}

class _GdsDmInputState extends State<GdsDmInput> {
  static const _enabledPlaceholder = '메시지 입력';
  static const _disabledPlaceholder = '더 이상 채팅이 불가능해요';
  static const _buttonLabel = '전송';

  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _ownsController = false;
  bool _ownsFocusNode = false;

  bool get _hasText => _controller.text.trim().isNotEmpty;

  bool get _isButtonEnabled => widget.enabled && _hasText;

  String get _placeholder => widget.enabled ? _enabledPlaceholder : _disabledPlaceholder;

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

    _controller.addListener(_handleControllerChanged);
  }

  void _initFocusNode() {
    if (widget.focusNode == null) {
      _focusNode = FocusNode();
      _ownsFocusNode = true;
    } else {
      _focusNode = widget.focusNode!;
      _ownsFocusNode = false;
    }

    _focusNode.addListener(_handleFocusChanged);
  }

  @override
  void didUpdateWidget(covariant GdsDmInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      _controller.removeListener(_handleControllerChanged);
      if (_ownsController) {
        _controller.dispose();
      }
      _initController();
    }

    if (oldWidget.focusNode != widget.focusNode) {
      _focusNode.removeListener(_handleFocusChanged);
      if (_ownsFocusNode) {
        _focusNode.dispose();
      }
      _initFocusNode();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleControllerChanged);
    _focusNode.removeListener(_handleFocusChanged);

    if (_ownsController) {
      _controller.dispose();
    }
    if (_ownsFocusNode) {
      _focusNode.dispose();
    }

    super.dispose();
  }

  void _handleControllerChanged() {
    if (!mounted) return;
    setState(() {});
  }

  void _handleFocusChanged() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return ColoredBox(
      color: colors.surface.graySubtlest,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const GdsDivider.secondary(),
          if (widget.replyUser != null && widget.previewText != null)
            _buildAnswer(colors, widget.replyUser!, widget.previewText!),
          _buildInputRow(colors),
        ],
      ),
    );
  }

  Widget _buildInputRow(GdsSemanticColor colors) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 60,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: GdsSpacing.spacing16,
          vertical: GdsSpacing.spacing8,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildCameraButton(colors),
            const SizedBox(width: GdsSpacing.spacing8),
            Expanded(
              child: GdsTextField(
                placeholder: _placeholder,
                size: GdsTextFieldSize.small,
                isMultipleLine: true,
                enabled: widget.enabled,
                controller: _controller,
                focusNode: _focusNode,
                onChanged: widget.onChanged,
                onEditingComplete: widget.onEditingComplete,
                textInputAction: widget.textInputAction,
              ),
            ),
            const SizedBox(width: GdsSpacing.spacing8),
            SizedBox(
              width: 60,
              child: GdsSolidButton(
                text: _buttonLabel,
                onPressed: widget.onButtonPressed,
                size: GdsSolidButtonSize.regular,
                enabled: _isButtonEnabled,
                expanded: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraButton(GdsSemanticColor colors) {
    final iconColor = widget.enabled ? colors.icon.grayBold : colors.icon.graySubtler;

    return SizedBox(
      width: GdsIconSize.v24,
      height: GdsIconSize.v24,
      child: GdsGesture(
        onTap: widget.enabled ? widget.onCameraPressed : null,
        child: Center(
          child: GdsIcon.cameraOutline.build(
            color: iconColor,
            width: GdsIconSize.v24,
            height: GdsIconSize.v24,
          ),
        ),
      ),
    );
  }

  Widget _buildAnswer(GdsSemanticColor colors, String replyUser, String previewText) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: GdsSpacing.spacing16, vertical: GdsSpacing.spacing8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GdsIcon.forward2.build(
                width: 18,
                height: 18,
                color: colors.icon.graySubtle,
              ),
              const SizedBox(width: GdsSpacing.spacing2),
              Text(
                '[$replyUser]님에게 답장',
                style: GdsTypography.label6.copyWith(color: colors.text.graySubtle),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const SizedBox(height: GdsSpacing.spacing4),
          Text(
            previewText,
            style: GdsTypography.label4.copyWith(color: colors.text.grayBold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
