import 'package:flutter/widgets.dart';
import 'package:gds_flutter/components/input/gds_input_frame.dart';
import 'package:gds_flutter/components/input/gds_input_style.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 새 태그를 입력하는 입력란이며 주로 [GdsTagSelect]에서 사용되는 위젯.
@GdsSupportedSizes([.md, .xs])
class GdsTagInput extends StatelessWidget {
  const new({
    super.key,
    required this.size,
    required this.onSubmit,
    required this.controller,
  });

  final GdsSize size;
  final VoidCallback onSubmit;
  final TextEditingController controller;

  /// 태그 입력 필드에 적용할 기본 텍스트 스타일.
  static const style = GdsInputStyle(textColor: .textGrayBold);

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: GdsInputFrame(
        enabledStyle: style.copyWith(textColor: .textGraySubtle),
        filledStyle: style,
        focusedStyle: style,
        errorStyle: style,
        successStyle: style,
        disabledStyle: style,
        decoration: .new(
          typography: .label4,
          spacing: 0,

          // 동적 높이 md 31.6px, xs 27.6px 기준
          padding: .symmetric(vertical: size.when(md: 6, xs: 4)),
        ),
        status: .enabled,
        prefixText: '#',
        placeholder: '태그 추가',
        text: null,
        initialText: null,
        obscureText: false,
        onSubmitted: null,
        onComplete: onSubmit,
        onChanged: null,
        controller: controller,
        focusNode: null,
        keyboardType: null,
        maxLength: null,
        minLines: 1,
        maxLines: 1,
        axis: .horizontal,
      ),
    );
  }
}
