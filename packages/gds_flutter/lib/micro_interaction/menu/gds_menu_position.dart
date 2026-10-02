import 'package:flutter/widgets.dart';

/// 기준 위젯 아래에 표시할 메뉴의 가로 정렬 방식을 나타내는 열거형.
enum GdsMenuPosition {
  left(.bottomLeft, .topLeft), // 메뉴의 왼쪽 가장자리
  right(.bottomRight, .topRight), // 메뉴의 오른쪽 가장자리
  center(.bottomCenter, .topCenter); // 메뉴의 가로 중심

  const GdsMenuPosition(
    this.targetAnchor,
    this.followerAnchor,
  );

  /// 메뉴를 연결할 기준 위젯 하단의 앵커.
  final Alignment targetAnchor;

  /// 기준 위젯의 앵커에 맞출 메뉴 상단의 앵커.
  final Alignment followerAnchor;
}
