import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 프로필, 최근 메시지, 경과 시간 등을 표시하는 DM 목록의 항목 위젯.
class GdsDmListItem extends StatelessWidget {
  const GdsDmListItem({
    super.key,
    this.active = false,
    this.checked = false,
    this.checkable = false,
    required this.profileUrl,
    required this.nickname,
    required this.message,
    required this.createdAt,
    this.unreadCount = 0,
    required this.onTap,
    required this.onChanged,
  });

  final bool active;
  final bool checked;
  final bool checkable;
  final String? profileUrl;
  final String nickname;
  final String message;
  final DateTime createdAt;
  final int unreadCount;
  final VoidCallback onTap;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GdsGesture(
      onTap: () => checkable ? onChanged(!checked) : onTap(),
      child: GdsContainer(
        padding: .symmetric(vertical: 12),
        color: active ? .surfaceGraySubtler : null,
        child: Row(
          children: [
            // 선택 모드에 따라 체크박스 표시
            GdsControl.foldable(
              visible: checkable,
              spacing: 12,
              control: GdsCheckBox(size: .md, value: checked),
            ),

            // 프로필 이미지, 닉네임, 경과 시간, 메시지 표시
            Expanded(child: buildUserInfo()),

            // 읽지 않은 메시지 개수를 배지로 표시
            GdsFoldable.builder(
              alignment: .centerRight,
              visible: unreadCount > 0,
              axis: .horizontal,
              builder: (context) {
                return Padding(
                  padding: .only(left: 12),
                  child: GdsPushBadge.number(variant: .solid, value: unreadCount),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// 프로필 이미지, 닉네임, 경과 시간과 메시지를 표시하는 위젯.
  Widget buildUserInfo() {
    return Row(
      spacing: 12,
      children: [
        GdsProfile(size: .md, url: profileUrl),
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            spacing: 4,
            children: [
              // 닉네임, 경과 시간 표시
              Row(
                spacing: 4,
                children: GdsDot.separated([
                  GdsText(nickname, color: .textGrayNormal, style: .label5),
                  GdsText(createdAt.timeAgo, color: .textGrayNormal, style: .label6),
                ]),
              ),

              // 메시지 내용을 한 줄로 표시
              GdsText(
                message,
                color: .textGrayBold,
                style: .body2R,
                maxLines: 1,
                overflow: .ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
