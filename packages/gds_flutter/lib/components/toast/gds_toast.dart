import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 상단에 간단한 경고 혹은 안내 메시지를 표시하는 토스트 위젯.
class GdsToast extends StatelessWidget {
  const GdsToast({
    super.key,
    this.status = .none,
    required this.message,
  }) : assert(message.length != 0);

  final GdsToastStatus status;
  final String message;

  @override
  Widget build(BuildContext context) {
    final hasIcon = status.icon != null;

    return ClipRRect(
      borderRadius: GdsRadius.full.borderRadius,
      child: BackdropFilter(
        filter: .blur(sigmaX: 4, sigmaY: 4),
        child: GdsContainer(
          padding: !hasIcon
              ? .symmetric(vertical: 10, horizontal: 12) //
              : .all(10).copyWith(right: 12),
          opacity: .opacity80,
          radius: .full,
          color: .bgBlack,
          child: Row(
            mainAxisSize: .min,
            spacing: 4,
            children: [
              // 아이콘 표시
              if (hasIcon) ...[
                status.icon!.build(size: 16, color: status.color),
              ],

              // 메세지 표시
              GdsText(message, color: .textWhite, style: .label5),
            ],
          ),
        ),
      ),
    );
  }

  /// 현재 컨텍스트의 오버레이에 토스트를 표시합니다.
  void open(BuildContext context) {
    final overlay = Overlay.maybeOf(context);
    assert(overlay != null, '상위 트리에 오버레이가 존재하지 않습니다.');

    late final OverlayEntry entry;

    overlay?.insert(
      entry = OverlayEntry(
        builder: (context) {
          return GdsToastOverlay(toast: this, onDismissed: entry.remove);
        },
      ),
    );
  }

  /// 상태와 메시지를 지정해 현재 컨텍스트에 토스트를 표시합니다.
  static void show(
    BuildContext context,
    String message, {
    GdsToastStatus status = .none,
  }) {
    GdsToast(status: status, message: message).open(context);
  }
}
