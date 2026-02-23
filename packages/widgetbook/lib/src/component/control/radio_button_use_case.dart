import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(name: 'default', type: GdsRadioButton, path: '[component]/[control]')
Widget buildGdsRadioButtonUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'RadioButton',
    description: '단일 선택 옵션을 제어할 때 사용합니다. 외부 링(20×20px)과 내부 dot(12×12px)으로 구성됩니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final isSelected = context.knobs.boolean(label: 'isSelected', initialValue: false);
  final enabled = context.knobs.boolean(label: 'enabled', initialValue: true);

  return WidgetbookPlayground(
    info: [
      'isSelected: $isSelected',
      'enabled: $enabled',
      'size: 24×24px @fixed',
      'ring: 20×20px, stroke 2px',
      'dot: 12×12px (isSelected=true only)',
    ],
    child: _InteractiveRadioButton(enabled: enabled, initialSelected: isSelected),
  );
}

class _InteractiveRadioButton extends StatefulWidget {
  final bool enabled;
  final bool initialSelected;

  const _InteractiveRadioButton({required this.enabled, required this.initialSelected});

  @override
  State<_InteractiveRadioButton> createState() => _InteractiveRadioButtonState();
}

class _InteractiveRadioButtonState extends State<_InteractiveRadioButton> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.initialSelected;
  }

  @override
  void didUpdateWidget(_InteractiveRadioButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialSelected != widget.initialSelected) {
      _isSelected = widget.initialSelected;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GdsRadioButton(
      isSelected: _isSelected,
      enabled: widget.enabled,
      onTap: () => setState(() => _isSelected = !_isSelected),
    );
  }
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'RadioButton',
    children: [
      WidgetbookSubsection(
        title: 'isSelected × enabled',
        labels: ['2 states', '2 enabled'],
        content: const _RadioButtonMatrix(),
      ),
    ],
  );
}

class _RadioButtonMatrix extends StatelessWidget {
  const _RadioButtonMatrix();

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
            for (final isSelected in [false, true])
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(isSelected ? 'true' : 'false', style: headerStyle),
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
              for (final isSelected in [false, true])
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: GdsRadioButton(
                      isSelected: isSelected,
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
