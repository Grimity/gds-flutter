import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 라벨과 앞뒤 위젯을 일관된 형태로 배치하는 리스트 아이템의 기본 프레임.
class GdsCellFrame extends StatelessWidget {
  const GdsCellFrame({
    super.key,
    required this.enabledStyle,
    required this.disabledStyle,
    required this.selectedStyle,
    required this.status,
    required this.label,
    required this.labelStyle,
    this.negativeStyle,
    this.onTap,
    this.padding,
    this.radius,
    this.leadingWidget,
    this.trailingWidget,
  });

  final GdsCellStyle enabledStyle;
  final GdsCellStyle selectedStyle;
  final GdsCellStyle disabledStyle;
  final GdsCellStyle? negativeStyle;
  final GdsCellStatus status;
  final String label;
  final GdsTypography labelStyle;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final GdsRadius? radius;
  final Widget? leadingWidget;
  final Widget? trailingWidget;

  @override
  Widget build(BuildContext context) {
    final style = switch (status) {
      .disabled => disabledStyle,
      .negative => negativeStyle ?? enabledStyle,
      .selected => selectedStyle,
      .enabled => enabledStyle,
    };

    return IgnorePointer(
      ignoring: status == .disabled || onTap == null,
      child: GdsGesture(
        onTap: onTap,
        child: GdsContainer(
          animation: .fast,
          padding: padding,
          border: style.border,
          radius: radius,
          color: style.backgroundColor,
          child: Row(
            spacing: 8,
            children: [
              ?leadingWidget,
              Expanded(
                child: GdsText(
                  label,
                  style: labelStyle,
                  color: style.textColor,
                ),
              ),
              ?trailingWidget,
            ],
          ),
        ),
      ),
    );
  }
}
