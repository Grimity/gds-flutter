import 'package:flutter/widgets.dart';

/// 진행 값에 따라 중심에서 전체 영역을 덮도록 원형 클리핑 영역을 확장하는 클리퍼.
class RevealClipper extends CustomClipper<Path> {
  const new({required this.animation}) : super(reclip: animation);

  final Animation<double> animation;

  @override
  Path getClip(Size size) {
    final offset = Offset(size.width, size.height);

    return Path()..addOval(
      Rect.fromCircle(
        center: size.center(Offset.zero),
        radius: offset.distance / 2 * animation.value,
      ),
    );
  }

  @override
  bool shouldReclip(covariant RevealClipper oldClipper) {
    return oldClipper.animation != animation;
  }
}
