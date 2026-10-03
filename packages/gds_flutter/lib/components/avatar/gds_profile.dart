import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 사용자 프로필 이미지를 원형으로 표시하는 위젯.
class GdsProfile extends StatelessWidget {
  const new({
    super.key,
    required this.size,
    required this.image,
  });

  final GdsSize size;
  final ImageProvider? image;

  /// 주어진 크기에 해당하는 프로필 이미지의 너비와 높이를 반환합니다.
  static double getDimension(GdsSize size) {
    return size.when(
      xs: 24.0,
      sm: 32.0,
      md: 40.0,
      ml: 48.0,
      lg: 64.0,
      xl: 80.0,
      xxl: 100.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final dimension = getDimension(size);

    return GdsThumbnail(
      key: ValueKey(dimension),
      provider: image,
      placeholder: context.theme.profilePlaceholder,
      radius: .full,
      border: .all(color: .borderGraySubtler),
      ratio: .square,
      width: dimension,
      height: dimension,
    );
  }
}
