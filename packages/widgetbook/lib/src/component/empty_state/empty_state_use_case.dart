import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

const _description = '상황에 대한 설명이 들어가요.\n설명은 최대 2줄까지만 작성해요.';

@widgetbook.UseCase(
  name: 'default',
  type: GdsEmptyState,
  path: '[component]/[empty_state]',
)
Widget buildGdsEmptyStateUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'EmptyState',
    description: '일러스트, 제목, 설명, 액션 버튼 조합으로 비어 있는 상태를 표현하는 컴포넌트입니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final size = context.knobs.list<GdsEmptyStateSize>(
    label: 'size',
    options: GdsEmptyStateSize.values,
    initialOption: GdsEmptyStateSize.xl,
    labelBuilder: (value) => value.name,
  );

  final showDescription = context.knobs.boolean(
    label: 'showDescription',
    initialValue: true,
  );
  final actionType = context.knobs.list<_ActionType>(
    label: 'actionType',
    options: _ActionType.values,
    initialOption: _ActionType.none,
    labelBuilder: (value) => value.name,
  );

  return WidgetbookPlayground(
    info: [
      'size: ${size.name}',
      'titleStyle: ${size.titleStyleLabel}',
      'descriptionStyle: ${size.descriptionStyleLabel}',
      'showDescription: $showDescription',
      'actionType: ${actionType.name}',
    ],
    child: GdsEmptyState(
      size: size,
      title: 'Title',
      description: showDescription ? _description : null,
      action: _buildAction(actionType, size: size),
    ),
  );
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'EmptyState',
    children: const [
      WidgetbookSubsection(
        title: 'composition × size',
        labels: ['4 compositions', '2 sizes'],
        content: _EmptyStateMatrix(),
      ),
    ],
  );
}

extension on GdsEmptyStateSize {
  String get titleStyleLabel => switch (this) {
    GdsEmptyStateSize.xl => 'title3',
    GdsEmptyStateSize.md => 'subtitle1',
  };

  String get descriptionStyleLabel => switch (this) {
    GdsEmptyStateSize.xl => 'body1R',
    GdsEmptyStateSize.md => 'body2R',
  };

  GdsSolidButtonSize get solidButtonSize => switch (this) {
    GdsEmptyStateSize.xl => GdsSolidButtonSize.large,
    GdsEmptyStateSize.md => GdsSolidButtonSize.regular,
  };

  GdsTextButtonSize get textButtonSize => switch (this) {
    GdsEmptyStateSize.xl => GdsTextButtonSize.large,
    GdsEmptyStateSize.md => GdsTextButtonSize.regular,
  };
}

enum _ActionType { none, solid, outline }

enum _CompositionType { title, content, solid, outline }

class _EmptyStateMatrix extends StatelessWidget {
  const _EmptyStateMatrix();

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final columnLabelStyle = GdsTypography.caption1.copyWith(color: colors.text.graySubtle);
    final typographyLabelStyle = GdsTypography.label5.copyWith(color: colors.text.graySubtler);
    final rowLabelStyle = GdsTypography.caption1.copyWith(color: colors.text.graySubtle);

    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: FixedColumnWidth(220),
        2: FixedColumnWidth(180),
      },
      children: [
        TableRow(
          children: [
            const SizedBox.shrink(),
            _HeaderCell(
              label: 'xl',
              style: columnLabelStyle,
              sublabel: '${GdsEmptyStateSize.xl.titleStyleLabel} / ${GdsEmptyStateSize.xl.descriptionStyleLabel}',
              sublabelStyle: typographyLabelStyle,
            ),
            _HeaderCell(
              label: 'md',
              style: columnLabelStyle,
              sublabel: '${GdsEmptyStateSize.md.titleStyleLabel} / ${GdsEmptyStateSize.md.descriptionStyleLabel}',
              sublabelStyle: typographyLabelStyle,
            ),
          ],
        ),
        for (final composition in _CompositionType.values)
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24, right: 24),
                child: Text(_labelOf(composition), style: rowLabelStyle),
              ),
              _PreviewCell(
                child: _buildPreview(
                  size: GdsEmptyStateSize.xl,
                  composition: composition,
                ),
              ),
              _PreviewCell(
                child: _buildPreview(
                  size: GdsEmptyStateSize.md,
                  composition: composition,
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildPreview({
    required GdsEmptyStateSize size,
    required _CompositionType composition,
  }) {
    final description = switch (composition) {
      _CompositionType.title => null,
      _CompositionType.content || _CompositionType.solid || _CompositionType.outline => _description,
    };

    final action = switch (composition) {
      _CompositionType.solid => _buildAction(_ActionType.solid, size: size),
      _CompositionType.outline => _buildAction(_ActionType.outline, size: size),
      _CompositionType.title || _CompositionType.content => null,
    };

    return GdsEmptyState(
      size: size,
      title: 'Title',
      description: description,
      action: action,
    );
  }
}

class _HeaderCell extends StatelessWidget {
  const _HeaderCell({
    required this.label,
    required this.style,
    this.sublabel,
    this.sublabelStyle,
  });

  final String label;
  final TextStyle style;
  final String? sublabel;
  final TextStyle? sublabelStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: style),
            if (sublabel != null && sublabelStyle != null) ...[
              const SizedBox(height: 4),
              Text(sublabel!, style: sublabelStyle, textAlign: TextAlign.center),
            ],
          ],
        ),
      ),
    );
  }
}

class _PreviewCell extends StatelessWidget {
  const _PreviewCell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, right: 16),
      child: Center(child: child),
    );
  }
}

Widget? _buildAction(_ActionType type, {required GdsEmptyStateSize size}) {
  return switch (type) {
    _ActionType.none => null,
    _ActionType.solid => GdsSolidButton(
      text: 'label',
      size: size.solidButtonSize,
      onPressed: () {},
    ),
    _ActionType.outline => GdsTextButton(
      text: 'Label',
      size: size.textButtonSize,
      onPressed: () {},
    ),
  };
}

String _labelOf(_CompositionType composition) => switch (composition) {
  _CompositionType.title => 'Title',
  _CompositionType.content => 'Content',
  _CompositionType.solid => 'Solid',
  _CompositionType.outline => 'Outline',
};
