import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(name: 'default', type: GdsTagSelect, path: '[component]/[tag]')
Widget buildGdsTagSelectUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Tag Select',
    description:
        '태그를 추가/삭제하는 입력 컴포넌트입니다.\n'
        'Size md/xs와 Enabled/Filled/Focused/Full 상태를 제공합니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final size = context.knobs.list<GdsTagSelectSize>(
    label: 'size',
    options: GdsTagSelectSize.values,
    labelBuilder: (value) => value.name,
  );

  return WidgetbookPlayground(
    info: [
      'size: ${size.name}',
    ],
    child: _InteractiveTagSelect(
      key: ValueKey(size),
      size: size,
    ),
  );
}

class _InteractiveTagSelect extends StatefulWidget {
  const _InteractiveTagSelect({
    super.key,
    required this.size,
  });

  final GdsTagSelectSize size;

  @override
  State<_InteractiveTagSelect> createState() => _InteractiveTagSelectState();
}

class _InteractiveTagSelectState extends State<_InteractiveTagSelect> {
  static const int _maxTagCount = 10;

  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  late List<String> _tags;

  double get _previewWidth => _tags.length >= _maxTagCount ? 390 : 370;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _tags = <String>[];
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSubmitted(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty || _tags.length >= _maxTagCount) return;

    setState(() {
      _tags = [..._tags, trimmed];
    });
  }

  void _handleRemoveTag(int index, String _) {
    setState(() {
      _tags = [..._tags]..removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _previewWidth,
      child: _buildTagSelect(
        size: widget.size,
        tags: _tags,
        controller: _controller,
        focusNode: _focusNode,
        onSubmitted: _handleSubmitted,
        onTagRemove: _handleRemoveTag,
      ),
    );
  }
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'Tag Select',
    children: [
      WidgetbookSubsection(
        title: 'state × size',
        labels: ['4 states', '2 sizes'],
        content: const _TagSelectMatrix(),
      ),
    ],
  );
}

enum _PreviewState {
  enabled('State=Enabled'),
  filled('State=Filled'),
  focused('State=Focused'),
  full('State=Full');

  const _PreviewState(this.label);

  final String label;

  double get width => switch (this) {
    _PreviewState.full => 390,
    _ => 370,
  };

  String? get draft => switch (this) {
    _PreviewState.focused => '태',
    _ => null,
  };

  List<String> get tags => switch (this) {
    _PreviewState.enabled => const [],
    _PreviewState.filled || _PreviewState.focused => const ['태그', '태그', '태그'],
    _PreviewState.full => List<String>.filled(10, '태그'),
  };
}

class _TagSelectMatrix extends StatelessWidget {
  const _TagSelectMatrix();

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
            for (final size in GdsTagSelectSize.values)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Size=${_sizeLabel(size)}', style: headerStyle),
                  ),
                ),
              ),
          ],
        ),
        for (final state in _PreviewState.values)
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(state.label, style: headerStyle),
              ),
              for (final size in GdsTagSelectSize.values)
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: state.width,
                      child: _PreviewTagSelect(
                        size: size,
                        state: state,
                      ),
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}

class _PreviewTagSelect extends StatelessWidget {
  const _PreviewTagSelect({
    required this.size,
    required this.state,
  });

  final GdsTagSelectSize size;
  final _PreviewState state;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: _StaticTagSelectPreview(
        size: size,
        state: state,
        tags: state.tags,
        draft: state.draft,
      ),
    );
  }
}

String _sizeLabel(GdsTagSelectSize size) => switch (size) {
  GdsTagSelectSize.medium => 'md',
  GdsTagSelectSize.small => 'xs',
};

Widget _buildTagSelect({
  required GdsTagSelectSize size,
  required List<String> tags,
  TextEditingController? controller,
  FocusNode? focusNode,
  ValueChanged<String>? onSubmitted,
  void Function(int index, String tag)? onTagRemove,
}) => switch (size) {
  GdsTagSelectSize.medium => GdsTagSelect.medium(
    tags: tags,
    controller: controller,
    focusNode: focusNode,
    onSubmitted: onSubmitted,
    onTagRemove: onTagRemove,
  ),
  GdsTagSelectSize.small => GdsTagSelect.small(
    tags: tags,
    controller: controller,
    focusNode: focusNode,
    onSubmitted: onSubmitted,
    onTagRemove: onTagRemove,
  ),
};

class _StaticTagSelectPreview extends StatelessWidget {
  const _StaticTagSelectPreview({
    required this.size,
    required this.state,
    required this.tags,
    required this.draft,
  });

  final GdsTagSelectSize size;
  final _PreviewState state;
  final List<String> tags;
  final String? draft;

  bool get _showPlaceholder => state == _PreviewState.enabled || state == _PreviewState.filled;
  bool get _showDraft => state == _PreviewState.focused;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(GdsRadius.sm),
        border: Border.all(color: colors.border.graySubtler),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: size.minHeight),
        child: Padding(
          padding: size.padding,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                for (final tag in tags) _buildTag(tag),
                if (_showPlaceholder) _buildPlaceholder(context),
                if (_showDraft) _buildDraft(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String label) {
    return GdsTag.icon(
      text: label,
      icon: GdsIcon.xMark,
      size: size.tagSize,
      state: GdsTagState.enabled,
      onTap: () {},
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    final colors = context.gdsColors;

    return Text(
      '#태그 추가',
      style: GdsTypography.label4.copyWith(color: colors.text.graySubtle),
    );
  }

  Widget _buildDraft(BuildContext context) {
    final colors = context.gdsColors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '#',
          style: GdsTypography.label4.copyWith(color: colors.text.graySubtle),
        ),
        Text(
          draft ?? '',
          style: GdsTypography.label4.copyWith(color: colors.text.grayBold),
        ),
        Container(
          width: 1,
          height: 16,
          margin: const EdgeInsets.only(left: 1),
          color: colors.status.info,
        ),
      ],
    );
  }
}
