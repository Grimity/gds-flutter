import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(
  name: 'item',
  type: GdsDmItem,
  path: '[component]/[dm]/',
)
Widget buildGdsDmItemUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'DM Item',
    description: 'DM 목록에서 사용하는 채팅방 Item 컴포넌트입니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final nickname = context.knobs.string(label: 'nickname', initialValue: 'Nickname');
  final messageText = context.knobs.string(label: 'messageText', initialValue: 'DM massage DM massage');
  final timeText = context.knobs.string(label: 'timeText', initialValue: '32분 전');
  final isActive = context.knobs.boolean(label: 'isActive', initialValue: false);
  final showCheckbox = context.knobs.boolean(label: 'showCheckbox', initialValue: true);
  final isChecked = context.knobs.boolean(label: 'isChecked', initialValue: false);
  final showUnreadBadge = context.knobs.boolean(label: 'showUnreadBadge', initialValue: true);
  final unreadCount = context.knobs.int.input(label: 'unreadCount', initialValue: 1);
  final avatarImageUrl = context.knobs.string(
    label: 'avatarImageUrl',
    initialValue: '',
  );

  return WidgetbookPlayground(
    info: [
      'showCheckbox: $showCheckbox',
      'showUnreadBadge: $showUnreadBadge',
      'activeBackground: ${isActive ? "graySubtler" : "none"}',
    ],
    child: SizedBox(
      width: 375,
      child: GdsDmItem(
        nickname: nickname,
        messageText: messageText,
        timeText: timeText,
        isActive: isActive,
        showCheckbox: showCheckbox,
        isChecked: isChecked,
        avatarImageUrl: avatarImageUrl,
        onCheckboxTap: showCheckbox ? () {} : null,
        unreadCount: showUnreadBadge ? unreadCount : null,
        onTap: () {},
      ),
    ),
  );
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'DM Item',
    children: [
      WidgetbookSubsection(
        title: 'state',
        labels: const ['Active=False', 'Active=True'],
        content: const _DmItemMatrix(),
      ),
    ],
  );
}

enum _DmItemPreviewState {
  defaultState(
    nickname: 'Nickname',
    messageText: 'DM massage DM massage',
    timeText: '32분 전',
    isActive: false,
    showCheckbox: true,
    isChecked: false,
    avatarImageUrl: '',
    unreadCount: 1,
  ),
  active(
    nickname: 'Nickname',
    messageText: 'DM massage DM massage',
    timeText: '32분 전',
    isActive: true,
    showCheckbox: true,
    isChecked: false,
    avatarImageUrl: '',
    unreadCount: 1,
  );

  const _DmItemPreviewState({
    required this.nickname,
    required this.messageText,
    required this.timeText,
    required this.isActive,
    required this.showCheckbox,
    required this.isChecked,
    required this.avatarImageUrl,
    required this.unreadCount,
  });

  final String nickname;
  final String messageText;
  final String timeText;
  final bool isActive;
  final bool showCheckbox;
  final bool isChecked;
  final String avatarImageUrl;
  final int? unreadCount;
}

class _DmItemMatrix extends StatelessWidget {
  const _DmItemMatrix();

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final labelStyle = GdsTypography.caption1.copyWith(color: colors.text.graySubtle);

    const states = [
      (label: 'Active=False', state: _DmItemPreviewState.defaultState),
      (label: 'Active=True', state: _DmItemPreviewState.active),
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
                  child: GdsDmItem(
                    nickname: item.state.nickname,
                    messageText: item.state.messageText,
                    timeText: item.state.timeText,
                    isActive: item.state.isActive,
                    showCheckbox: item.state.showCheckbox,
                    isChecked: item.state.isChecked,
                    avatarImageUrl: item.state.avatarImageUrl,
                    onCheckboxTap: item.state.showCheckbox ? () {} : null,
                    unreadCount: item.state.unreadCount,
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
