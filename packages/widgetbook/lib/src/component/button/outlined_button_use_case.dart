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
  type: GdsOutlinedButton,
  path: '[component]/[button]/',
)
Widget buildGdsOutlinedButtonUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'OutlinedButton',
    description: '테두리만 있는 형태의 버튼으로, 보조 액션에 사용합니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final size = context.knobs.list<GdsOutlinedButtonSize>(
    label: 'size',
    options: GdsOutlinedButtonSize.values,
    labelBuilder: (s) => s.name,
  );

  final form = context.knobs.list<String>(
    label: 'form',
    options: ['Default', 'IconOnly', 'IconLeft', 'IconRight'],
  );

  final enabled = context.knobs.boolean(label: 'enabled', initialValue: true);
  final loading = context.knobs.boolean(label: 'loading', initialValue: false);
  final expanded = context.knobs.boolean(label: 'expanded', initialValue: false);

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
    'IconOnly' => GdsOutlinedButton.icon(
      icon: icon,
      iconColor: iconColor,
      size: size,
      enabled: enabled,
      loading: loading,
      expanded: expanded,
      onPressed: () => debugPrint('GdsOutlinedButton tapped'),
    ),
    'IconLeft' => GdsOutlinedButton(
      text: 'Label',
      leadingIcon: icon,
      iconColor: iconColor,
      size: size,
      enabled: enabled,
      loading: loading,
      expanded: expanded,
      onPressed: () => debugPrint('GdsOutlinedButton tapped'),
    ),
    'IconRight' => GdsOutlinedButton(
      text: 'Label',
      trailingIcon: icon,
      iconColor: iconColor,
      size: size,
      enabled: enabled,
      loading: loading,
      expanded: expanded,
      onPressed: () => debugPrint('GdsOutlinedButton tapped'),
    ),
    _ => GdsOutlinedButton(
      text: 'Label',
      iconColor: iconColor,
      size: size,
      enabled: enabled,
      loading: loading,
      expanded: expanded,
      onPressed: () => debugPrint('GdsOutlinedButton tapped'),
    ),
  };

  return WidgetbookPlayground(
    info: [
      'size: ${size.name}',
      'form: $form',
      'enabled: $enabled',
      'loading: $loading',
      'expanded: $expanded',
      'iconColorMode: ${iconColorMode.name}',
      if (customIconColor != null) 'customIconColor: ${_toHex(customIconColor)}',
      'verticalPadding: ${size.verticalPadding.toInt()}px @fixed',
      'iconSize: ${size.iconSize.toInt()}px @fixed',
      'gap: ${size.gap.toInt()}px @fixed',
      'radius: sm (8px) @fixed',
    ],
    child: button,
  );
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'OutlinedButton',
    children: [
      WidgetbookSubsection(
        title: '(size × form) × state',
        labels: ['3 sizes', '4 forms', '6 states'],
        content: const _OutlinedButtonMatrix(),
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

enum _FormType { iconOnly, textOnly, iconRight, iconLeft }

class _RowEntry {
  final GdsOutlinedButtonSize size;
  final _FormType form;

  const _RowEntry(this.size, this.form);

  String get label => '${size.name} / ${form.name}';
}

const _rows = [
  _RowEntry(GdsOutlinedButtonSize.large, _FormType.iconOnly),
  _RowEntry(GdsOutlinedButtonSize.large, _FormType.textOnly),
  _RowEntry(GdsOutlinedButtonSize.large, _FormType.iconRight),
  _RowEntry(GdsOutlinedButtonSize.large, _FormType.iconLeft),
  _RowEntry(GdsOutlinedButtonSize.regular, _FormType.iconOnly),
  _RowEntry(GdsOutlinedButtonSize.regular, _FormType.textOnly),
  _RowEntry(GdsOutlinedButtonSize.regular, _FormType.iconRight),
  _RowEntry(GdsOutlinedButtonSize.regular, _FormType.iconLeft),
  _RowEntry(GdsOutlinedButtonSize.small, _FormType.iconOnly),
  _RowEntry(GdsOutlinedButtonSize.small, _FormType.textOnly),
  _RowEntry(GdsOutlinedButtonSize.small, _FormType.iconRight),
  _RowEntry(GdsOutlinedButtonSize.small, _FormType.iconLeft),
];

class _OutlinedButtonMatrix extends StatelessWidget {
  const _OutlinedButtonMatrix();

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
                    child: _buildPreview(row.size, state, row.form, context),
                  ),
                ),
            ],
          ),
      ],
    );
  }

  Widget _buildPreview(
    GdsOutlinedButtonSize size,
    _PreviewState state,
    _FormType form,
    BuildContext context,
  ) {
    final colors = context.gdsColors;
    final buttonState = state.buttonState;
    final isLoading = state.isLoading;

    final isIconOnly = form == _FormType.iconOnly;
    final padding = GdsOutlinedButtonStyle.padding(
      size,
      isIconOnly: isIconOnly,
      loading: isLoading,
      hasLeadingIcon: form == _FormType.iconLeft,
      hasTrailingIcon: form == _FormType.iconRight,
    );

    final Widget child;
    if (isLoading) {
      final loading = GdsCircularLoading(
        width: size.iconSize,
        height: size.iconSize,
      );
      child = isIconOnly
          ? loading
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [loading],
            );
    } else if (isIconOnly) {
      child = GdsIcon.blank.build(
        color: GdsOutlinedButtonStyle.iconColor(colors, buttonState),
        width: size.iconSize,
        height: size.iconSize,
      );
    } else {
      final children = <Widget>[];

      if (form == _FormType.iconLeft) {
        children.add(
          GdsIcon.blank.build(
            color: GdsOutlinedButtonStyle.iconColor(colors, buttonState),
            width: size.iconSize,
            height: size.iconSize,
          ),
        );
        children.add(SizedBox(width: size.gap));
      }

      children.add(
        Text(
          'Label',
          style: size.textStyle.copyWith(color: GdsOutlinedButtonStyle.textColor(colors, buttonState)),
        ),
      );

      if (form == _FormType.iconRight) {
        children.add(SizedBox(width: size.gap));
        children.add(
          GdsIcon.blank.build(
            color: GdsOutlinedButtonStyle.iconColor(colors, buttonState),
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
        color: GdsOutlinedButtonStyle.backgroundColor(colors, buttonState, loading: isLoading),
        border: GdsOutlinedButtonStyle.border(colors, buttonState, loading: isLoading),
        borderRadius: BorderRadius.circular(GdsRadius.sm),
      ),
      padding: padding,
      child: child,
    );
  }
}
