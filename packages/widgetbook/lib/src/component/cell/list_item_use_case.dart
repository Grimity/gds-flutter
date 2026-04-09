import 'package:flutter/gestures.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(
  name: 'default',
  type: GdsListItem,
  path: '[component]/[cell]',
)
Widget buildGdsListItemUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'ListItem',
    description:
        'ListItem 컴포넌트입니다.\n'
        'section / rightIcon / optionCard / icon / pickerCard / textLarge / textMedium / '
        'checkBox / radio / checkMark 타입을 지원합니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

String _scopedKnobLabel(_ListItemPreviewType type, String name) {
  return '${type.label}.$name';
}

Widget _buildPlaygroundSection(BuildContext context) {
  final type = context.knobs.list<_ListItemPreviewType>(
    label: 'type',
    options: _ListItemPreviewType.values,
    initialOption: _ListItemPreviewType.section,
    labelBuilder: (value) => value.label,
  );

  late final Widget item;
  late final List<String> info;

  switch (type) {
    case _ListItemPreviewType.section:
      final text = context.knobs.string(
        label: _scopedKnobLabel(type, 'text'),
        initialValue: 'Text',
      );
      final width = context.knobs.double.slider(
        label: _scopedKnobLabel(type, 'width'),
        initialValue: 340,
        min: 160,
        max: 480,
      );

      item = SizedBox(
        width: width,
        child: GdsListItem.section(text: text),
      );

      info = [
        'type: ${type.label}',
        'text: $text',
        'width: ${width.toInt()}px',
      ];

    case _ListItemPreviewType.rightIcon:
      final text = context.knobs.string(
        label: _scopedKnobLabel(type, 'text'),
        initialValue: 'Text',
      );
      final subText = context.knobs.stringOrNull(
        label: _scopedKnobLabel(type, 'subText'),
        initialValue: 'Text',
      );
      final state = _stateKnob(context, type);

      item = SizedBox(
        width: 340,
        child: GdsListItem.rightIcon(
          text: text,
          subText: subText,
          state: state,
          onTap: () {},
        ),
      );

      info = [
        'type: ${type.label}',
        'state: ${state.name}',
        'text: $text',
        'subText: $subText',
      ];

    case _ListItemPreviewType.optionCard:
      final text = context.knobs.string(
        label: _scopedKnobLabel(type, 'text'),
        initialValue: 'Text',
      );
      final state = _stateKnob(context, type);
      final iconPreset = _iconPresetKnob(context, type);

      item = SizedBox(
        width: 340,
        child: GdsListItem.optionCard(
          text: text,
          icon: iconPreset.icon,
          state: state,
          onTap: () {},
        ),
      );

      info = [
        'type: ${type.label}',
        'state: ${state.name}',
        'text: $text',
        'icon: ${iconPreset.label}',
      ];

    case _ListItemPreviewType.icon:
      final text = context.knobs.string(
        label: _scopedKnobLabel(type, 'text'),
        initialValue: 'Text',
      );
      final state = _stateKnob(context, type);
      final iconPreset = _iconPresetKnob(context, type);

      item = SizedBox(
        width: 340,
        child: GdsListItem.icon(
          text: text,
          icon: iconPreset.icon,
          state: state,
          onTap: () {},
        ),
      );

      info = [
        'type: ${type.label}',
        'state: ${state.name}',
        'text: $text',
        'icon: ${iconPreset.label}',
      ];

    case _ListItemPreviewType.pickerCard:
      final text = context.knobs.string(
        label: _scopedKnobLabel(type, 'text'),
        initialValue: 'Text',
      );
      final state = _stateKnob(context, type);

      item = GdsListItem.pickerCard(
        text: text,
        state: state,
        onTap: () {},
      );

      info = [
        'type: ${type.label}',
        'state: ${state.name}',
        'text: $text',
        'width: intrinsic',
      ];

    case _ListItemPreviewType.textLarge:
      final text = context.knobs.string(
        label: _scopedKnobLabel(type, 'text'),
        initialValue: 'Text',
      );
      final state = _stateKnob(context, type);
      final isNegative = context.knobs.boolean(
        label: _scopedKnobLabel(type, 'isNegative'),
        initialValue: false,
      );

      item = SizedBox(
        width: 340,
        child: GdsListItem.textLarge(
          text: text,
          state: state,
          isNegative: isNegative,
          onTap: () {},
        ),
      );

      info = [
        'type: ${type.label}',
        'state: ${state.name}',
        'text: $text',
        'isNegative: $isNegative',
      ];

    case _ListItemPreviewType.textMedium:
      final text = context.knobs.string(
        label: _scopedKnobLabel(type, 'text'),
        initialValue: 'Text',
      );
      final state = _stateKnob(context, type);
      final isNegative = context.knobs.boolean(
        label: _scopedKnobLabel(type, 'isNegative'),
        initialValue: false,
      );

      item = SizedBox(
        width: 340,
        child: GdsListItem.textMedium(
          text: text,
          state: state,
          isNegative: isNegative,
          onTap: () {},
        ),
      );

      info = [
        'type: ${type.label}',
        'state: ${state.name}',
        'text: $text',
        'isNegative: $isNegative',
      ];

    case _ListItemPreviewType.checkBox:
      final text = context.knobs.string(
        label: _scopedKnobLabel(type, 'text'),
        initialValue: 'Text',
      );
      final state = _stateKnob(context, type);

      item = SizedBox(
        width: 340,
        child: GdsListItem.checkBox(
          text: text,
          state: state,
          onTap: () {},
        ),
      );

      info = [
        'type: ${type.label}',
        'state: ${state.name}',
        'text: $text',
      ];

    case _ListItemPreviewType.radio:
      final text = context.knobs.string(
        label: _scopedKnobLabel(type, 'text'),
        initialValue: 'Text',
      );
      final state = _stateKnob(context, type);

      item = SizedBox(
        width: 340,
        child: GdsListItem.radio(
          text: text,
          state: state,
          onTap: () {},
        ),
      );

      info = [
        'type: ${type.label}',
        'state: ${state.name}',
        'text: $text',
      ];

    case _ListItemPreviewType.checkMark:
      final text = context.knobs.string(
        label: _scopedKnobLabel(type, 'text'),
        initialValue: 'Text',
      );
      final state = _stateKnob(context, type);

      item = SizedBox(
        width: 340,
        child: GdsListItem.checkMark(
          text: text,
          state: state,
          onTap: () {},
        ),
      );

      info = [
        'type: ${type.label}',
        'state: ${state.name}',
        'text: $text',
      ];
  }

  return WidgetbookPlayground(
    layout: PlaygroundLayout.center,
    info: info,
    child: Align(
      alignment: Alignment.centerLeft,
      child: item,
    ),
  );
}

GdsListItemState _stateKnob(BuildContext context, _ListItemPreviewType type) {
  return context.knobs.list<GdsListItemState>(
    label: _scopedKnobLabel(type, 'state'),
    options: GdsListItemState.values,
    initialOption: GdsListItemState.enabled,
    labelBuilder: (value) => value.name,
  );
}

_ListItemIconPreset _iconPresetKnob(BuildContext context, _ListItemPreviewType type) {
  return context.knobs.list<_ListItemIconPreset>(
    label: _scopedKnobLabel(type, 'icon'),
    options: _ListItemIconPreset.values,
    initialOption: _ListItemIconPreset.none,
    labelBuilder: (value) => value.label,
  );
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'ListItem',
    children: const [
      WidgetbookSubsection(
        title: 'Figma Matrix',
        labels: ['Cell/ListItem', 'Enabled/Focused/Hovered/Pressed/Disabled/Negative'],
        content: _ListItemStateMatrix(),
      ),
    ],
  );
}

enum _ListItemPreviewType {
  section,
  rightIcon,
  optionCard,
  icon,
  pickerCard,
  textLarge,
  textMedium,
  checkBox,
  radio,
  checkMark;

  String get label => switch (this) {
    _ListItemPreviewType.section => 'section',
    _ListItemPreviewType.rightIcon => 'rightIcon',
    _ListItemPreviewType.optionCard => 'optionCard',
    _ListItemPreviewType.icon => 'icon',
    _ListItemPreviewType.pickerCard => 'pickerCard',
    _ListItemPreviewType.textLarge => 'textLarge',
    _ListItemPreviewType.textMedium => 'textMedium',
    _ListItemPreviewType.checkBox => 'checkBox',
    _ListItemPreviewType.radio => 'radio',
    _ListItemPreviewType.checkMark => 'checkMark',
  };

  String get matrixLabel => switch (this) {
    _ListItemPreviewType.section => 'section',
    _ListItemPreviewType.rightIcon => 'right icon',
    _ListItemPreviewType.optionCard => 'Option Card icon',
    _ListItemPreviewType.icon => 'Icon',
    _ListItemPreviewType.pickerCard => 'Picker Card',
    _ListItemPreviewType.textLarge => 'Text_lg',
    _ListItemPreviewType.textMedium => 'Text_md',
    _ListItemPreviewType.checkBox => 'Check box',
    _ListItemPreviewType.radio => 'Radio',
    _ListItemPreviewType.checkMark => 'Check Mark',
  };
}

enum _ListItemIconPreset {
  none,
  plus,
  check,
  chevronRight;

  String get label => switch (this) {
    _ListItemIconPreset.none => 'none',
    _ListItemIconPreset.plus => 'plus',
    _ListItemIconPreset.check => 'check',
    _ListItemIconPreset.chevronRight => 'chevronRight',
  };

  GdsIcon? get icon => switch (this) {
    _ListItemIconPreset.none => null,
    _ListItemIconPreset.plus => GdsIcon.plus,
    _ListItemIconPreset.check => GdsIcon.check,
    _ListItemIconPreset.chevronRight => GdsIcon.chevronRight,
  };
}

enum _MatrixColumn {
  enabled,
  focused,
  hovered,
  pressed,
  disabled,
  negative;

  String get label => switch (this) {
    _MatrixColumn.enabled => 'Enabled',
    _MatrixColumn.focused => 'Focused',
    _MatrixColumn.hovered => 'Hovered',
    _MatrixColumn.pressed => 'Pressed',
    _MatrixColumn.disabled => 'Disabled',
    _MatrixColumn.negative => 'Negative',
  };

  GdsListItemState? get state => switch (this) {
    _MatrixColumn.enabled => GdsListItemState.enabled,
    _MatrixColumn.focused => GdsListItemState.focused,
    _MatrixColumn.hovered => GdsListItemState.hovered,
    _MatrixColumn.pressed => GdsListItemState.pressed,
    _MatrixColumn.disabled => GdsListItemState.disabled,
    _MatrixColumn.negative => null,
  };
}

class _ListItemStateMatrix extends StatefulWidget {
  const _ListItemStateMatrix();

  @override
  State<_ListItemStateMatrix> createState() => _ListItemStateMatrixState();
}

class _ListItemStateMatrixState extends State<_ListItemStateMatrix> {
  final ScrollController _horizontalController = ScrollController();

  static const double _labelColumnWidth = 140;
  static const double _itemColumnWidth = 356;

  static const List<_MatrixColumn> _columns = [
    _MatrixColumn.enabled,
    _MatrixColumn.focused,
    _MatrixColumn.hovered,
    _MatrixColumn.pressed,
    _MatrixColumn.disabled,
    _MatrixColumn.negative,
  ];

  static const List<_ListItemPreviewType> _rows = [
    _ListItemPreviewType.section,
    _ListItemPreviewType.rightIcon,
    _ListItemPreviewType.optionCard,
    _ListItemPreviewType.icon,
    _ListItemPreviewType.pickerCard,
    _ListItemPreviewType.textLarge,
    _ListItemPreviewType.textMedium,
    _ListItemPreviewType.checkBox,
    _ListItemPreviewType.radio,
    _ListItemPreviewType.checkMark,
  ];

  @override
  void dispose() {
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final labelStyle = GdsTypography.caption1.copyWith(color: colors.text.graySubtle);
    final tableWidth = _labelColumnWidth + (_itemColumnWidth * _columns.length);

    final table = SizedBox(
      width: tableWidth,
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {
          0: FixedColumnWidth(_labelColumnWidth),
          1: FixedColumnWidth(_itemColumnWidth),
          2: FixedColumnWidth(_itemColumnWidth),
          3: FixedColumnWidth(_itemColumnWidth),
          4: FixedColumnWidth(_itemColumnWidth),
          5: FixedColumnWidth(_itemColumnWidth),
          6: FixedColumnWidth(_itemColumnWidth),
        },
        children: [
          TableRow(
            children: [
              const SizedBox.shrink(),
              for (final column in _columns)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Center(
                    child: Text(column.label, style: labelStyle),
                  ),
                ),
            ],
          ),
          for (final type in _rows)
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16, top: 8),
                  child: Text(type.matrixLabel, style: labelStyle),
                ),
                for (final column in _columns)
                  _MatrixCell(
                    type: type,
                    column: column,
                  ),
              ],
            ),
        ],
      ),
    );

    final scrollBehavior = ScrollConfiguration.of(context).copyWith(
      dragDevices: const {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      },
    );

    return ScrollConfiguration(
      behavior: scrollBehavior,
      child: Scrollbar(
        controller: _horizontalController,
        thumbVisibility: true,
        trackVisibility: true,
        scrollbarOrientation: ScrollbarOrientation.bottom,
        child: SingleChildScrollView(
          controller: _horizontalController,
          scrollDirection: Axis.horizontal,
          child: table,
        ),
      ),
    );
  }
}

class _MatrixCell extends StatelessWidget {
  final _ListItemPreviewType type;
  final _MatrixColumn column;

  const _MatrixCell({
    required this.type,
    required this.column,
  });

  @override
  Widget build(BuildContext context) {
    final item = _buildMatrixItem(type: type, column: column);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: 340,
        child: Align(
          alignment: Alignment.centerLeft,
          child: item ?? const SizedBox.shrink(),
        ),
      ),
    );
  }
}

Widget? _buildMatrixItem({
  required _ListItemPreviewType type,
  required _MatrixColumn column,
}) {
  if (type == _ListItemPreviewType.section && column != _MatrixColumn.enabled) {
    return null;
  }

  final isNegativeColumn = column == _MatrixColumn.negative;
  final supportsNegative = type == _ListItemPreviewType.textLarge || type == _ListItemPreviewType.textMedium;

  if (isNegativeColumn && !supportsNegative) {
    return null;
  }

  if (isNegativeColumn) {
    return switch (type) {
      _ListItemPreviewType.textLarge => GdsListItem.textLarge(
        text: 'Input filled',
        state: GdsListItemState.pressed,
        isNegative: true,
        onTap: () {},
      ),
      _ListItemPreviewType.textMedium => GdsListItem.textMedium(
        text: 'Input filled',
        state: GdsListItemState.pressed,
        isNegative: true,
        onTap: () {},
      ),
      _ => null,
    };
  }

  final state = column.state!;

  return switch (type) {
    _ListItemPreviewType.section => const GdsListItem.section(text: 'Text'),
    _ListItemPreviewType.rightIcon => GdsListItem.rightIcon(
      text: 'Text',
      subText: 'Text',
      state: state,
      onTap: () {},
    ),
    _ListItemPreviewType.optionCard => GdsListItem.optionCard(
      text: 'Text',
      icon: GdsIcon.blank,
      state: state,
      onTap: () {},
    ),
    _ListItemPreviewType.icon => GdsListItem.icon(
      text: 'Text',
      icon: GdsIcon.blank,
      state: state,
      onTap: () {},
    ),
    _ListItemPreviewType.pickerCard => GdsListItem.pickerCard(
      text: 'Text',
      state: state,
      onTap: () {},
    ),
    _ListItemPreviewType.textLarge => GdsListItem.textLarge(
      text: 'Text',
      state: state,
      isNegative: false,
      onTap: () {},
    ),
    _ListItemPreviewType.textMedium => GdsListItem.textMedium(
      text: 'Text',
      state: state,
      isNegative: false,
      onTap: () {},
    ),
    _ListItemPreviewType.checkBox => GdsListItem.checkBox(
      text: 'Text',
      state: state,
      onTap: () {},
    ),
    _ListItemPreviewType.radio => GdsListItem.radio(
      text: 'Text',
      state: state,
      onTap: () {},
    ),
    _ListItemPreviewType.checkMark => GdsListItem.checkMark(
      text: 'Text',
      state: state,
      onTap: () {},
    ),
  };
}
