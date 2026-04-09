import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

enum _IconColorMode {
  buttonDefault,
  custom,
}

String _toHex(Color color) => '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';

@widgetbook.UseCase(
  name: 'default',
  type: GdsTextButton,
  path: '[component]/[button]/',
)
Widget buildGdsTextButtonUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'TextButton',
    description: '배경색이나 테두리가 없는 버튼으로, 텍스트만으로 구성됩니다.\n주로 강조가 덜한 보조적인 액션에 사용합니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final variant = context.knobs.list<GdsTextButtonVariant>(
    label: 'variant',
    options: GdsTextButtonVariant.values,
    labelBuilder: (v) => v.name,
  );

  final size = context.knobs.list<GdsTextButtonSize>(
    label: 'size',
    options: GdsTextButtonSize.values,
    labelBuilder: (s) => s.name,
  );

  final form = context.knobs.list<String>(
    label: 'form',
    options: ['Default', 'IconLeft', 'IconRight'],
  );

  final enabled = context.knobs.boolean(label: 'enabled', initialValue: true);
  final loading = context.knobs.boolean(label: 'loading', initialValue: false);

  final icon = context.knobs.list<GdsIcon>(
    label: 'icon',
    options: [
      GdsIcon.heartFill,
      GdsIcon.bellFill,
      GdsIcon.plus,
      GdsIcon.xMark,
      GdsIcon.share,
      GdsIcon.trash,
    ],
    initialOption: GdsIcon.heartFill,
    labelBuilder: (i) => i.name,
  );
  final iconColorMode = context.knobs.list<_IconColorMode>(
    label: 'iconColorMode',
    options: _IconColorMode.values,
    initialOption: _IconColorMode.buttonDefault,
    labelBuilder: (mode) => mode.name,
  );
  Color? customIconColor;
  final iconColor = switch (iconColorMode) {
    _IconColorMode.buttonDefault => null,
    _IconColorMode.custom => customIconColor = context.knobs.color(
      label: 'customIconColor',
      initialValue: const Color(0xFFE53935),
    ),
  };

  final Widget button = switch (form) {
    'IconLeft' => GdsTextButton(
      text: 'Label',
      leadingIcon: icon,
      iconColor: iconColor,
      size: size,
      variant: variant,
      enabled: enabled,
      loading: loading,
      onPressed: () => debugPrint('GdsTextButton tapped'),
    ),
    'IconRight' => GdsTextButton(
      text: 'Label',
      trailingIcon: icon,
      iconColor: iconColor,
      size: size,
      variant: variant,
      enabled: enabled,
      loading: loading,
      onPressed: () => debugPrint('GdsTextButton tapped'),
    ),
    _ => GdsTextButton(
      text: 'Label',
      iconColor: iconColor,
      size: size,
      variant: variant,
      enabled: enabled,
      loading: loading,
      onPressed: () => debugPrint('GdsTextButton tapped'),
    ),
  };

  return WidgetbookPlayground(
    info: [
      'variant: ${variant.name}',
      'size: ${size.name}',
      'form: $form',
      'enabled: $enabled',
      'loading: $loading',
      'iconColorMode: ${iconColorMode.name}',
      if (customIconColor != null) 'customIconColor: ${_toHex(customIconColor)}',
      'iconSize: ${size.iconSize.toInt()}px @fixed',
      'gap: ${size.gap.toInt()}px @fixed',
      'radius: xs (4px) @fixed',
    ],
    child: button,
  );
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'TextButton',
    children: [
      WidgetbookSubsection(
        title: '(variant × size × form) × state',
        labels: ['2 variants', '3 sizes', '3 forms', '6 states'],
        content: const _TextButtonMatrix(),
      ),
    ],
  );
}

enum _PreviewState {
  enabled(GdsButtonState.enabled, false),
  focused(GdsButtonState.focused, false),
  hovered(GdsButtonState.hovered, false),
  pressed(GdsButtonState.pressed, false),
  disabled(GdsButtonState.disabled, false),
  loading(GdsButtonState.enabled, true);

  const _PreviewState(this.buttonState, this.isLoading);
  final GdsButtonState buttonState;
  final bool isLoading;
}

enum _FormType { textOnly, iconRight, iconLeft }

class _RowEntry {
  final GdsTextButtonVariant variant;
  final GdsTextButtonSize size;
  final _FormType form;

  const _RowEntry(this.variant, this.size, this.form);

  String get label => '${variant.name} / ${size.name} / ${form.name}';
}

const _rows = [
  _RowEntry(GdsTextButtonVariant.primary, GdsTextButtonSize.large, _FormType.textOnly),
  _RowEntry(GdsTextButtonVariant.primary, GdsTextButtonSize.large, _FormType.iconRight),
  _RowEntry(GdsTextButtonVariant.primary, GdsTextButtonSize.large, _FormType.iconLeft),
  _RowEntry(GdsTextButtonVariant.primary, GdsTextButtonSize.regular, _FormType.textOnly),
  _RowEntry(GdsTextButtonVariant.primary, GdsTextButtonSize.regular, _FormType.iconRight),
  _RowEntry(GdsTextButtonVariant.primary, GdsTextButtonSize.regular, _FormType.iconLeft),
  _RowEntry(GdsTextButtonVariant.primary, GdsTextButtonSize.small, _FormType.textOnly),
  _RowEntry(GdsTextButtonVariant.primary, GdsTextButtonSize.small, _FormType.iconRight),
  _RowEntry(GdsTextButtonVariant.primary, GdsTextButtonSize.small, _FormType.iconLeft),
  _RowEntry(GdsTextButtonVariant.assistive, GdsTextButtonSize.large, _FormType.textOnly),
  _RowEntry(GdsTextButtonVariant.assistive, GdsTextButtonSize.large, _FormType.iconRight),
  _RowEntry(GdsTextButtonVariant.assistive, GdsTextButtonSize.large, _FormType.iconLeft),
  _RowEntry(GdsTextButtonVariant.assistive, GdsTextButtonSize.regular, _FormType.textOnly),
  _RowEntry(GdsTextButtonVariant.assistive, GdsTextButtonSize.regular, _FormType.iconRight),
  _RowEntry(GdsTextButtonVariant.assistive, GdsTextButtonSize.regular, _FormType.iconLeft),
  _RowEntry(GdsTextButtonVariant.assistive, GdsTextButtonSize.small, _FormType.textOnly),
  _RowEntry(GdsTextButtonVariant.assistive, GdsTextButtonSize.small, _FormType.iconRight),
  _RowEntry(GdsTextButtonVariant.assistive, GdsTextButtonSize.small, _FormType.iconLeft),
];

class _TextButtonMatrix extends StatelessWidget {
  const _TextButtonMatrix();

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final textStyle = GdsTypography.caption1.copyWith(color: colors.text.graySubtle);

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
      },
      children: [
        TableRow(
          children: [
            const SizedBox.shrink(),
            for (final state in _PreviewState.values)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Center(child: Text(state.name, style: textStyle)),
              ),
          ],
        ),
        for (final row in _rows)
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(row.label, style: textStyle),
              ),
              for (final state in _PreviewState.values)
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: Center(
                    child: _buildPreview(row.variant, row.size, state, row.form, context),
                  ),
                ),
            ],
          ),
      ],
    );
  }

  Widget _buildPreview(
    GdsTextButtonVariant variant,
    GdsTextButtonSize size,
    _PreviewState state,
    _FormType form,
    BuildContext context,
  ) {
    final colors = context.gdsColors;
    final buttonState = state.buttonState;
    final isLoading = state.isLoading;

    final Widget child;
    if (isLoading) {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GdsCircularLoading(
            width: size.iconSize,
            height: size.iconSize,
          ),
        ],
      );
    } else {
      final children = <Widget>[];

      if (form == _FormType.iconLeft) {
        children.add(
          GdsIcon.blank.build(
            color: variant.iconColor(colors, buttonState, size),
            width: size.iconSize,
            height: size.iconSize,
          ),
        );
        children.add(SizedBox(width: size.gap));
      }

      children.add(
        Text(
          'Label',
          style: size.textStyle.copyWith(color: variant.textColor(colors, buttonState, size)),
        ),
      );

      if (form == _FormType.iconRight) {
        children.add(SizedBox(width: size.gap));
        children.add(
          GdsIcon.blank.build(
            color: variant.iconColor(colors, buttonState, size),
            width: size.iconSize,
            height: size.iconSize,
          ),
        );
      }

      child = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: variant.backgroundColor(colors, buttonState, loading: isLoading),
        border: variant.border(colors, buttonState, loading: isLoading),
        borderRadius: BorderRadius.circular(GdsRadius.xs),
      ),
      child: child,
    );
  }
}
