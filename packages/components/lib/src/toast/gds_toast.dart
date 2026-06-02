import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gds_components/src/common/widget/gds_toast_host.dart';
import 'package:gds_components/src/toast/overlay/gds_toast_overlay.dart';
import 'package:gds_foundation/gds_foundation.dart';

enum GdsToastType {
  positive,
  nagative,
  caautionary,
  info,
  normal, // 원래 default 인데 예약어로 인해 normal로 변경
}

class GdsToast extends StatelessWidget {
  const GdsToast({
    super.key,
    this.type = GdsToastType.normal,
    required this.message,
  });

  /// 토스트 메세지의 유형
  final GdsToastType type;

  /// 토스트 메세지의 내용
  final String message;

  /// 토스트의 배경색을 반환합니다.
  GdsIcon? get icon {
    return switch (type) {
      GdsToastType.positive => GdsIcon.checkCircleFill,
      GdsToastType.nagative => GdsIcon.dangerCircleFill,
      GdsToastType.caautionary => GdsIcon.dangerTriangleFill,
      GdsToastType.info => GdsIcon.infoCircleFill,
      GdsToastType.normal => null,
    };
  }

  @override
  Widget build(BuildContext context) {
    assert(message.isNotEmpty, 'message는 비어있을 수 없습니다.');
    final colors = context.gdsColors;

    return ClipRRect(
      borderRadius: BorderRadius.circular(GdsRadius.full),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: GdsSpacing.spacing10,
            horizontal: GdsSpacing.spacing12,
          ),
          color: colors.bg.black.withAlpha((GdsOpacity.opacity80 * 255).toInt()),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: GdsSpacing.spacing4,
            children: [
              if (icon != null) ...[
                icon!.build(
                  width: GdsSpacing.spacing16,
                  height: GdsSpacing.spacing16,
                  color: switch (type) {
                    GdsToastType.positive => colors.status.positive,
                    GdsToastType.nagative => colors.status.negative,
                    GdsToastType.caautionary => colors.status.cautionary,
                    GdsToastType.info => colors.status.info,
                    GdsToastType.normal => throw UnimplementedError(),
                  },
                ),
              ],
              Text(
                message,
                style: GdsTypography.label5.copyWith(color: colors.text.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 오버레이에 토스트를 화면에 표시합니다.
  static void open(
    BuildContext context, {
    required GdsToastType type,
    required String message,
  }) {
    final overlayContext = GdsToastHost.context ?? context;
    final overlay = Overlay.maybeOf(overlayContext);
    assert(overlay != null);

    late final OverlayEntry entry;

    overlay?.insert(
      entry = OverlayEntry(
        builder: (context) {
          return Material(
            type: MaterialType.transparency,
            child: IgnorePointer(
              ignoring: true,
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: GdsSpacing.spacing8),
                  child: GdsToastOverlay(
                    toast: GdsToast(type: type, message: message),
                    onDismissed: () => entry.remove(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
