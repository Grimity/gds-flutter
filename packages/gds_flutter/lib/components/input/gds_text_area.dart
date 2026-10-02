import 'package:flutter/widgets.dart';
import 'package:gds_flutter/components/input/gds_input_count.dart';
import 'package:gds_flutter/components/input/gds_input_frame.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 디자인 시스템에서 사용하는 복수 라인 기반의 입력 필드 위젯.
class GdsTextArea extends StatelessWidget {
  const GdsTextArea({
    super.key,
    required this.variant,
    this.status = .enabled,
    this.placeholder,
    this.initialText,
    this.shadow,
    this.onSubmitted,
    this.onComplete,
    this.onChanged,
    this.controller,
    this.focusNode,
    this.keyboardType,
    required this.maxLength,
  });

  final GdsTextAreaVariant variant;
  final GdsInputStatus status;
  final String? placeholder;
  final String? initialText;
  final GdsShadow? shadow;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onComplete;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return GdsInputFrame(
      enabledStyle: variant.enabled.copyWith(trailingBuilder: trailingBuilder),
      filledStyle: variant.filled.copyWith(trailingBuilder: trailingBuilder),
      focusedStyle: variant.focused.copyWith(trailingBuilder: trailingBuilder),
      errorStyle: variant.error.copyWith(trailingBuilder: trailingBuilder),
      successStyle: variant.success.copyWith(trailingBuilder: trailingBuilder),
      disabledStyle: variant.disabled.copyWith(trailingBuilder: trailingBuilder),
      decoration: variant.decoration.copyWith(alignment: .end),
      status: status,
      shadow: shadow,
      placeholder: placeholder,
      initialText: initialText,
      prefixText: null,
      obscureText: null,
      onSubmitted: onSubmitted,
      onComplete: onComplete,
      onChanged: onChanged,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      maxLength: maxLength,
      minLines: null,
      maxLines: null,
      axis: .vertical,
      height: variant.height,
    );
  }

  /// 입력한 글자 수와 최대 글자 수를 표시하는 위젯을 반환합니다.
  Widget trailingBuilder(BuildContext context, TextEditingController controller) {
    return GdsInputCount(count: controller.text.length, maxCount: maxLength);
  }
}
