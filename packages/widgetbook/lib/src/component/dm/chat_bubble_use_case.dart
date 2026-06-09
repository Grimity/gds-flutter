import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

const _sampleImageUrl = 'https://picsum.photos/seed/gds-chat-bubble/300/180';

@widgetbook.UseCase(
  name: 'chat bubble',
  type: GdsChatBubble,
  path: '[component]/[dm]/',
)
Widget buildGdsChatBubbleUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Chat Bubble',
    description: 'DM 채팅 버블 컴포넌트입니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final type = context.knobs.list<GdsChatMessageType>(
    label: 'type',
    options: GdsChatMessageType.values,
    initialOption: GdsChatMessageType.other,
    labelBuilder: (value) => value.name,
  );
  final content = context.knobs.stringOrNull(
    label: 'content',
    initialValue: '안녕하세요!',
  );
  final showImage = context.knobs.boolean(label: 'showImage', initialValue: false);
  final imageUrl = showImage
      ? context.knobs.string(
          label: 'imageUrl',
          initialValue: _sampleImageUrl,
        )
      : null;
  final isLiked = context.knobs.boolean(label: 'isLiked', initialValue: false);
  final isSending = context.knobs.boolean(label: 'isSending', initialValue: false);
  final showReplyPreview = context.knobs.boolean(label: 'showReplyPreview', initialValue: false);

  final replyType = showReplyPreview
      ? context.knobs.list<GdsChatMessageType>(
          label: 'replyType',
          options: GdsChatMessageType.values,
          initialOption: GdsChatMessageType.other,
          labelBuilder: (value) => value.name,
        )
      : null;
  final replyLabel = showReplyPreview
      ? context.knobs.string(
          label: 'replyLabel',
          initialValue: '[user]님에게 답장',
        )
      : null;
  final replyContent = showReplyPreview
      ? context.knobs.string(
          label: 'replyContent',
          initialValue: '원본 메시지 미리보기입니다.',
        )
      : null;

  final replyPreviewData = showReplyPreview && replyType != null && replyLabel != null && replyContent != null
      ? GdsChatReplyPreviewData(
          replyType: replyType,
          replyLabel: replyLabel,
          content: replyContent,
        )
      : null;

  return WidgetbookPlayground(
    info: [
      'type: ${type.name}',
      'content: ${content == null ? "null" : "set"}',
      'image: ${imageUrl == null ? "none" : "set"}',
      'liked: $isLiked',
      'sending: $isSending',
      'replyPreview: $showReplyPreview',
    ],
    child: Container(
      constraints: BoxConstraints(
        maxWidth: 337,
      ),
      color: context.gdsColors.surface.graySubtlest,
      padding: const EdgeInsets.symmetric(
        horizontal: GdsSpacing.spacing16,
        vertical: GdsSpacing.spacing24,
      ),
      child: _PlaygroundChatBubble(
        type: type,
        content: content,
        imageUrl: imageUrl,
        initialIsLiked: isLiked,
        isSending: isSending,
        replyPreviewData: replyPreviewData,
      ),
    ),
  );
}

class _PlaygroundChatBubble extends StatefulWidget {
  const _PlaygroundChatBubble({
    required this.type,
    required this.content,
    required this.imageUrl,
    required this.initialIsLiked,
    required this.isSending,
    required this.replyPreviewData,
  });

  final GdsChatMessageType type;
  final String? content;
  final String? imageUrl;
  final bool initialIsLiked;
  final bool isSending;
  final GdsChatReplyPreviewData? replyPreviewData;

  @override
  State<_PlaygroundChatBubble> createState() => _PlaygroundChatBubbleState();
}

class _PlaygroundChatBubbleState extends State<_PlaygroundChatBubble> {
  late bool _isLiked;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.initialIsLiked;
  }

  @override
  void didUpdateWidget(covariant _PlaygroundChatBubble oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialIsLiked != widget.initialIsLiked) {
      _isLiked = widget.initialIsLiked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GdsChatBubble(
      type: widget.type,
      content: widget.content,
      imageUrl: widget.imageUrl,
      isLiked: _isLiked,
      isSending: widget.isSending,
      onImageTap: widget.imageUrl != null
          ? () {
              debugPrint('GdsChatBubble.onImageTap');
            }
          : null,
      replyPreviewData: widget.replyPreviewData,
    );
  }
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'Chat Bubble',
    children: const [
      WidgetbookSubsection(
        title: 'other state',
        labels: ['Default', 'Send', 'Heart', 'Image', 'Reply Preview'],
        content: _OtherChatBubbleMatrix(),
      ),
      WidgetbookSubsection(
        title: 'me state',
        labels: ['Default', 'Send', 'Heart', 'Image', 'Reply Preview'],
        content: _MeChatBubbleMatrix(),
      ),
      WidgetbookSubsection(
        title: 'interaction',
        labels: ['Long Press'],
        content: _OtherChatBubbleInteractionExamples(),
      ),
    ],
  );
}

class _OtherChatBubbleMatrix extends StatelessWidget {
  const _OtherChatBubbleMatrix();

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final labelStyle = GdsTypography.caption1.copyWith(
      color: colors.text.graySubtle,
    );

    const items = [
      (label: 'Default', child: GdsChatBubble(type: GdsChatMessageType.other, content: 'Hello', imageUrl: null)),
      (
        label: 'Send',
        child: GdsChatBubble(
          type: GdsChatMessageType.other,
          content: '안녕하세요!',
          imageUrl: null,
          isSending: true,
        ),
      ),
      (
        label: 'Heart',
        child: GdsChatBubble(
          type: GdsChatMessageType.other,
          content: '좋아요가 눌린 상태예요.',
          imageUrl: null,
          isLiked: true,
        ),
      ),
      (
        label: 'Image',
        child: GdsChatBubble(
          type: GdsChatMessageType.other,
          content: null,
          imageUrl: _sampleImageUrl,
        ),
      ),
      (
        label: 'Reply Preview',
        child: GdsChatBubble(
          type: GdsChatMessageType.other,
          content: '답장 미리보기가 있는 상태예요.',
          imageUrl: null,
          replyPreviewData: GdsChatReplyPreviewData(
            replyType: GdsChatMessageType.other,
            replyLabel: '[user]님에게 답장',
            content: '원본 메시지 미리보기입니다.',
          ),
        ),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final item in items)
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
                _DemoCanvas(
                  child: item.child,
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _OtherChatBubbleInteractionExamples extends StatelessWidget {
  const _OtherChatBubbleInteractionExamples();

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final helperStyle = GdsTypography.caption1.copyWith(
      color: colors.text.graySubtle,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text('Long Press', style: helperStyle),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text('버블을 길게 눌러 Heart 액션을 확인하세요.', style: helperStyle),
              ),
              _DemoCanvas(
                child: GdsChatBubble(
                  type: GdsChatMessageType.other,
                  content: '길게 눌러 상태를 확인하세요.',
                  imageUrl: null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MeChatBubbleMatrix extends StatelessWidget {
  const _MeChatBubbleMatrix();

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final labelStyle = GdsTypography.caption1.copyWith(
      color: colors.text.graySubtle,
    );

    const items = [
      (label: 'Default', child: GdsChatBubble(type: GdsChatMessageType.me, content: 'Hello', imageUrl: null)),
      (
        label: 'Send',
        child: GdsChatBubble(
          type: GdsChatMessageType.me,
          content: '안녕하세요!',
          imageUrl: null,
          isSending: true,
        ),
      ),
      (
        label: 'Heart',
        child: GdsChatBubble(
          type: GdsChatMessageType.me,
          content: '좋아요가 눌린 상태예요.',
          imageUrl: null,
          isLiked: true,
        ),
      ),
      (
        label: 'Image',
        child: GdsChatBubble(
          type: GdsChatMessageType.me,
          content: null,
          imageUrl: _sampleImageUrl,
        ),
      ),
      (
        label: 'Reply Preview',
        child: GdsChatBubble(
          type: GdsChatMessageType.me,
          content: '답장 미리보기가 있는 상태예요.',
          imageUrl: null,
          replyPreviewData: GdsChatReplyPreviewData(
            replyType: GdsChatMessageType.me,
            replyLabel: '나에게 답장',
            content: '원본 메시지 미리보기입니다.',
          ),
        ),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final item in items)
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
                _DemoCanvas(
                  child: item.child,
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _DemoCanvas extends StatelessWidget {
  const _DemoCanvas({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 337),
      color: context.gdsColors.surface.graySubtlest,
      padding: const EdgeInsets.symmetric(
        horizontal: GdsSpacing.spacing16,
        vertical: GdsSpacing.spacing24,
      ),
      child: child,
    );
  }
}
