import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(
  name: 'default',
  type: GdsControlItem,
  path: '[component]/[cell]',
)
Widget buildGdsControlItemUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'ControlItem',
    description: 'Bold/Normal 텍스트와 Toggle/Check box/Radio/Check Mark 타입을 상태별로 조합하는 셀 컴포넌트입니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final type = context.knobs.list<_ControlItemPreviewType>(
    label: 'type',
    options: _ControlItemPreviewType.values,
    initialOption: _ControlItemPreviewType.toggle,
    labelBuilder: (value) => value.label,
  );
  final variant = context.knobs.list<GdsControlItemVariant>(
    label: 'variant',
    options: GdsControlItemVariant.values,
    initialOption: GdsControlItemVariant.bold,
    labelBuilder: (value) => value.name,
  );
  final state = context.knobs.list<GdsControlItemState>(
    label: 'state',
    options: GdsControlItemState.values,
    initialOption: GdsControlItemState.enabled,
    labelBuilder: (value) => value.name,
  );
  final text = context.knobs.string(label: 'text', initialValue: 'Text');

  return WidgetbookPlayground(
    layout: PlaygroundLayout.center,
    info: [
      'type: ${type.label}',
      'variant: ${variant.name}',
      'state: ${state.name}',
      'width: 340px @fixed',
      'height: 52px @fixed',
      'tap: enabled ↔ pressed',
    ],
    child: Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: 340,
        child: _InteractiveControlItem(
          type: type,
          text: text,
          variant: variant,
          initialState: state,
        ),
      ),
    ),
  );
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'ControlItem',
    children: [
      WidgetbookSubsection(
        title: 'variant × type × state',
        labels: const ['2 variants', '4 types', '4 states'],
        content: const _ControlItemMatrix(),
      ),
    ],
  );
}

Widget _buildControlItem({
  required _ControlItemPreviewType type,
  required String text,
  required GdsControlItemVariant variant,
  required GdsControlItemState state,
  required VoidCallback onTap,
}) {
  return switch (type) {
    _ControlItemPreviewType.toggle => GdsControlItem.toggle(
      text: text,
      variant: variant,
      state: state,
      onTap: onTap,
    ),
    _ControlItemPreviewType.checkbox => GdsControlItem.checkbox(
      text: text,
      variant: variant,
      state: state,
      onTap: onTap,
    ),
    _ControlItemPreviewType.radio => GdsControlItem.radio(
      text: text,
      variant: variant,
      state: state,
      onTap: onTap,
    ),
    _ControlItemPreviewType.checkmark => GdsControlItem.checkmark(
      text: text,
      variant: variant,
      state: state,
      onTap: onTap,
    ),
  };
}

enum _ControlItemPreviewType {
  toggle,
  checkbox,
  radio,
  checkmark;

  String get label => switch (this) {
    _ControlItemPreviewType.toggle => 'Toggle',
    _ControlItemPreviewType.checkbox => 'Check box',
    _ControlItemPreviewType.radio => 'Radio',
    _ControlItemPreviewType.checkmark => 'Check Mark',
  };
}

extension _ControlItemStateLabel on GdsControlItemState {
  String get label => switch (this) {
    GdsControlItemState.enabled => 'Enabled',
    GdsControlItemState.focused => 'Focused',
    GdsControlItemState.pressed => 'Pressed',
    GdsControlItemState.disabled => 'Disabled',
  };
}

class _ControlItemMatrix extends StatelessWidget {
  const _ControlItemMatrix();

  static const List<GdsControlItemState> _states = [
    GdsControlItemState.enabled,
    GdsControlItemState.focused,
    GdsControlItemState.pressed,
    GdsControlItemState.disabled,
  ];

  static const List<_ControlItemRow> _rows = [
    _ControlItemRow(
      label: 'Bold Toggle',
      type: _ControlItemPreviewType.toggle,
      variant: GdsControlItemVariant.bold,
    ),
    _ControlItemRow(
      label: 'Bold Check box',
      type: _ControlItemPreviewType.checkbox,
      variant: GdsControlItemVariant.bold,
    ),
    _ControlItemRow(
      label: 'Bold Radio',
      type: _ControlItemPreviewType.radio,
      variant: GdsControlItemVariant.bold,
    ),
    _ControlItemRow(
      label: 'Bold Check Mark',
      type: _ControlItemPreviewType.checkmark,
      variant: GdsControlItemVariant.bold,
    ),
    _ControlItemRow(
      label: 'Normal Toggle',
      type: _ControlItemPreviewType.toggle,
      variant: GdsControlItemVariant.normal,
    ),
    _ControlItemRow(
      label: 'Normal Check box',
      type: _ControlItemPreviewType.checkbox,
      variant: GdsControlItemVariant.normal,
    ),
    _ControlItemRow(
      label: 'Normal Radio',
      type: _ControlItemPreviewType.radio,
      variant: GdsControlItemVariant.normal,
    ),
    _ControlItemRow(
      label: 'Normal Check Mark',
      type: _ControlItemPreviewType.checkmark,
      variant: GdsControlItemVariant.normal,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final headerStyle = GdsTypography.caption1.copyWith(color: colors.text.graySubtle);

    return SizedBox(
      width: double.infinity,
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
          3: FlexColumnWidth(),
          4: FlexColumnWidth(),
        },
        children: [
          TableRow(
            children: [
              const SizedBox.shrink(),
              for (final state in _states)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(state.label, style: headerStyle),
                    ),
                  ),
                ),
            ],
          ),
          for (final row in _rows)
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Text(row.label, style: headerStyle),
                ),
                for (final state in _states)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: _buildControlItem(
                      type: row.type,
                      text: 'Text',
                      variant: row.variant,
                      state: state,
                      onTap: () {},
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

class _ControlItemRow {
  final String label;
  final _ControlItemPreviewType type;
  final GdsControlItemVariant variant;

  const _ControlItemRow({
    required this.label,
    required this.type,
    required this.variant,
  });
}

class _InteractiveControlItem extends StatefulWidget {
  final _ControlItemPreviewType type;
  final String text;
  final GdsControlItemVariant variant;
  final GdsControlItemState initialState;

  const _InteractiveControlItem({
    required this.type,
    required this.text,
    required this.variant,
    required this.initialState,
  });

  @override
  State<_InteractiveControlItem> createState() => _InteractiveControlItemState();
}

class _InteractiveControlItemState extends State<_InteractiveControlItem> {
  late GdsControlItemState _state;

  @override
  void initState() {
    super.initState();
    _state = widget.initialState;
  }

  @override
  void didUpdateWidget(covariant _InteractiveControlItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialState != widget.initialState ||
        oldWidget.type != widget.type ||
        oldWidget.variant != widget.variant ||
        oldWidget.text != widget.text) {
      _state = widget.initialState;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildControlItem(
      type: widget.type,
      text: widget.text,
      variant: widget.variant,
      state: _state,
      onTap: () {
        setState(() {
          _state = switch (_state) {
            GdsControlItemState.pressed => GdsControlItemState.enabled,
            GdsControlItemState.disabled => GdsControlItemState.disabled,
            _ => GdsControlItemState.pressed,
          };
        });
      },
    );
  }
}
