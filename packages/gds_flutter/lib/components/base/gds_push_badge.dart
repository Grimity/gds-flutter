import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 푸시 알림 배지의 위치를 나타내는 열거형.
enum GdsDotPushBadgePosition {
  topRight(.topRight),
  bottomRight(.bottomRight),
  bottomLeft(.bottomLeft),
  topLeft(.topLeft);

  const GdsDotPushBadgePosition(this.alignment);

  /// 배지의 위치를 나타내는 값.
  final AlignmentGeometry alignment;
}

/// 푸시 알림 넘버 배지의 시각적 스타일을 나타내는 열거형.
enum GdsNumberPushBadgeVariant {
  text,
  solid,
  outline,
}

/// 디자인 시스템에서 사용하는 푸시 알림 배지 위젯.
abstract class GdsPushBadge {
  /// 자식의 지정된 위치에 점 형태의 푸시 알림 배지를 표시하는 위젯.
  @GdsSupportedSizes([.xs, .sm, .md])
  static Widget dot({
    Key? key,
    required GdsDotPushBadgePosition position,
    required GdsSize size,
    required Widget child,
    bool visible = true,
  }) {
    final dimension = size.when(
      xs: 4.0,
      sm: 6.0,
      md: 8.0,
    );

    return Stack(
      key: key,
      children: [
        child,

        // 점 표시
        Positioned.fill(
          child: Align(
            alignment: position.alignment,
            child: GdsFadable.builder(
              type: .fade,
              visible: visible,
              builder: (context) {
                return GdsContainer(
                  width: dimension,
                  height: dimension,
                  shape: .circle,
                  color: .statusNotification,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  /// 알림 개수를 숫자 형태로 표시하는 푸시 알림 배지 위젯.
  static Widget number({
    Key? key,
    required GdsNumberPushBadgeVariant variant,
    required int value,
  }) {
    return Builder(
      key: key,
      builder: (context) {
        return GdsContainer(
          width: 20,
          height: 20,
          alignment: .center,
          shape: .circle,
          color: switch (variant) {
            .text => .surfaceBase,
            .solid => .statusNotification,
            .outline => null,
          },
          border: switch (variant) {
            .text => null,
            .solid => null,
            .outline => .all(color: .borderGraySubtler),
          },
          child: GdsText(
            value.toString(),
            style: .label5,
            color: switch (variant) {
              .text => .textGrayBold,
              .solid => .textInverse,
              .outline => .statusNotification,
            },
          ),
        );
      },
    );
  }
}
