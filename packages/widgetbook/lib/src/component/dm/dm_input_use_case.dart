import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(
  name: 'input',
  type: GdsDmInput,
  path: '[component]/[dm]/',
)
Widget buildGdsDmInputUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'DM Input',
    description: 'DM 입력 영역 컴포넌트입니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final enabled = context.knobs.boolean(label: 'enabled', initialValue: true);
  final answer = context.knobs.boolean(label: 'answer', initialValue: false);

  return WidgetbookPlayground(
    info: [
      'enabled: $enabled',
      'answer: $answer',
    ],
    child: SizedBox(
      width: 375,
      child: _PlaygroundDmInput(
        enabled: enabled,
        replyUser: answer ? 'user' : null,
        previewText: answer ? '감사합니다. 이 부분도 1줄만 노출되고 길게 나오면 말줄임표를 해주세요.' : null,
      ),
    ),
  );
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'DM Input',
    children: [
      WidgetbookSubsection(
        title: 'state',
        labels: const ['Enabled', 'Focused', 'Filled', 'Filled 4 lines', 'Disabled', 'Answer'],
        content: const _DmInputMatrix(),
      ),
    ],
  );
}

enum _DmInputPreviewState {
  enabled(text: null, autoFocus: false, enabledValue: true),
  focused(text: '아 네!', autoFocus: true, enabledValue: true),
  filled(text: '아 네! ㅎㅎ 감사합니다', autoFocus: false, enabledValue: true),
  filled4Lines(
    text:
        '감사합니다. 이 부분도 1줄만 노출되고 길게 나오면 말줄임표를 해주세요. '
        '이 부분도 1줄만 노출됩니다~ 감사합니다. 이 부분도 1줄만 노출되고 길게 나오면 말줄임표를 해주세요. '
        '이 부분도 1줄만 노출됩니다~',
    autoFocus: false,
    enabledValue: true,
  ),
  disabled(text: null, autoFocus: false, enabledValue: false),
  answer(
    text: null,
    autoFocus: false,
    enabledValue: true,
    replyUser: 'user',
    previewText: '감사합니다. 이 부분도 1줄만 노출되고 길게 나오면 말줄임표를 해주세요.',
  );

  const _DmInputPreviewState({
    required this.text,
    required this.autoFocus,
    required this.enabledValue,
    this.replyUser,
    this.previewText,
  });

  final String? text;
  final bool autoFocus;
  final bool enabledValue;
  final String? replyUser;
  final String? previewText;
}

class _PlaygroundDmInput extends StatefulWidget {
  const _PlaygroundDmInput({
    required this.enabled,
    this.initialText,
    this.autoFocus = false,
    this.replyUser,
    this.previewText,
  });

  final bool enabled;
  final String? initialText;
  final bool autoFocus;
  final String? replyUser;
  final String? previewText;

  @override
  State<_PlaygroundDmInput> createState() => _PlaygroundDmInputState();
}

class _PlaygroundDmInputState extends State<_PlaygroundDmInput> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText ?? '');
    _focusNode = FocusNode();
    _syncFocus();
  }

  @override
  void didUpdateWidget(covariant _PlaygroundDmInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialText != widget.initialText) {
      final nextText = widget.initialText ?? '';
      _controller.value = TextEditingValue(
        text: nextText,
        selection: TextSelection.collapsed(offset: nextText.length),
      );
    }

    if (oldWidget.autoFocus != widget.autoFocus) {
      _syncFocus();
    }
  }

  void _syncFocus() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      if (widget.autoFocus) {
        _focusNode.requestFocus();
      } else {
        _focusNode.unfocus();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.replyUser != null && widget.previewText != null) {
      return GdsDmInput.answer(
        enabled: widget.enabled,
        controller: _controller,
        focusNode: _focusNode,
        replyUser: widget.replyUser!,
        previewText: widget.previewText!,
        onCameraPressed: () {
          debugPrint('onCameraPressed');
        },
        onButtonPressed: () {
          debugPrint('onButtonPressed');
        },
      );
    }

    return GdsDmInput(
      enabled: widget.enabled,
      controller: _controller,
      focusNode: _focusNode,
      onCameraPressed: () {
        debugPrint('onCameraPressed');
      },
      onButtonPressed: () {
        debugPrint('onButtonPressed');
      },
    );
  }
}

class _DmInputMatrix extends StatelessWidget {
  const _DmInputMatrix();

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final labelStyle = GdsTypography.caption1.copyWith(
      color: colors.text.graySubtle,
    );

    const states = [
      (label: 'Enabled', state: _DmInputPreviewState.enabled),
      (label: 'Focused', state: _DmInputPreviewState.focused),
      (label: 'Filled', state: _DmInputPreviewState.filled),
      (label: 'Filled_log', state: _DmInputPreviewState.filled4Lines),
      (label: 'Disabled', state: _DmInputPreviewState.disabled),
      (label: 'Answer', state: _DmInputPreviewState.answer),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final item in states)
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(item.label, style: labelStyle),
                ),
                SizedBox(
                  width: 375,
                  child: _PlaygroundDmInput(
                    enabled: item.state.enabledValue,
                    initialText: item.state.text,
                    autoFocus: item.state.autoFocus,
                    replyUser: item.state.replyUser,
                    previewText: item.state.previewText,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
