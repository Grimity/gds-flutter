import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gds_tokens/gds_tokens.dart';

part 'icon/gds_icon.dart';
part 'icon/gds_icon_size.dart';

abstract class IconBuilder {
  const IconBuilder();

  Widget build() => throw UnimplementedError();
}
