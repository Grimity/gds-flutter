import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(
  name: 'default',
  type: GdsSolidButton,
  path: '[component]/[button]/',
)
Widget buildGdsSolidButtonUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'SolidButton',
    description: '배경색이 채워진 형태의 버튼으로, 강조해야 할 주요 액션에 사용합니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final size = context.knobs.list<GdsSolidButtonSize>(
    label: 'size',
    options: GdsSolidButtonSize.values,
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

  final Widget button = switch (form) {
    'IconOnly' => GdsSolidButton.icon(
      icon: icon,
      size: size,
      enabled: enabled,
      loading: loading,
      expanded: expanded,
      onPressed: () => debugPrint('GdsSolidButton tapped'),
    ),
    'IconLeft' => GdsSolidButton(
      text: 'Label',
      leadingIcon: icon,
      size: size,
      enabled: enabled,
      loading: loading,
      expanded: expanded,
      onPressed: () => debugPrint('GdsSolidButton tapped'),
    ),
    'IconRight' => GdsSolidButton(
      text: 'Label',
      trailingIcon: icon,
      size: size,
      enabled: enabled,
      loading: loading,
      expanded: expanded,
      onPressed: () => debugPrint('GdsSolidButton tapped'),
    ),
    _ => GdsSolidButton(
      text: 'Label',
      size: size,
      enabled: enabled,
      loading: loading,
      expanded: expanded,
      onPressed: () => debugPrint('GdsSolidButton tapped'),
    ),
  };

  return WidgetbookPlayground(
    info: [
      'size: ${size.name}',
      'form: $form',
      'enabled: $enabled',
      'loading: $loading',
      'expanded: $expanded',
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
    title: 'SolidButton',
    children: [
      WidgetbookSubsection(
        title: '(size × form) × state',
        labels: ['3 sizes', '4 forms', '6 states'],
        content: const _SolidButtonMatrix(),
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
  final GdsSolidButtonSize size;
  final _FormType form;

  const _RowEntry(this.size, this.form);

  String get label => '${size.name} / ${form.name}';
}

const _rows = [
  _RowEntry(GdsSolidButtonSize.large, _FormType.iconOnly),
  _RowEntry(GdsSolidButtonSize.large, _FormType.textOnly),
  _RowEntry(GdsSolidButtonSize.large, _FormType.iconRight),
  _RowEntry(GdsSolidButtonSize.large, _FormType.iconLeft),
  _RowEntry(GdsSolidButtonSize.regular, _FormType.iconOnly),
  _RowEntry(GdsSolidButtonSize.regular, _FormType.textOnly),
  _RowEntry(GdsSolidButtonSize.regular, _FormType.iconRight),
  _RowEntry(GdsSolidButtonSize.regular, _FormType.iconLeft),
  _RowEntry(GdsSolidButtonSize.small, _FormType.iconOnly),
  _RowEntry(GdsSolidButtonSize.small, _FormType.textOnly),
  _RowEntry(GdsSolidButtonSize.small, _FormType.iconRight),
  _RowEntry(GdsSolidButtonSize.small, _FormType.iconLeft),
];

class _SolidButtonMatrix extends StatelessWidget {
  const _SolidButtonMatrix();

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
    GdsSolidButtonSize size,
    _PreviewState state,
    _FormType form,
    BuildContext context,
  ) {
    final colors = context.gdsColors;
    final buttonState = state.buttonState;
    final isLoading = state.isLoading;

    final isIconOnly = form == _FormType.iconOnly;
    final padding = GdsSolidButtonStyle.padding(
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
        color: GdsSolidButtonStyle.iconColor(colors, buttonState),
        width: size.iconSize,
        height: size.iconSize,
      );
    } else {
      final children = <Widget>[];

      if (form == _FormType.iconLeft) {
        children.add(
          GdsIcon.blank.build(
            color: GdsSolidButtonStyle.iconColor(colors, buttonState),
            width: size.iconSize,
            height: size.iconSize,
          ),
        );
        children.add(SizedBox(width: size.gap));
      }

      children.add(
        Text(
          'Label',
          style: size.textStyle.copyWith(color: GdsSolidButtonStyle.textColor(colors, buttonState)),
        ),
      );

      if (form == _FormType.iconRight) {
        children.add(SizedBox(width: size.gap));
        children.add(
          GdsIcon.blank.build(
            color: GdsSolidButtonStyle.iconColor(colors, buttonState),
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
        color: GdsSolidButtonStyle.backgroundColor(colors, buttonState, loading: isLoading),
        border: GdsSolidButtonStyle.border(colors, buttonState, loading: isLoading),
        borderRadius: BorderRadius.circular(GdsRadius.sm),
      ),
      padding: padding,
      child: child,
    );
  }
}
