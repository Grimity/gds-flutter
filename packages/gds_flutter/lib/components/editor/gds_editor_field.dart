import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:gds_flutter/components/input/gds_input_count.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:pervice/pervice.dart';

/// 게시글 본문을 GDS 스타일로 편집하는 입력 필드 위젯.
class GdsEditorField extends StatelessWidget {
  const new({
    super.key,
    required this.controller,
    required this.maxCount,
    this.placeholder,
    this.focusNode,
  });

  final QuillController controller;
  final int maxCount;
  final String? placeholder;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final defaultFocusNode = context.useFocusNode();
    final scrollController = context.useScrollController();

    /// 타이포그래피와 색상에 맞는 본문 블록 스타일을 생성합니다.
    DefaultTextBlockStyle blockStyle(
      GdsTypography typography, {
      GdsColor color = .textGrayBold,
    }) {
      return .new(
        typography.style.copyWith(color: color.of(context)),
        const HorizontalSpacing(0, 0),
        const VerticalSpacing(0, 0),
        const VerticalSpacing(0, 0),
        null,
      );
    }

    // 선택 커서, 선택 영역과 손잡이에 적용할 색상.
    final cursorColor = GdsColor.statusInfo.of(context);
    final selectionColor = GdsColor.statusInfo.of(context).opacity40;
    final selectionHandleColor = GdsColor.statusInfo.of(context);

    return Column(
      children: [
        // 입력 필드 표시
        Expanded(
          child: QuillEditor(
            controller: controller,
            focusNode: focusNode ?? defaultFocusNode,
            scrollController: scrollController,
            config: .new(
              scrollable: false,
              placeholder: placeholder,
              customStyles: .new(
                h1: blockStyle(.postTitle1),
                h2: blockStyle(.postTitle2),
                h3: blockStyle(.postBody),
                paragraph: blockStyle(.label2),
                placeHolder: blockStyle(.label2, color: .textGraySubtle),
              ),
              textSelectionThemeData: .new(
                cursorColor: cursorColor,
                selectionColor: selectionColor,
                selectionHandleColor: selectionHandleColor,
              ),
            ),
          ),
        ),

        // 카운터 표시
        GdsContainer(
          padding: .only(bottom: 12),
          alignment: .centerRight,
          child: ListenableBuilder(
            listenable: controller,
            builder: (context, child) {
              // Quill 문서 끝에 자동으로 추가되는 줄바꿈은 글자 수에서 제외.
              final count = controller.document.toPlainText().length - 1;

              return GdsInputCount(
                count: count,
                maxCount: maxCount,
              );
            },
          ),
        ),
      ],
    );
  }
}
