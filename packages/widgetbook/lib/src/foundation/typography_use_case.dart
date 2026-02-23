import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(
  name: 'default',
  type: GdsTypography,
  path: '[foundation]/',
)
Widget buildGdsTypographyUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Typography',
    description: 'Grimity 디자인 시스템의 텍스트 스타일 토큰입니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildStylesSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final style = context.knobs.object.dropdown<_TypoEntry>(
    label: 'style',
    options: _allStyles,
    labelBuilder: (e) => e.name,
  );
  final textColor = context.gdsColors.text.grayBold;

  return WidgetbookPlayground(
    info: [
      'fontSize: ${style.style.fontSize?.toInt()}px',
      'fontWeight: ${style.style.fontWeight}',
      'height: ${style.style.height}',
    ],
    child: Text('가나다라 ABCdef 0123', style: style.style.copyWith(color: textColor)),
  );
}

Widget _buildStylesSection(BuildContext context) {
  final textColor = context.gdsColors.text.grayBold;
  final subtleColor = context.gdsColors.text.graySubtle;

  return WidgetbookSection(
    title: 'Styles',
    spacing: 0,
    children: [
      for (final entry in _allStyles) ...[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              SizedBox(
                width: 120,
                child: Text(entry.name, style: GdsTypography.label5.copyWith(color: subtleColor)),
              ),
              Expanded(
                child: Text('가나다라 ABCdef 0123', style: entry.style.copyWith(color: textColor)),
              ),
              Text(
                '${entry.style.fontSize?.toInt()}px / ${_weightName(entry.style.fontWeight)}',
                style: GdsTypography.caption1.copyWith(color: subtleColor),
              ),
            ],
          ),
        ),
        const GdsDivider(type: GdsDividerType.secondary),
      ],
    ],
  );
}

String _weightName(FontWeight? w) => switch (w) {
  FontWeight.w400 => 'Regular',
  FontWeight.w500 => 'Medium',
  FontWeight.w600 => 'SemiBold',
  FontWeight.w700 => 'Bold',
  _ => '$w',
};

class _TypoEntry {
  const _TypoEntry(this.name, this.style);

  final String name;
  final TextStyle style;
}

final _allStyles = <_TypoEntry>[
  _TypoEntry('title1', GdsTypography.title1),
  _TypoEntry('title2', GdsTypography.title2),
  _TypoEntry('title3', GdsTypography.title3),
  _TypoEntry('subtitle1', GdsTypography.subtitle1),
  _TypoEntry('subtitle2', GdsTypography.subtitle2),
  _TypoEntry('subtitle3', GdsTypography.subtitle3),
  _TypoEntry('body1R', GdsTypography.body1R),
  _TypoEntry('body1SB', GdsTypography.body1SB),
  _TypoEntry('body2R', GdsTypography.body2R),
  _TypoEntry('body2SB', GdsTypography.body2SB),
  _TypoEntry('caption1', GdsTypography.caption1),
  _TypoEntry('label1', GdsTypography.label1),
  _TypoEntry('label2', GdsTypography.label2),
  _TypoEntry('label3', GdsTypography.label3),
  _TypoEntry('label4', GdsTypography.label4),
  _TypoEntry('label5', GdsTypography.label5),
  _TypoEntry('label6', GdsTypography.label6),
];
