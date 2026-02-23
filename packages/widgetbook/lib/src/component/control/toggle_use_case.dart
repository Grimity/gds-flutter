import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(name: 'default', type: GdsToggle, path: '[component]/[control]')
Widget buildGdsToggleUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Toggle',
    description: '낮은 위계로 활성화 여부를 제어할 때 사용합니다. 탭 시 thumb 슬라이딩 애니메이션(200ms easeOut)을 지원합니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final enabled = context.knobs.boolean(label: 'enabled', initialValue: true);

  return WidgetbookPlayground(
    info: [
      'enabled: $enabled',
      'track: 52×32px @fixed',
      'thumb: 24×24px @fixed',
    ],
    child: _InteractiveToggle(enabled: enabled),
  );
}

class _InteractiveToggle extends StatefulWidget {
  final bool enabled;

  const _InteractiveToggle({required this.enabled});

  @override
  State<_InteractiveToggle> createState() => _InteractiveToggleState();
}

class _InteractiveToggleState extends State<_InteractiveToggle> {
  bool _isOn = false;

  @override
  Widget build(BuildContext context) {
    return GdsToggle(
      isOn: _isOn,
      enabled: widget.enabled,
      onTap: () => setState(() => _isOn = !_isOn),
    );
  }
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'Toggle',
    children: [
      WidgetbookSubsection(
        title: 'isOn × enabled',
        labels: ['2 states', '2 enabled'],
        content: const _ToggleMatrix(),
      ),
    ],
  );
}

class _ToggleMatrix extends StatelessWidget {
  const _ToggleMatrix();

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
            for (final isOn in [false, true])
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(isOn ? 'true' : 'false', style: headerStyle),
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
              for (final isOn in [false, true])
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: GdsToggle(
                      isOn: isOn,
                      enabled: enabled,
                      onTap: () {},
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}
