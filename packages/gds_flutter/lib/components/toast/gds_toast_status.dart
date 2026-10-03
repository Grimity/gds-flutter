import 'package:gds_flutter/gds_flutter.dart';

/// 토스트 메시지의 상태와 상태별 아이콘 및 색상을 정의하는 열거형.
enum GdsToastStatus {
  none(null, .iconWhite),
  positive(.checkCircleFill, .statusPositive),
  negative(.dangerCircleFill, .statusNegative),
  cautionary(.dangerTriangleFill, .statusCautionary),
  info(.infoCircleFill, .statusInfo);

  const new(this.icon, this.color);

  final GdsIcon? icon;
  final GdsColor color;
}
