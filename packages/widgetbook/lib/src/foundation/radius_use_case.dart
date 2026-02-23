import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(
  name: 'default',
  type: GdsRadius,
  path: '[foundation]/',
)
Widget buildGdsRadiusUseCase(BuildContext context) {
  final borderColor = context.gdsColors.border.primaryNormal;
  final fillColor = context.gdsColors.surface.primarySubtlest;

  return WidgetbookPageLayout(
    title: 'Radius',
    description: '모서리 둥글기에 사용되는 반경 토큰입니다.',
    children: [
      WidgetbookSection(
        title: 'Scale',
        children: [
          Wrap(
            spacing: GdsSpacing.spacing24,
            runSpacing: GdsSpacing.spacing24,
            children: [
              for (final (name, value) in _radii)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: fillColor,
                        borderRadius: BorderRadius.circular(value.clamp(0, 40)),
                        border: Border.all(color: borderColor, width: 2),
                      ),
                    ),
                    const SizedBox(height: GdsSpacing.spacing8),
                    Text(name, style: GdsTypography.label3),
                    Text(value == GdsRadius.full ? "full" : "${value.toInt()}px", style: GdsTypography.caption1),
                  ],
                ),
            ],
          ),
        ],
      ),
    ],
  );
}

const _radii = <(String, double)>[
  ('xs', GdsRadius.xs),
  ('sm', GdsRadius.sm),
  ('md', GdsRadius.md),
  ('lg', GdsRadius.lg),
  ('xl', GdsRadius.xl),
  ('xxl', GdsRadius.xxl),
  ('full', GdsRadius.full),
];
