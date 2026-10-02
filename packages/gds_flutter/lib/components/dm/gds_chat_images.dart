import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 이미지 개수에 따라 그리드 형태로 배치를 조정하는 채팅용 이미지 위젯.
class GdsChatImages extends StatelessWidget {
  const GdsChatImages({
    super.key,
    required this.images,
    required this.onTap,
  });

  final List<ImageProvider> images;
  final ValueChanged<ImageProvider> onTap;

  /// 이미지가 차지할 수 있는 최대 가로 크기.
  static const maxWidth = 308.0;

  @override
  Widget build(BuildContext context) {
    assert(images.isNotEmpty);
    assert(images.length <= 9);

    return GdsContainer(
      radius: .sm,
      width: maxWidth,
      clip: true,
      child: Builder(
        builder: (context) {
          // TODO: 이미지가 1장이면 원본 비율에 따라 동적으로 높이를 조정.
          if (images.length == 1) {
            return AspectRatio(
              aspectRatio: 1,
              child: buildImage(images.single),
            );
          }

          return StaggeredGrid.count(
            crossAxisCount: images.length <= 4 ? 2 : 6,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            children: images.indexedBuilder(buildGridTile),
          );
        },
      ),
    );
  }

  /// 이미지가 5장 이상이거나 3장 중 첫 번째 이미지이면 세로 2칸, 나머지는 1칸을 차지.
  int mainAxisCellCount(int index) {
    return images.length >= 5 || (images.length == 3 && index == 0) ? 2 : 1;
  }

  /// 이미지가 4장 이하면 가로 1칸, 5장 이상이면 6칸을 기준으로 한 행에 3장은 각각 2칸,
  /// 2장은 각각 3칸을 차지.
  int crossAxisCellCount(int index) {
    return switch (images.length) {
      <= 4 => 1,
      5 || 7 => index < 3 ? 2 : 3,
      8 => index < 6 ? 2 : 3,
      _ => 2,
    };
  }

  /// 주어진 이미지에 적절한 그리드 타일을 구성하는 위젯.
  Widget buildGridTile(int index, ImageProvider image) {
    return StaggeredGridTile.count(
      mainAxisCellCount: mainAxisCellCount(index),
      crossAxisCellCount: crossAxisCellCount(index),
      child: buildImage(image),
    );
  }

  /// 이미지를 표시하고 탭 이벤트를 처리하는 위젯.
  Widget buildImage(ImageProvider image) {
    return GdsGesture(
      onTap: () => onTap(image),
      child: GdsImage(provider: image),
    );
  }
}
