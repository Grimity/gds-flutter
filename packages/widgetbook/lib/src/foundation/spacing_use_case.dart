import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(name: 'default', type: GdsSpacing)
Widget buildGdsSpacingUseCase(BuildContext context) {
  final primaryColor = context.gdsColors.surface.primaryNormal;

  return WidgetbookPageLayout(
    title: 'Spacing',
    description: '레이아웃 간격에 사용되는 스페이싱 토큰입니다.',
    children: [
      WidgetbookSection(
        title: 'Scale',
        children: [
          for (final (name, value) in _spacings)
            Padding(
              padding: const EdgeInsets.only(bottom: GdsSpacing.spacing8),
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(name, style: GdsTypography.label3),
                  ),
                  SizedBox(
                    width: 50,
                    child: Text('${value.toInt()}px', style: GdsTypography.caption1),
                  ),
                  Container(
                    width: value,
                    height: 24,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(GdsRadius.xs),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    ],
  );
}

const _spacings = <(String, double)>[
  ('spacing2', GdsSpacing.spacing2),
  ('spacing4', GdsSpacing.spacing4),
  ('spacing6', GdsSpacing.spacing6),
  ('spacing8', GdsSpacing.spacing8),
  ('spacing10', GdsSpacing.spacing10),
  ('spacing12', GdsSpacing.spacing12),
  ('spacing16', GdsSpacing.spacing16),
  ('spacing20', GdsSpacing.spacing20),
  ('spacing24', GdsSpacing.spacing24),
  ('spacing28', GdsSpacing.spacing28),
  ('spacing32', GdsSpacing.spacing32),
  ('spacing36', GdsSpacing.spacing36),
  ('spacing40', GdsSpacing.spacing40),
  ('spacing48', GdsSpacing.spacing48),
  ('spacing56', GdsSpacing.spacing56),
  ('spacing64', GdsSpacing.spacing64),
  ('spacing72', GdsSpacing.spacing72),
];
