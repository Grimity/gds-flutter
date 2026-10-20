import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:gds_flutter/components/input/gds_input_count.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/src/image_embed_builder.dart';
import 'package:pervice/pervice.dart';

/// 게시글 본문을 GDS 스타일로 편집하는 입력 필드 위젯.
class GdsEditorField extends StatelessWidget {
  const new({
    super.key,
    required this.controller,
    required this.maxCount,
    this.placeholder,
    this.focusNode,
    this.imageBuilder,
  });

  final QuillController controller;
  final int maxCount;
  final String? placeholder;
  final FocusNode? focusNode;

  /// 이미지 URL에 해당하는 위젯을 반환하는 빌더.
  final ImageBuilder? imageBuilder;

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

    // 본문에 삽입된 링크에 적용할 색상.
    final linkColor = GdsColor.textPrimaryNormal.of(context);

    return Padding(
      padding: .only(top: 16, bottom: 12),
      child: Column(
        crossAxisAlignment: .end,
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
                embedBuilders: [
                  if (imageBuilder != null) ...[
                    ImageEmbedBuilder(imageBuilder!),
                  ],
                ],
                customStyles: .new(
                  link: .new(color: linkColor, decoration: .underline),
                  h1: blockStyle(.postTitle1),
                  h2: blockStyle(.postTitle2),
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
          ListenableBuilder(
            listenable: controller,
            builder: (context, child) {
              return GdsInputCount(
                count: controller.characterCount,
                maxCount: maxCount,
              );
            },
          ),
        ],
      ),
    );
  }
}
