import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

final TextEditingController _playgroundController = TextEditingController(text: 'Title');
final FocusNode _playgroundFocusNode = FocusNode();

@widgetbook.UseCase(
  name: 'default',
  type: GdsGroupSetting,
  path: '[component]/[group_settings]',
)
Widget buildGdsGroupSettingUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'GroupSetting',
    description: 'Select, Accordion, Dropdown 등의 선택창을 보여줄 때 사용됩니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final state = context.knobs.list<GdsGroupSettingState>(
    label: 'state',
    options: GdsGroupSettingState.values,
    initialOption: GdsGroupSettingState.enabled,
    labelBuilder: (value) => value.name,
  );

  return WidgetbookPlayground(
    layout: PlaygroundLayout.center,
    info: [
      'state: ${state.name}',
      'width: 343px @fixed',
      'height: 52px @fixed',
      'text: editable in preview',
    ],
    child: Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: 343,
        child: _InteractiveGroupSetting(
          key: const ValueKey('interactive-group-setting'),
          state: state,
        ),
      ),
    ),
  );
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'GroupSetting',
    children: [
      WidgetbookSubsection(
        title: 'state',
        labels: const ['Enabled', 'Pressed', 'Delete', 'EditDelete', 'Disabled'],
        content: const _GroupSettingStateList(),
      ),
    ],
  );
}

class _GroupSettingStateList extends StatelessWidget {
  const _GroupSettingStateList();

  static const List<GdsGroupSettingState> _states = [
    GdsGroupSettingState.enabled,
    GdsGroupSettingState.pressed,
    GdsGroupSettingState.delete,
    GdsGroupSettingState.editDelete,
    GdsGroupSettingState.disabled,
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final headerStyle = GdsTypography.caption1.copyWith(color: colors.text.graySubtle);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final state in _states)
          Padding(
            padding: const EdgeInsets.only(bottom: GdsSpacing.spacing16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 88,
                  child: Text(_labelOf(state), style: headerStyle),
                ),
                const SizedBox(width: GdsSpacing.spacing16),
                SizedBox(
                  width: 343,
                  child: _GroupSettingPreviewHost(state: state),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _GroupSettingPreviewHost extends StatelessWidget {
  const _GroupSettingPreviewHost({required this.state});

  final GdsGroupSettingState state;

  @override
  Widget build(BuildContext context) {
    return GdsGroupSetting(
      text: 'Title',
      state: state,
      onTap: () => debugPrint('GdsGroupSetting tapped'),
      onEditTap: () => debugPrint('GdsGroupSetting edit tapped'),
    );
  }
}

class _InteractiveGroupSetting extends StatefulWidget {
  const _InteractiveGroupSetting({required this.state, super.key});

  final GdsGroupSettingState state;

  @override
  State<_InteractiveGroupSetting> createState() => _InteractiveGroupSettingState();
}

class _InteractiveGroupSettingState extends State<_InteractiveGroupSetting> {
  @override
  Widget build(BuildContext context) {
    return GdsGroupSetting(
      text: _playgroundController.text,
      state: widget.state,
      controller: _playgroundController,
      focusNode: _playgroundFocusNode,
      onTap: () => debugPrint('GdsGroupSetting tapped'),
      onEditTap: () {
        _playgroundFocusNode.requestFocus();
        debugPrint('GdsGroupSetting edit tapped');
      },
      onChanged: (_) => setState(() {}),
    );
  }
}

String _labelOf(GdsGroupSettingState state) => switch (state) {
  GdsGroupSettingState.enabled => 'Enabled',
  GdsGroupSettingState.pressed => 'Pressed',
  GdsGroupSettingState.delete => 'Delete',
  GdsGroupSettingState.editDelete => 'EditDelete',
  GdsGroupSettingState.disabled => 'Disabled',
};
