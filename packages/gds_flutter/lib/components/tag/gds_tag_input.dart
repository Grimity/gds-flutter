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
          padding: .symmetric(vertical: size.when(md: 6.2, xs: 2.2)), // 고정 높이 md 32px, xs 24px 기준
          size: size.when(md: .sm, xs: .xs),
        ),
        status: .enabled,
        prefixText: '#',
        placeholder: '태그 추가',
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
