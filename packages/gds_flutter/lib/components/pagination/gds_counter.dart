import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 현재 페이지와 전체 페이지 수를 표시하는 카운터 위젯.
@GdsSupportedSizes([.lg, .md])
class GdsCounter extends StatelessWidget {
  const new({
    super.key,
    required this.size,
    required this.count,
    required this.maxCount,
  }) : assert(count <= maxCount);

  final GdsSize size;
  final int count;
  final int maxCount;

  @override
  Widget build(BuildContext context) {
    final GdsTypography typography = size.when(
      lg: .label2,
      md: .label5,
    );

    return GdsContainer(
      color: .bgBlack,
      radius: .full,
      opacity: .opacity60,
      padding: .symmetric(
        vertical: 4,
        horizontal: size.when(lg: 12, md: 10),
      ),
      child: Row(
        mainAxisSize: .min,
        spacing: 2,
        children: [
          GdsText(count.toString(), color: .textWhite, style: typography),
          GdsText('/', color: .textWhite, style: typography),
          GdsText(maxCount.toString(), color: .textWhite, style: typography),
        ],
      ),
    );
  }
}
