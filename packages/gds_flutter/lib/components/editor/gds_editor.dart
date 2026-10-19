import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 본문 입력 필드와 편집 도구를 함께 관리하는 에디터 위젯.
class GdsEditor extends StatelessWidget {
  const new({
    super.key,
    required this.controller,
    required this.onAddImage,
    required this.onAddLink,
    required this.maxCount,
    this.padding = .zero,
    this.header,
  });

  final QuillController controller;
  final Future<String?> Function() onAddImage;
  final Future<String?> Function() onAddLink;
  final int maxCount;
  final EdgeInsets padding;

  /// 본문 입력 필드 위에 표시할 위젯.
  final Widget? header;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: padding,
            child: Column(
              children: [
                ?header,

                // 입력 필드 표시
                Expanded(
                  child: GdsEditorField(
                    controller: controller,
                    maxCount: maxCount,
                    placeholder: '내용을 입력하세요',
                    imageBuilder: (context, url) {
                      return GdsImage(provider: url.networkImage);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

        // 편집 도구 표시
        GdsEditorControls.fromController(
          controller,
          onAddImage: onAddImage,
          onAddLink: onAddLink,
        ),
      ],
    );
  }
}
