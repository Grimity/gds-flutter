import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(name: 'default', type: GdsTextField, path: '[component]/[input]')
Widget buildGdsTextFieldUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'TextField',
    description:
        '사용자가 텍스트를 입력할 수 있는 필드입니다.\n'
        'Default / Count / Search / Title 네 가지 타입을 제공합니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final type = context.knobs.list<GdsTextFieldType>(
    label: 'type',
    options: GdsTextFieldType.values,
    labelBuilder: (t) => t.name,
  );

  final size = context.knobs.list<GdsTextFieldSize>(
    label: 'size',
    options: GdsTextFieldSize.values,
    labelBuilder: (s) => s.name,
  );

  final enabled = context.knobs.boolean(label: 'enabled', initialValue: true);
  final error = context.knobs.boolean(label: 'error', initialValue: false);
  final success = context.knobs.boolean(label: 'success', initialValue: false);

  final mentionUser = context.knobs.stringOrNull(label: 'mentionUser');

  final bool isDefault = type == GdsTextFieldType.defaultField;
  final bool hasErrorSuccess = isDefault || type == GdsTextFieldType.count;
  final bool supportsMultiline = isDefault || type == GdsTextFieldType.count;
  final isMultipleLine = supportsMultiline
      ? context.knobs.boolean(label: 'isMultipleLine', initialValue: false)
      : false;

  final Widget field = switch (type) {
    GdsTextFieldType.count => GdsTextField.count(
      maxLength: 100,
      isMultipleLine: isMultipleLine,
      placeholder: 'placeholder',
      size: size,
      enabled: enabled,
      error: error,
      success: success,
    ),
    GdsTextFieldType.search => GdsTextField.search(
      placeholder: 'placeholder',
      size: size,
      enabled: enabled,
    ),
    GdsTextFieldType.title => GdsTextField.title(
      placeholder: 'placeholder',
      maxLength: 100,
      size: size,
      enabled: enabled,
    ),
    GdsTextFieldType.defaultField => GdsTextField(
      isMultipleLine: isMultipleLine,
      placeholder: 'placeholder',
      mentionUser: mentionUser,
      size: size,
      enabled: enabled,
      error: error,
      success: success,
    ),
  };

  return WidgetbookPlayground(
    info: [
      'type: ${type.name}',
      'size: ${size.name}',
      'enabled: $enabled',
      if (hasErrorSuccess) 'error: $error',
      if (hasErrorSuccess) 'success: $success',
      if (isDefault) 'mentionUser: $mentionUser',
      if (supportsMultiline) 'isMultipleLine: $isMultipleLine',
      if (supportsMultiline) 'maxLines: ${isMultipleLine ? 4 : 1} @derived',
      'height: ${size.height(type).toInt()}px @fixed',
      'radius: ${type.borderRadius}',
    ],
    child: SizedBox(width: 300, child: field),
  );
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'TextField',
    children: [
      WidgetbookSubsection(
        title: '(size × type) × state',
        labels: ['2 sizes', '4 types', '7 states'],
        content: const _TextFieldMatrix(),
      ),
      WidgetbookSubsection(
        title: 'multiline examples',
        labels: ['2 supported types', 'isMultipleLine false/true'],
        content: const _TextFieldMultilineExamples(),
      ),
    ],
  );
}

enum _PreviewState {
  enabled(GdsTextFieldState.enabled),
  filled(GdsTextFieldState.filled),
  focused(GdsTextFieldState.focused),
  error(GdsTextFieldState.error),
  success(GdsTextFieldState.success),
  disabled(GdsTextFieldState.disabled),
  mention(GdsTextFieldState.focused);

  const _PreviewState(this.fieldState);

  final GdsTextFieldState fieldState;

  bool get hasText => switch (this) {
    _PreviewState.enabled || _PreviewState.disabled => false,
    _ => true,
  };

  bool get isMention => this == _PreviewState.mention;
}

class _RowEntry {
  final GdsTextFieldSize size;
  final GdsTextFieldType type;

  const _RowEntry(this.size, this.type);

  String get label => '${size.name} / ${type.name}';
}

const _rows = [
  _RowEntry(GdsTextFieldSize.medium, GdsTextFieldType.defaultField),
  _RowEntry(GdsTextFieldSize.medium, GdsTextFieldType.count),
  _RowEntry(GdsTextFieldSize.medium, GdsTextFieldType.search),
  _RowEntry(GdsTextFieldSize.medium, GdsTextFieldType.title),
  _RowEntry(GdsTextFieldSize.small, GdsTextFieldType.defaultField),
  _RowEntry(GdsTextFieldSize.small, GdsTextFieldType.count),
  _RowEntry(GdsTextFieldSize.small, GdsTextFieldType.search),
  _RowEntry(GdsTextFieldSize.small, GdsTextFieldType.title),
];

class _TextFieldMatrix extends StatelessWidget {
  const _TextFieldMatrix();

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final labelStyle = GdsTypography.caption1.copyWith(color: colors.text.graySubtle);

    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: IntrinsicColumnWidth(),
        2: IntrinsicColumnWidth(),
        3: IntrinsicColumnWidth(),
        4: IntrinsicColumnWidth(),
        5: IntrinsicColumnWidth(),
        6: IntrinsicColumnWidth(),
        7: IntrinsicColumnWidth(),
      },
      children: [
        TableRow(
          children: [
            const SizedBox.shrink(),
            for (final state in _PreviewState.values)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Center(child: Text(state.name, style: labelStyle)),
              ),
          ],
        ),
        for (final row in _rows)
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(row.label, style: labelStyle),
              ),
              for (final state in _PreviewState.values)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: _isEmptyCell(row.type, state)
                      ? const SizedBox(width: 160)
                      : SizedBox(
                          width: 160,
                          child: _buildPreview(row.size, row.type, state, context),
                        ),
                ),
            ],
          ),
      ],
    );
  }

  bool _isEmptyCell(GdsTextFieldType type, _PreviewState state) {
    if (state.isMention) {
      return type != GdsTextFieldType.defaultField;
    }
    if (type == GdsTextFieldType.search) {
      return state == _PreviewState.error || state == _PreviewState.success;
    }
    return false;
  }

  Widget _buildPreview(
    GdsTextFieldSize size,
    GdsTextFieldType type,
    _PreviewState preview,
    BuildContext context,
  ) {
    final colors = context.gdsColors;
    final state = preview.fieldState;
    final hasText = preview.hasText;
    const demoText = 'Input filled';
    const demoMaxLength = 100;
    final demoCurrentLength = hasText ? 6 : 0;

    final children = <Widget>[];

    // Leading icon (search 타입 고정)
    final leading = type.leadingIcon;
    if (leading != null) {
      children.add(
        leading.build(
          color: type.placeholderColor(colors, state),
          width: GdsIconSize.v20,
          height: GdsIconSize.v20,
        ),
      );
      children.add(const SizedBox(width: GdsSpacing.spacing8));
    }

    // Mention prefix
    if (preview.isMention) {
      children.add(
        Text(
          '@[user]',
          style: GdsTypography.label3.copyWith(color: colors.text.primaryNormal),
        ),
      );
      children.add(const SizedBox(width: GdsSpacing.spacing6));
    }

    // 텍스트 영역
    children.add(
      Expanded(
        child: Text(
          demoText,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: size
              .textStyle(type)
              .copyWith(
                color: hasText ? type.inputTextColor(colors, state) : type.placeholderColor(colors, state),
              ),
        ),
      ),
    );

    // 우측 영역: count 배지 또는 clear 아이콘
    final bool hasCount = type == GdsTextFieldType.count || type == GdsTextFieldType.title;

    if (hasCount) {
      children.add(const SizedBox(width: GdsSpacing.spacing8));
      children.add(
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '$demoCurrentLength',
                style: GdsTypography.label5.copyWith(
                  color: type.countCurrentColor(colors, state),
                ),
              ),
              TextSpan(
                text: '/$demoMaxLength',
                style: GdsTypography.label5.copyWith(
                  color: type.countRestColor(colors, state),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      final trailing = type.trailingIcon(hasText: hasText);
      if (trailing != null) {
        children.add(const SizedBox(width: GdsSpacing.spacing8));
        children.add(
          trailing.build(
            color: type.placeholderColor(colors, state),
            width: GdsIconSize.v20,
            height: GdsIconSize.v20,
          ),
        );
      }
    }

    return Container(
      height: size.height(type),
      padding: size.padding(type),
      decoration: BoxDecoration(
        color: type.backgroundColor(colors, state),
        border: type.border(colors, state),
        borderRadius: type.borderRadius,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}

class _MultilineRowEntry {
  const _MultilineRowEntry(this.size, this.type);

  final GdsTextFieldSize size;
  final GdsTextFieldType type;

  String get label => '${size.name} / ${type.name}';
}

const _multilineRows = [
  _MultilineRowEntry(GdsTextFieldSize.medium, GdsTextFieldType.defaultField),
  _MultilineRowEntry(GdsTextFieldSize.medium, GdsTextFieldType.count),
  _MultilineRowEntry(GdsTextFieldSize.small, GdsTextFieldType.defaultField),
  _MultilineRowEntry(GdsTextFieldSize.small, GdsTextFieldType.count),
];

class _TextFieldMultilineExamples extends StatelessWidget {
  const _TextFieldMultilineExamples();

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final labelStyle = GdsTypography.caption1.copyWith(color: colors.text.graySubtle);

    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: IntrinsicColumnWidth(),
        2: IntrinsicColumnWidth(),
      },
      children: [
        TableRow(
          children: [
            const SizedBox.shrink(),
            for (final isMultipleLine in [false, true])
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Center(
                  child: Text(
                    'isMultipleLine $isMultipleLine',
                    style: labelStyle,
                  ),
                ),
              ),
          ],
        ),
        for (final row in _multilineRows)
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16, top: 8),
                child: Text(row.label, style: labelStyle),
              ),
              for (final isMultipleLine in [false, true])
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    width: 180,
                    child: _MultilinePreview(
                      size: row.size,
                      type: row.type,
                      isMultipleLine: isMultipleLine,
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}

class _MultilinePreview extends StatefulWidget {
  const _MultilinePreview({
    required this.size,
    required this.type,
    required this.isMultipleLine,
  });

  final GdsTextFieldSize size;
  final GdsTextFieldType type;
  final bool isMultipleLine;

  @override
  State<_MultilinePreview> createState() => _MultilinePreviewState();
}

class _MultilinePreviewState extends State<_MultilinePreview> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: List.filled(widget.isMultipleLine ? 4 : 1, 'Input filled').join('\n'),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return switch (widget.type) {
      GdsTextFieldType.defaultField => GdsTextField(
        placeholder: 'placeholder',
        size: widget.size,
        controller: _controller,
        isMultipleLine: widget.isMultipleLine,
      ),
      GdsTextFieldType.count => GdsTextField.count(
        maxLength: 100,
        placeholder: 'placeholder',
        size: widget.size,
        controller: _controller,
        isMultipleLine: widget.isMultipleLine,
      ),
      _ => const SizedBox.shrink(),
    };
  }
}
