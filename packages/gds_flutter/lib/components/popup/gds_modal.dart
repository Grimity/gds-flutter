import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

///
class GdsModal extends StatelessWidget {
  const new({
    super.key,
    required this.title,
    required this.onBack,
    this.iconAction,
    this.primaryButton,
    this.secondaryButton,
    required this.child,
  });

  final String title;
  final VoidCallback onBack;
  final GdsIconButtonAction? iconAction;
  final GdsTextButtonAction? primaryButton;
  final GdsTextButtonAction? secondaryButton;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final hasPrimaryButton = primaryButton != null;
    final hasSecondaryButton = secondaryButton != null;

    return GdsContainer(
      width: 400,
      maxHeight: 760,
      shadow: .level2,
      radius: .xl,
      border: .all(color: .borderGraySubtler),
      color: .surfaceBase,
      child: Column(
        mainAxisSize: .min,
        children: [
          // 상단에 헤더 표시
          _Header(
            title: title,
            onBack: onBack,
            action: iconAction,
          ),

          // 헤더 내용 표시
          Flexible(
            child: SingleChildScrollView(
              padding: .only(top: 8, bottom: 20, left: 20, right: 20),
              child: child,
            ),
          ),

          // 하단에 버튼 표시
          if (hasPrimaryButton || hasSecondaryButton) ...[
            Padding(
              padding: .only(
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: Row(
                spacing: 8,
                children: [
                  // 보조 버튼 표시
                  if (hasSecondaryButton) ...[
                    Expanded(
                      child: GdsButton.text(
                        type: .outlined,
                        size: .lg,
                        label: secondaryButton!.label,
                        onTap: secondaryButton!.onTap,
                        mainAxisSize: .max,
                      ),
                    ),
                  ],

                  // 주 버튼 표시
                  if (hasPrimaryButton) ...[
                    Expanded(
                      child: GdsButton.text(
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
}

///
class _Header extends StatelessWidget {
  const new({
    required this.title,
    required this.onBack,
    this.action,
  });

  final String title;
  final VoidCallback onBack;
  final GdsIconButtonAction? action;

  @override
  Widget build(BuildContext context) {
    final hasAction = action != null;

    return GdsContainer(
      height: GdsControlSize.xl.value,
      padding: .symmetric(horizontal: 20),
      alignment: .center,
      child: Row(
        children: [
          // 왼쪽 화살표 표시
          GdsIcon.chevronLeftTightThick.build(size: 24, color: .iconGrayBold),
          12.horizontalGap,

          // 헤더 제목 표시
          Expanded(
            child: GdsText(title, color: .textGrayBold, style: .title3),
          ),

          // 액션 버튼 표시
          if (hasAction) ...[
            GdsButton.icon(
              type: .normal,
              onTap: action!.onTap,
              icon: action!.icon,
            ),
            4.horizontalGap,
          ],

          // 닫기 버튼 표시
          GdsButton.icon(type: .normal, onTap: onBack, icon: .x),
        ],
      ),
    );
  }

  /// 모달 팝업을 오버레이에 표시합니다.
  Future<T?> open<T>(BuildContext context) {
    final route = GdsPopupRoute<T>(
      barrierDismissible: false,
      child: this,
    );

    return Navigator.of(context).push(route);
  }
}
