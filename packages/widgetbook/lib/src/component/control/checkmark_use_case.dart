import 'package:gds_tokens/gds_tokens.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(name: 'default', type: GdsCheckmark, path: '[component]/[control]')
Widget buildGdsCheckmarkUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Checkmark',
    description: '활성화 여부를 제어할 때 사용하는 체크마크 토글 컴포넌트입니다. 탭 시 scale pop 마이크로 인터랙션을 지원합니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final isChecked = context.knobs.boolean(label: 'isChecked', initialValue: false);
  final enabled = context.knobs.boolean(label: 'enabled', initialValue: true);

  return WidgetbookPlayground(
    info: [
      'isChecked: $isChecked',
      'enabled: $enabled',
      'size: 24×24px @fixed',
    ],
    child: GdsCheckmark(
      isChecked: isChecked,
      enabled: enabled,
      onTap: () => debugPrint('GdsCheckmark tapped'),
    ),
  );
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'Checkmark',
    children: [
      WidgetbookSubsection(
        title: 'isChecked × enabled',
        labels: ['2 states', '2 enabled'],
        content: _CheckmarkMatrix(colors: context.gdsColors),
      ),
    ],
  );
}

class _CheckmarkMatrix extends StatelessWidget {
  final GdsSemanticColor colors;

  const _CheckmarkMatrix({required this.colors});

  @override
  Widget build(BuildContext context) {
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
            for (final isChecked in [false, true])
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(isChecked ? 'true' : 'false', style: headerStyle),
                  ),
                ),
              ),
          ],
        ),
        for (final enabled in [true, false])
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(enabled ? 'enabled' : 'disabled', style: headerStyle),
              ),
              for (final isChecked in [false, true])
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: _buildPreview(isChecked, enabled),
                  ),
                ),
            ],
          ),
      ],
    );
  }

  Widget _buildPreview(bool isChecked, bool enabled) {
    Color iconColor;
    if (isChecked && !enabled) {
      iconColor = colors.icon.primarySubtle;
    } else if (isChecked) {
      iconColor = colors.icon.primaryNormal;
    } else if (!enabled) {
      iconColor = colors.icon.graySubtlest;
    } else {
      iconColor = colors.icon.graySubtle;
    }

    return GdsIcon.check.build(
      color: iconColor,
      width: GdsIconSize.v24,
      height: GdsIconSize.v24,
    );
  }
}
