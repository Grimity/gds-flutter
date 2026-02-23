import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

const _sampleImageUrl = 'https://picsum.photos/seed/grimity/800/600';

@widgetbook.UseCase(
  name: 'default',
  type: GdsThumbnail,
  path: '[component]/[thumbnail]',
)
Widget buildGdsThumbnailUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Thumbnail',
    description: '네트워크 이미지를 다양한 aspect ratio로 표시하는 썸네일 컴포넌트입니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final ratio = context.knobs.list<GdsThumbnailRatio>(
    label: 'ratio',
    options: GdsThumbnailRatio.values,
    labelBuilder: (r) => r.label,
  );

  final imageUrl = context.knobs.string(
    label: 'imageUrl',
    initialValue: _sampleImageUrl,
  );

  return WidgetbookPlayground(
    info: [
      'ratio: ${ratio.label}',
      'aspectRatio: ${ratio.value.toStringAsFixed(4)}',
      'fit: cover @fixed',
    ],
    child: SizedBox(
      width: 300,
      child: GdsThumbnail(
        imageUrl: imageUrl,
        ratio: ratio,
      ),
    ),
  );
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'Thumbnail',
    children: [
      WidgetbookSubsection(
        title: 'ratio variants',
        labels: ['${GdsThumbnailRatio.values.length} ratios'],
        content: const _ThumbnailRatioList(),
      ),
    ],
  );
}

class _ThumbnailRatioList extends StatelessWidget {
  const _ThumbnailRatioList();

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final labelStyle = GdsTypography.caption1.copyWith(color: colors.text.graySubtle);

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        for (final ratio in GdsThumbnailRatio.values)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(ratio.label, style: labelStyle),
              const SizedBox(height: 4),
              SizedBox(
                width: 240,
                child: GdsThumbnail(
                  imageUrl: '',
                  ratio: ratio,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
