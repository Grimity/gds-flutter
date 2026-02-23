import 'package:gds_tokens/gds_tokens.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(name: 'default', type: GdsBookmark, path: '[component]/[control]')
Widget buildGdsBookmarkUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Bookmark',
    description: '북마크 토글 컴포넌트입니다. default/black 2가지 타입과 탭 시 scale pop 마이크로 인터랙션을 지원합니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final type = context.knobs.list<GdsBookmarkType>(
    label: 'type',
    options: GdsBookmarkType.values,
    labelBuilder: (t) => t.name,
  );

  final isBookmarked = context.knobs.boolean(label: 'isBookmarked', initialValue: false);

  return WidgetbookPlayground(
    info: [
      'type: ${type.name}',
      'isBookmarked: $isBookmarked',
      'size: 24×24px @fixed',
    ],
    child: GdsBookmark(
      isBookmarked: isBookmarked,
      onTap: () => debugPrint('GdsBookmark tapped'),
    ),
  );
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'Bookmark',
    children: [
      WidgetbookSubsection(
        title: 'type × isBookmarked',
        labels: ['2 types', '2 states'],
        content: const _BookmarkMatrix(),
      ),
    ],
  );
}

class _BookmarkMatrix extends StatelessWidget {
  const _BookmarkMatrix();

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final headerStyle = GdsTypography.caption1.copyWith(color: colors.text.graySubtle);

    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: IntrinsicColumnWidth(),
        2: IntrinsicColumnWidth(),
      },
      children: [
        TableRow(
          children: [
            const SizedBox.shrink(),
            for (final isBookmarked in [false, true])
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(isBookmarked ? 'true' : 'false', style: headerStyle),
                  ),
                ),
              ),
          ],
        ),
        for (final type in GdsBookmarkType.values)
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(type.name, style: headerStyle),
              ),
              for (final isBookmarked in [false, true])
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: _buildPreview(type, isBookmarked, colors),
                  ),
                ),
            ],
          ),
      ],
    );
  }

  Widget _buildPreview(GdsBookmarkType type, bool isBookmarked, GdsSemanticColor colors) {
    final icon = isBookmarked ? GdsIcon.bookmarkFill : GdsIcon.bookmarkOutline;
    return icon.build(
      color: type.iconColor(colors, isBookmarked),
      width: GdsIconSize.v24,
      height: GdsIconSize.v24,
    );
  }
}
