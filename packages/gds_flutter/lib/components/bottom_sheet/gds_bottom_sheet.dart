import 'package:flutter/material.dart' hide BottomSheet;
import 'package:flutter_scroll_bottom_sheet/flutter_bottom_sheet.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 상단 헤더, 콘텐츠와 액션 버튼을 표시하는 바텀 시트 위젯.
class GdsBottomSheet extends StatelessWidget {
  const GdsBottomSheet({
    super.key,
    this.title,
    required this.onBack,
    this.primaryButton,
    this.secondaryButton,
    required this.child,
  });

  final String? title;
  final VoidCallback onBack;
  final GdsTextButtonAction? primaryButton;
  final GdsTextButtonAction? secondaryButton;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final hasPrimaryButton = primaryButton != null;
    final hasSecondaryButton = secondaryButton != null;

    // 상단 모서리만 둥근 바텀 시트 형태.
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: GdsRadius.xl.circular),
    );

    return Material(
      color: GdsColor.surfaceBase.of(context),
      shape: shape,
      child: Column(
        mainAxisSize: .min,
        children: [
          // 상단 헤더 표시.
          GdsBottomSheetHeader(title: title, onBack: onBack),

          // 스크롤 가능한 콘텐츠 표시.
          CustomScrollView(
            scrollBehavior: ScrollBehavior().copyWith(overscroll: false),
            shrinkWrap: true,
            slivers: [
              SliverPadding(
                padding: const .only(
                  top: 8,
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                sliver: SliverToBoxAdapter(child: child),
              ),
            ],
          ),

          // 하단 액션 버튼 표시.
          if (hasPrimaryButton || hasSecondaryButton) ...[
            Padding(
              padding: .only(left: 20, right: 20, bottom: 20),
              child: Row(
                spacing: 8,
                children: [
                  // 좌측에 보조 버튼 표시.
                  if (hasSecondaryButton) ...[
                    Expanded(
                      child: GdsButton.text(
                        key: ValueKey('secondary'),
                        type: .outlined,
                        size: .lg,
                        label: secondaryButton!.label,
                        onTap: secondaryButton!.onTap,
                        mainAxisSize: .max,
                      ),
                    ),
                  ],

                  // 우측에 주 버튼 표시.
                  if (hasPrimaryButton) ...[
                    Expanded(
                      child: GdsButton.text(
                        key: ValueKey('primary'),
                        type: .solid,
                        size: .lg,
                        label: primaryButton!.label,
                        onTap: primaryButton!.onTap,
                        mainAxisSize: .max,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// 오버레이에 바텀 시트를 화면에 표시합니다.
  Future<T?> open<T>(BuildContext context) {
    final barrierColor = GdsColor.bgOverlayBlack.of(context);

    // 바텀 시트의 오버레이 색상과 키보드 표시 위치를 설정.
    BottomSheet.config = BottomSheetConfig(
      barrierColor: barrierColor,
      sheetBuilder: (context, child) {
        final keyboardHeight = MediaQuery.viewInsetsOf(context).bottom;

        return Transform.translate(
          offset: Offset(0, -keyboardHeight),
          transformHitTests: true,
          child: child,
        );
      },
    );

    return BottomSheet.open<T>(context, this);
  }
}
