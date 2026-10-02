import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 라벨과 아이콘을 표시하는 태그이며 주로 [GdsTagSelect]에서 사용되는 위젯.
@GdsSupportedSizes([.md, .xs])
class GdsTag extends StatelessWidget {
  const GdsTag({
    super.key,
    required this.size,
    required this.label,
    this.enabled = true,
    this.icon,
    this.onTap,
  });

  final GdsSize size;
  final String label;
  final bool enabled;
  final GdsIcon? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final hasIcon = icon != null;

    return GdsGesture(
      onTap: enabled ? onTap : null,
      child: GdsContainer(
        radius: .full,
        padding: size.when(
          md: .only(top: 6, left: 16, right: hasIcon ? 12 : 16, bottom: 6),
          xs: .only(top: 4, left: 10, right: hasIcon ? 8 : 10, bottom: 4),
        ),
        color: enabled ? .surfaceGraySubtler : .surfaceGraySubtlest,
        child: Row(
          mainAxisSize: .min,
          spacing: 4,
          children: [
            // 좌측에 라벨 표시
            GdsText(
              label,
              style: .label4,
              color: enabled ? .textGrayBold : .textGraySubtler,
            ),

            // 우측에 아이콘 표시
            if (hasIcon) ...[
              icon!.build(
                size: 16,
                color: enabled ? .iconGrayBold : .iconGraySubtler,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
