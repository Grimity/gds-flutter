import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 화면 상단에 위치한 내비게이션으로, 작은 화면을 디자인할 때 사용됩니다.
abstract class GdsTopNavigation {
  /// 로고, 검색, 알림 아이콘과 프로필 이미지를 표시하는 상단 내비게이션 위젯.
  static Widget main({
    Key? key,
    required VoidCallback onSearch,
    required VoidCallback onNotification,
    required VoidCallback onProfile,
    required ImageProvider? profile,
    required bool hasNotification,
  }) {
    return GdsContainer(
      key: key,
      height: GdsControlSize.ml.value,
      padding: .symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          // 좌측에 타이틀 로고 표시
          GdsIcon.logo.build(size: 28),

          // 우측에 메인 아이콘 표시
          _MainIcons(
            onSearch: onSearch,
            onNotification: onNotification,
            onProfile: onProfile,
            profile: profile,
            hasNotification: hasNotification,
          ),
        ],
      ),
    );
  }

  /// 뒤로가기 버튼과 제목, 검색, 알림 아이콘과 프로필 이미지를 표시하는 상단 내비게이션 위젯.
  static Widget title({
    Key? key,
    required VoidCallback onBack,
    required VoidCallback onSearch,
    required VoidCallback onNotification,
    required VoidCallback onProfile,
    String? title,
    required ImageProvider? profile,
    required bool hasNotification,
  }) {
    final hasTitle = title != null;

    return GdsContainer(
      key: key,
      height: GdsControlSize.ml.value,
      padding: .symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Row(
            mainAxisSize: .min,
            spacing: 8,
            children: [
              // 좌측에 뒤로가기 버튼 표시
              GdsButton.icon(type: .normal, icon: .chevronLeftThick, onTap: onBack),

              // 좌측에 제목 표시
              if (hasTitle) ...[
                GdsText(title, color: .textGrayBold, style: .subtitle2),
              ],
            ],
          ),

          // 우측에 메인 아이콘 표시
          _MainIcons(
            onSearch: onSearch,
            onNotification: onNotification,
            onProfile: onProfile,
            profile: profile,
            hasNotification: hasNotification,
          ),
        ],
      ),
    );
  }

  /// 뒤로가기 버튼과 제목, 우측에 최대 3개의 아이콘 버튼을 표시하는 상단 내비게이션 위젯.
  static Widget iconButton({
    Key? key,
    required VoidCallback onBack,
    required List<GdsIconButtonAction> actions,
    String? title,
  }) {
    assert(actions.length <= 3, '아이콘은 3개이거나 그 이하여야 합니다.');
    final hasTitle = title != null;

    return GdsContainer(
      key: key,
      height: GdsControlSize.ml.value,
      padding: .symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Row(
            mainAxisSize: .min,
            spacing: 8,
            children: [
              // 좌측에 뒤로가기 버튼 표시
              GdsButton.icon(type: .normal, icon: .chevronLeftThick, onTap: onBack),

              // 좌측에 제목 표시
              if (hasTitle) ...[
                GdsText(title, color: .textGrayBold, style: .subtitle2),
              ],
            ],
          ),

          // 우측에 아이콘 목록 표시
          Row(
            mainAxisSize: .min,
            spacing: 16,
            children: actions.builder((action) {
              return GdsButton.icon(
                type: .normal,
                icon: action.icon,
                onTap: action.onTap,
              );
            }),
          ),
        ],
      ),
    );
  }

  /// 뒤로가기 버튼과 검색어 입력 필드를 표시하는 상단 내비게이션 위젯.
  static Widget search({
    Key? key,
    required VoidCallback onBack,
    String? placeholder,
    String? initialText,
    ValueChanged<String>? onSubmitted,
    VoidCallback? onComplete,
    ValueChanged<String>? onChanged,
  }) {
    return GdsContainer(
      key: key,
      height: GdsControlSize.ml.value,
      padding: .symmetric(horizontal: 16),
      child: Row(
        spacing: 8,
        children: [
          // 좌측에 뒤로가기 버튼 표시
          GdsButton.icon(type: .normal, icon: .chevronLeftThick, onTap: onBack),

          // 우측에 입력 필드 표시
          Expanded(
            child: GdsTextField.search(
              size: .md,
              placeholder: placeholder,
              initialText: initialText,
              onChanged: onChanged,
              onComplete: onComplete,
              onSubmitted: onSubmitted,
            ),
          ),
        ],
      ),
    );
  }

  /// 뒤로가기 버튼과 프로필, 닉네임, 신고 및 나가기 버튼을 표시하는 DM용 상단 내비게이션 위젯.
  static Widget dm({
    Key? key,
    required VoidCallback onBack,
    required VoidCallback onUser,
    required VoidCallback onExit,
    required VoidCallback onReport,
    required String nickname,
    required String handle,
    required ImageProvider? profile,
  }) {
    return GdsContainer(
      key: key,
      height: GdsControlSize.lg.value,
      padding: .symmetric(horizontal: 16),
      child: Row(
        spacing: 8,
        children: [
          // 좌측에 뒤로가기 버튼 표시
          GdsButton.icon(type: .normal, icon: .chevronLeftThick, onTap: onBack),

          // 사용자 정보 표시
          GdsGesture(
            onTap: onUser,
            child: GdsUserItem.info(
              nickname: nickname,
              handle: handle,
              profile: profile,
            ),
          ),

          // 그 외 우측으로 밀기
          Expanded(child: SizedBox.shrink()),

          // 우측에 액션 버튼들 표시
          GdsButton.icon(type: .normal, onTap: onReport, icon: .sirenRounded),
          GdsButton.icon(type: .normal, onTap: onExit, icon: .out),
        ],
      ),
    );
  }

  /// 뒤로가기 버튼과 제목, 액션 버튼을 표시하는 에디터용 상단 내비게이션 위젯.
  static Widget editor({
    Key? key,
    required VoidCallback onBack,
    required VoidCallback onTitle,
    required VoidCallback onAction,
    required String title,
    required String label,
  }) {
    return GdsContainer(
      key: key,
      height: GdsControlSize.ml.value,
      padding: .symmetric(horizontal: 16),
      child: Row(
        spacing: 16,
        children: [
          Expanded(
            child: Row(
              spacing: 8,
              children: [
                // 좌측에 뒤로가기 버튼 표시
                GdsButton.icon(type: .normal, icon: .chevronLeftThick, onTap: onBack),

                // 좌측에 상호작용 제목 표시
                GdsGesture(
                  onTap: onTitle,
                  child: Row(
                    mainAxisSize: .min,
                    spacing: 4,
                    children: [
                      GdsText(title, color: .textGrayBold, style: .subtitle2),
                      GdsIcon.chevronDownThick.build(size: 20, color: .iconGrayBold),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 우측에 액션 버튼 표시
          GdsButton.text(
            type: .borderless,
            variant: .primary,
            size: .lg,
            label: label,
            onTap: onAction,
          ),
        ],
      ),
    );
  }

  /// 뒤로가기 버튼과 다운로드 버튼을 표시하는 이미지 뷰어용 상단 내비게이션 위젯.
  static Widget imageViewer({
    Key? key,
    required VoidCallback onBack,
    required VoidCallback onDownload,
    required bool canDownload,
  }) {
    return GdsContainer(
      key: key,
      color: .bgOverlayBlack,
      height: GdsControlSize.ml.value,
      padding: .symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          // 좌측에 뒤로가기 버튼 표시
          GdsButton.icon(
            type: .normal,
            icon: .chevronLeftThick,
            color: .iconWhite,
            onTap: onBack,
          ),

          // 우측에 다운로드 버튼 표시
          if (canDownload) ...[
            GdsButton.icon(
              type: .normal,
              icon: .down,
              onTap: onDownload,
              color: .iconWhite,
            ),
          ],
        ],
      ),
    );
  }
}

/// 상단 내비게이션 우측에 검색, 알림 아이콘과 프로필 이미지를 표시하는 위젯.
class _MainIcons extends StatelessWidget {
  const _MainIcons({
    required this.onSearch,
    required this.onNotification,
    required this.onProfile,
    required this.profile,
    required this.hasNotification,
  });

  final VoidCallback onSearch;
  final VoidCallback onNotification;
  final VoidCallback onProfile;
  final ImageProvider? profile;
  final bool hasNotification;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: key,
      mainAxisSize: .min,
      spacing: 16,
      children: [
        // 돋보기 아이콘 표시
        GdsButton.icon(type: .normal, onTap: onSearch, icon: .magnifier),

        // 알림 아이콘 표시
        GdsPushBadge.dot(
          visible: hasNotification,
          position: .topRight,
          size: .sm,
          child: GdsButton.icon(type: .normal, onTap: onSearch, icon: .bell),
        ),

        // 프로필 이미지 표시
        GdsGesture(
          onTap: onProfile,
          child: GdsProfile(size: .xs, image: profile),
        ),
      ],
    );
  }
}
