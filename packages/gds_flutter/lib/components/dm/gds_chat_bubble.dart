import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 발신자에 따른 말풍선 스타일과 메시지와 좋아요 상태를 표시하는 위젯.
class GdsChatBubble extends StatelessWidget {
  const new({
    super.key,
    required this.message,
    this.send = false,
    this.like = false,
    this.onLike,
    this.onReply,
  });

  final String message;
  final bool send;
  final bool like;
  final VoidCallback? onLike;
  final VoidCallback? onReply;

  @override
  Widget build(BuildContext context) {
    final isMine = context.findAncestorWidgetOfExactType<GdsChat>()?.isMine;
    if (isMine == null) {
      throw FlutterError(
        'GdsChatBubble는 GdsChat 내부에서만 사용할 수 있습니다.'
        'GdsChat의 bubble 속성으로 전달해 주세요.',
      );
    }

    return Row(
      crossAxisAlignment: .end,
      mainAxisSize: .min,
      spacing: 6,
      children: [
        Flexible(
          child: GdsPopoverAnchor(
            builder: (context, link) {
              return GdsGesture(
                onTap: () => openPopover(context, link, isMine),
                child: Stack(
                  children: [
                    // 메시지 본문 표시
                    GdsContainer(
                      color: isMine ? .surfacePrimaryNormal : .surfaceGraySubtler,
                      padding: .symmetric(vertical: 8, horizontal: 12),
                      borderRadius: .new(
                        topLeft: .xl,
                        topRight: .xl,
                        bottomRight: isMine ? .xs : .xl,
                        bottomLeft: isMine ? .xl : .xs,
                      ),
                      child: GdsText(message, color: .textGrayBold, style: .label2),
                    ),

                    // 좋아요 아이콘 배지 표시
                    Positioned.fill(
                      left: 12,
                      right: 12,
                      child: Align(
                        alignment: isMine ? .bottomRight : .bottomLeft,
                        child: FractionalTranslation(
                          translation: .new(0, 0.5),
                          child: GdsFadable.builder(
                            type: .scaleFade,
                            visible: like,
                            builder: (context) {
                              return iconBadge(icon: .heartFill, color: .statusNotification);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        // 메시지 보내기 중 표시
        if (send) ...[
          GdsIcon.message.build(size: 16, color: .iconGraySubtler),
        ],
      ],
    );
  }

  /// 지정한 아이콘과 색상으로 원형 배지를 표시하는 위젯.
  Widget iconBadge({required GdsIcon icon, required GdsColor color}) {
    return GdsContainer(
      width: 20,
      height: 20,
      border: .all(color: .borderGraySubtler),
      shape: .circle,
      color: .surfaceBase,
      alignment: .center,
      child: icon.build(size: 12, color: color),
    );
  }

  /// 말풍선 옆에 좋아요와 답글 버튼을 표시하는 팝오버.
  Future<void> openPopover(BuildContext context, LayerLink link, bool isMine) {
    final hasLike = onLike != null;
    final hasReply = onReply != null;

    final route = GdsPopoverRoute(
      followerAnchor: isMine ? .centerRight : .centerLeft,
      targetAnchor: isMine ? .centerLeft : .centerRight,
      layerLink: link,
      offset: .new(isMine ? -6 : 6, 0),
      child: Row(
        mainAxisSize: .min,
        spacing: 4,
        children: [
          // 좋아요 버튼 표시
          if (hasLike && !isMine) ...[
            GdsButton.icon(
              type: .outlined,
              icon: like ? .heartFill : .heart,
              color: like ? .statusNotification : null,
              onTap: onLike!,
            ),
          ],

          // 답글 버튼 표시
          if (hasReply) ...[
            GdsButton.icon(type: .outlined, onTap: onLike!, icon: .forward2),
          ],
        ],
      ),
    );

    return Navigator.push(context, route);
  }
}
