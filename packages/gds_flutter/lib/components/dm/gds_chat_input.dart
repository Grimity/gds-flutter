import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 채팅 메시지 입력 필드와 답글 미리보기, 전송 버튼을 표시하는 위젯.
class GdsChatInput extends StatelessWidget {
  const new({
    super.key,
    this.enabled = true,
    this.reply,
    required this.onCameraTap,
    required this.onSubmit,
  });

  final bool enabled;
  final GdsChatInputReply? reply;
  final VoidCallback onCameraTap;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final hasReply = reply != null;

    return GdsContainer(
      padding: .symmetric(vertical: 8, horizontal: 16),
      border: .new(top: 1, color: .borderGraySubtler),
      color: .surfaceGraySubtlest,
      child: Column(
        mainAxisSize: .min,
        children: [
          // 답글 표시
          GdsFoldable.builder(
            alignment: .bottomCenter,
            visible: hasReply,
            axis: .vertical,
            builder: (context) {
              return Padding(padding: .only(bottom: 8), child: reply);
            },
          ),

          // 입력 필드 표시
          Row(
            crossAxisAlignment: .end,
            spacing: 8,
            children: [
              // 갤러리 이동 버튼 표시
              GdsGesture(
                onTap: enabled ? onCameraTap : null,
                child: GdsContainer(
                  alignment: .center,
                  height: 42, // sm 크기의 입력 필드 높이
                  child: GdsIcon.camera.build(
                    size: 24,
                    color: enabled ? .iconGrayBold : .iconGraySubtlest,
                  ),
                ),
              ),

              // 입력 필드 표시
              Expanded(
                child: GdsTextField.normal(
                  size: .sm,
                  placeholder: '메세지 입력',
                  status: enabled ? .enabled : .disabled,
                  maxLines: 4,
                ),
              ),

              // 전송 버튼 표시
              GdsButton.text(
                type: .solid,
                size: .md,
                onTap: onSubmit,
                label: '전송',
                status: enabled ? .enabled : .disabled,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
