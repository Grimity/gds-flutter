import 'package:flutter/widgets.dart';
import 'package:gds_flutter/components/tag/gds_tag_input.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 선택된 태그 목록과 새 태그 입력란을 표시하는 위젯.
@GdsSupportedSizes([.md, .xs])
class GdsTagSelect extends StatefulWidget {
  const GdsTagSelect({
    super.key,
    required this.size,
    required this.tags,
    required this.onAdded,
    required this.onRemoved,
  });

  final GdsSize size;
  final List<String> tags;
  final ValueChanged<String> onAdded;
  final ValueChanged<String> onRemoved;

  @override
  State<GdsTagSelect> createState() => _GdsTagSelectState();
}

class _GdsTagSelectState extends State<GdsTagSelect> {
  final TextEditingController controller = .new();

  /// 사용자가 태그 입력을 최종적으로 확정 짓는 경우 호출됩니다.
  void onSubmit() {
    if (controller.text.isEmpty) return;

    widget.onAdded(controller.text);
    controller.clear();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GdsContainer(
      width: .infinity,
      radius: .sm,
      border: .all(color: .borderGraySubtle),
      padding: widget.size.when(
        md: .all(8),
        xs: .symmetric(vertical: 6, horizontal: 8),
      ),
      child: Wrap(
        crossAxisAlignment: .center,
        runSpacing: 6,
        spacing: 6,
        children: [
          // 기존 태그 목록 표시
          ...widget.tags.builder((tag) {
            return GdsTag(
              size: widget.size,
              icon: .x,
              label: tag,
              onTap: () => widget.onRemoved(tag),
            );
          }),

          // 새 태그 입력란 표시
          GdsTagInput(
            size: widget.size,
            onSubmit: onSubmit,
            controller: controller,
          ),
        ],
      ),
    );
  }
}
