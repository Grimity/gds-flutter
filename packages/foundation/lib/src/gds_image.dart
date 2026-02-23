import 'package:flutter/widgets.dart';

part 'image/gds_image.dart';

abstract class ImageBuilder {
  const ImageBuilder();

  Widget build() => throw UnimplementedError();
}
