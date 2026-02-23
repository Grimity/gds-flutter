import 'package:flutter/widgets.dart';
import 'package:gds_tokens/gds_tokens.dart';
import 'package:lottie/lottie.dart';

part 'lottie/gds_lottie.dart';

abstract class LottieBuilder {
  const LottieBuilder();

  Widget build() => throw UnimplementedError();
}
