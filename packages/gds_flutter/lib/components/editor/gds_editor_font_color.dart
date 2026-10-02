import 'package:gds_flutter/gds_flutter.dart';

/// 에디터에서 사용할 수 있는 글자색을 나타내는 열거형.
enum GdsEditorFontColor {
  white(.white),
  black(.black),
  gray(.gray),
  lightGray(.lightGray),
  red(.red),
  orange(.orange),
  yellow(.yellow),
  green(.green),
  blue(.blue),
  deepBlue(.deepBlue),
  magenta(.magenta),
  purple(.purple),
  brown(.brown),
  mint(.mint);

  const GdsEditorFontColor(this.color);

  final GdsColor color;

  /// 현재 색상 위에 표시할 전경색을 반환합니다.
  GdsColor get foregroundColor => this == .white ? .black : .white;
}
