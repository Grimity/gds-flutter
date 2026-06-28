import 'package:flutter/material.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_foundation/gds_foundation.dart';
import 'package:gds_tokens/gds_tokens.dart';

enum _GdsInputType {
  defaultField,
  button,
  community,
  communityAnswer,
  custom,
}

class GdsInput extends StatelessWidget {
  final _GdsInputType _type;

  // 텍스트 필드 공통
  final String? placeholder;
  final bool enabled;
  final bool error;
  final bool success;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final TextInputAction? textInputAction;

  // Default / Button 전용
  final String? titleText;
  final bool isRequired;
  final String? helperText;

  // Button 전용
  final String? buttonLabel;
  final bool? buttonEnabled;
  final VoidCallback? onButtonPressed;

  // Default 전용
  final String? mentionUser;
  final VoidCallback? onMentionClear;

  // CommunityAnswer 전용
  final String? replyUser;

  // Custom 전용
  final Widget? child;

  /// 기본 타입: Title(선택) + TextField + HelperText(선택)
  const GdsInput({
    super.key,
    this.placeholder,
    this.titleText,
    this.isRequired = true,
    this.helperText,
    this.enabled = true,
    this.error = false,
    this.success = false,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onEditingComplete,
    this.textInputAction,
    this.mentionUser,
    this.onMentionClear,
  }) : _type = _GdsInputType.defaultField,
       buttonLabel = null,
       buttonEnabled = null,
       onButtonPressed = null,
       replyUser = null,
       child = null;

  /// 버튼 타입: Title(선택) + Row[TextField + SolidButton] + HelperText(선택)
  const GdsInput.button({
    super.key,
    required String this.buttonLabel,
    this.buttonEnabled = true,
    this.onButtonPressed,
    this.placeholder,
    this.titleText,
    this.isRequired = true,
    this.helperText,
    this.enabled = true,
    this.error = false,
    this.success = false,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onEditingComplete,
    this.textInputAction,
  }) : _type = _GdsInputType.button,
       mentionUser = null,
       onMentionClear = null,
       replyUser = null,
       child = null;

  /// 커뮤니티 타입: 상단 구분선 + Row[TextField(small) + SolidButton]
  const GdsInput.community({
    super.key,
    this.placeholder,
    String this.buttonLabel = '등록',
    this.buttonEnabled = true,
    this.onButtonPressed,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onEditingComplete,
    this.textInputAction,
  }) : _type = _GdsInputType.community,
       titleText = null,
       isRequired = true,
       helperText = null,
       enabled = true,
       error = false,
       success = false,
       mentionUser = null,
       onMentionClear = null,
       replyUser = null,
       child = null;

  /// 댓글 답장 타입: 상단 구분선 + 답장 헤더 + Row[TextField(small, mention) + SolidButton]
  const GdsInput.communityAnswer({
    super.key,
    required String this.replyUser,
    this.placeholder,
    String this.buttonLabel = '등록',
    this.buttonEnabled = true,
    this.onButtonPressed,
    this.mentionUser,
    this.onMentionClear,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onEditingComplete,
    this.textInputAction,
  }) : _type = _GdsInputType.communityAnswer,
       titleText = null,
       isRequired = true,
       helperText = null,
       enabled = true,
       error = false,
       success = false,
       child = null;

  const GdsInput.custom({
    super.key,
    this.titleText,
    this.helperText,
    this.isRequired = false,
    this.error = false,
    this.success = false,
    required this.child,
  }) : _type = _GdsInputType.custom,
       buttonLabel = null,
       buttonEnabled = null,
       onButtonPressed = null,
       replyUser = null,
       placeholder = null,
       enabled = true,
       controller = null,
       focusNode = null,
       onChanged = null,
       onEditingComplete = null,
       textInputAction = null,
       mentionUser = null,
       onMentionClear = null;

  GdsHelperTextState get _helperState {
    if (error) return GdsHelperTextState.error;
    if (success) return GdsHelperTextState.success;
    return GdsHelperTextState.normal;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    return switch (_type) {
      _GdsInputType.defaultField => _buildDefault(child),
      _GdsInputType.custom => _buildDefault(child),
      _GdsInputType.button => _buildButton(),
      _GdsInputType.community => _buildCommunity(colors),
      _GdsInputType.communityAnswer => _buildCommunityAnswer(colors),
    };
  }

  Widget _buildDefault(Widget? child) {
    final field =
        child ??
        GdsTextField(
          placeholder: placeholder,
          size: GdsTextFieldSize.medium,
          enabled: enabled,
          error: error,
          success: success,
          controller: controller,
          focusNode: focusNode,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          textInputAction: textInputAction,
          mentionUser: mentionUser,
          onMentionClear: onMentionClear,
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (titleText != null) ...[
          GdsTitle(text: titleText!, isRequired: isRequired),
          const SizedBox(height: GdsSpacing.spacing8),
        ],
        field,
        if (helperText != null) ...[
          const SizedBox(height: GdsSpacing.spacing8),
          GdsHelperText(state: _helperState, text: helperText),
        ],
      ],
    );
  }

  Widget _buildButton() {
    final field = GdsTextField(
      placeholder: placeholder,
      size: GdsTextFieldSize.medium,
      enabled: enabled,
      error: error,
      success: success,
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      textInputAction: textInputAction,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (titleText != null) ...[
          GdsTitle(text: titleText!, isRequired: isRequired),
          const SizedBox(height: GdsSpacing.spacing8),
        ],
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: field),
            const SizedBox(width: GdsSpacing.spacing8),
            GdsSolidButton(
              text: buttonLabel!,
              onPressed: onButtonPressed,
              size: GdsSolidButtonSize.large,
              enabled: buttonEnabled ?? enabled,
            ),
          ],
        ),
        if (helperText != null) ...[
          const SizedBox(height: GdsSpacing.spacing8),
          GdsHelperText(state: _helperState, text: helperText),
        ],
      ],
    );
  }

  Widget _buildCommunity(GdsSemanticColor colors) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(height: 1, color: colors.border.graySubtler),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: GdsSpacing.spacing8,
            vertical: GdsSpacing.spacing4,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: GdsTextField(
                  placeholder: placeholder,
                  size: GdsTextFieldSize.small,
                  controller: controller,
                  focusNode: focusNode,
                  onChanged: onChanged,
                  onEditingComplete: onEditingComplete,
                  textInputAction: textInputAction,
                ),
              ),
              const SizedBox(width: GdsSpacing.spacing8),
              GdsSolidButton(
                text: buttonLabel!,
                onPressed: onButtonPressed,
                size: GdsSolidButtonSize.regular,
                enabled: buttonEnabled ?? enabled,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCommunityAnswer(GdsSemanticColor colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(height: 1, color: colors.border.graySubtler),
        Padding(
          padding: const EdgeInsets.only(
            left: GdsSpacing.spacing16,
            right: GdsSpacing.spacing16,
            top: GdsSpacing.spacing8,
            bottom: GdsSpacing.spacing4,
          ),
          child: Row(
            children: [
              GdsIcon.reply.build(
                color: colors.text.graySubtle,
                width: 18,
                height: 18,
              ),
              const SizedBox(width: GdsSpacing.spacing2),
              Text(
                '$replyUser님에게 답장',
                style: GdsTypography.caption1.copyWith(
                  color: colors.text.graySubtle,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: GdsSpacing.spacing8,
            vertical: GdsSpacing.spacing4,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: GdsTextField(
                  placeholder: placeholder,
                  size: GdsTextFieldSize.small,
                  controller: controller,
                  focusNode: focusNode,
                  onChanged: onChanged,
                  onEditingComplete: onEditingComplete,
                  textInputAction: textInputAction,
                  mentionUser: mentionUser,
                  onMentionClear: onMentionClear,
                ),
              ),
              const SizedBox(width: GdsSpacing.spacing8),
              GdsSolidButton(
                text: buttonLabel!,
                onPressed: onButtonPressed,
                size: GdsSolidButtonSize.regular,
                enabled: buttonEnabled ?? enabled,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
