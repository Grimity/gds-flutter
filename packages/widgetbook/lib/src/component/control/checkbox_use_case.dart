import 'package:gds_tokens/gds_tokens.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(name: 'default', type: GdsCheckbox, path: '[component]/[control]')
Widget buildGdsCheckboxUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Checkbox',
    description: '보통 위계로 활성화 여부를 제어할 때 사용합니다. medium/small 2가지 크기와 탭 시 scale pop 마이크로 인터랙션을 지원합니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final size = context.knobs.list<GdsCheckboxSize>(
    label: 'size',
    options: GdsCheckboxSize.values,
    labelBuilder: (s) => s.name,
  );
  final isChecked = context.knobs.boolean(label: 'isChecked', initialValue: false);
  final enabled = context.knobs.boolean(label: 'enabled', initialValue: true);

  return WidgetbookPlayground(
    info: [
      'size: ${size.name}',
      'isChecked: $isChecked',
      'enabled: $enabled',
      'iconSize: ${size.iconSize.toInt()}px @fixed',
    ],
    child: GdsCheckbox(
      isChecked: isChecked,
      enabled: enabled,
      onTap: () => debugPrint('GdsCheckbox tapped'),
    ),
  );
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'Checkbox',
    children: [
      WidgetbookSubsection(
        title: 'size × isChecked × enabled',
        labels: ['2 sizes', '2 states', '2 enabled'],
        content: _CheckboxMatrix(colors: context.gdsColors),
      ),
    ],
  );
}

class _CheckboxMatrix extends StatelessWidget {
  final GdsSemanticColor colors;

  const _CheckboxMatrix({required this.colors});

  @override
  Widget build(BuildContext context) {
    final headerStyle = GdsTypography.caption1.copyWith(color: colors.text.graySubtle);

    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: IntrinsicColumnWidth(),
        2: IntrinsicColumnWidth(),
        3: IntrinsicColumnWidth(),
      },
      children: [
        TableRow(
          children: [
            const SizedBox.shrink(),
            const SizedBox.shrink(),
            for (final isChecked in [false, true])
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(isChecked ? 'true' : 'false', style: headerStyle),
                  ),
                ),
              ),
          ],
        ),
        for (final size in GdsCheckboxSize.values)
          for (final enabled in [true, false])
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(size.name, style: headerStyle),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Text(enabled ? 'enabled' : 'disabled', style: headerStyle),
                ),
                for (final isChecked in [false, true])
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: _buildPreview(size, isChecked, enabled),
                    ),
                  ),
              ],
            ),
      ],
    );
  }

  Widget _buildPreview(GdsCheckboxSize size, bool isChecked, bool enabled) {
    Color iconColor;
    if (isChecked) {
      iconColor = colors.icon.primaryNormal;
    } else if (!enabled) {
      iconColor = colors.icon.graySubtlest;
    } else {
      iconColor = colors.icon.graySubtler;
    }

    final icon = isChecked ? GdsIcon.checkSquareFill : GdsIcon.checkSquareOutline;
    return icon.build(
      color: iconColor,
      width: size.iconSize,
      height: size.iconSize,
    );
  }
}
