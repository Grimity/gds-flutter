import 'package:gds_tokens/gds_tokens.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(name: 'default', type: GdsHeart, path: '[component]/[control]')
Widget buildGdsHeartUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Heart',
    description: '좋아요 토글 컴포넌트입니다. default/black 2가지 타입과 탭 시 scale pop 마이크로 인터랙션을 지원합니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final type = context.knobs.list<GdsHeartType>(
    label: 'type',
    options: GdsHeartType.values,
    labelBuilder: (t) => t.name,
  );

  final isLiked = context.knobs.boolean(label: 'isLiked', initialValue: false);

  return WidgetbookPlayground(
    info: [
      'type: ${type.name}',
      'isLiked: $isLiked',
      'size: 24×24px @fixed',
    ],
    child: type == GdsHeartType.defaultType
        ? GdsHeart(
            isLiked: isLiked,
            onTap: () => debugPrint('GdsHeart tapped'),
          )
        : GdsHeart.black(
            isLiked: isLiked,
            onTap: () => debugPrint('GdsHeart tapped'),
          ),
  );
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'Heart',
    children: [
      WidgetbookSubsection(
        title: 'type × isLiked',
        labels: ['2 types', '2 states'],
        content: const _HeartMatrix(),
      ),
    ],
  );
}

class _HeartMatrix extends StatelessWidget {
  const _HeartMatrix();

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
            for (final isLiked in [false, true])
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(isLiked ? 'true' : 'false', style: headerStyle),
                  ),
                ),
              ),
          ],
        ),
        for (final type in GdsHeartType.values)
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(type.name, style: headerStyle),
              ),
              for (final isLiked in [false, true])
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: _buildPreview(type, isLiked, colors),
                  ),
                ),
            ],
          ),
      ],
    );
  }

  Widget _buildPreview(GdsHeartType type, bool isLiked, GdsSemanticColor colors) {
    final icon = isLiked ? GdsIcon.heartFill : GdsIcon.heartOutline;
    return icon.build(
      color: type.iconColor(colors, isLiked),
      width: GdsIconSize.v24,
      height: GdsIconSize.v24,
    );
  }
}
