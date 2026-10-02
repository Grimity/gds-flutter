import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 프로필, 팔로우 정보, 탭 목록과 서비스 정보를 표시하는 사이드바 위젯.
@GdsSupportedSizes([.lg, .md])
class GdsSidebar extends StatelessWidget {
  const GdsSidebar({
    super.key,
    required this.size,
    required this.nickname,
    required this.handle,
    required this.profileUrl,
    required this.followerCount,
    required this.followingCount,
    required this.onProfile,
    required this.onNickname,
    required this.onHandle,
    required this.onFollower,
    required this.onFollowing,
    required this.onSignOut,
    required this.onTermsOfService,
    required this.onPrivacyPolicy,
    required this.onBusinessInfo,
    required this.tabs,
  });

  final GdsSize size;
  final String nickname;
  final String handle;
  final String? profileUrl;
  final int followerCount;
  final int followingCount;
  final VoidCallback onProfile;
  final VoidCallback onNickname;
  final VoidCallback onHandle;
  final VoidCallback onFollower;
  final VoidCallback onFollowing;
  final VoidCallback onSignOut;
  final VoidCallback onTermsOfService;
  final VoidCallback onPrivacyPolicy;
  final VoidCallback onBusinessInfo;
  final List<GdsSidebarTab> tabs;

  @override
  Widget build(BuildContext context) {
    return GdsContainer(
      width: size.when(lg: 300, md: 220),
      color: .surfaceBase,
      padding: .only(
        top: 12,
        left: 16,
        right: 16,
        bottom: 24,
      ),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 20,
        children: [
          // 상단에 프로필 영역 표시
          Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            children: [
              // 프로필 사진 표시
              GdsGesture(
                onTap: onProfile,
                child: GdsProfile(size: .ml, url: profileUrl),
              ),
              8.verticalGap,

              // 닉네임 표시
              GdsGesture(
                onTap: onNickname,
                child: GdsText(nickname, color: .textGrayBold, style: .label3),
              ),
              2.verticalGap,

              // 핸들 표시
              GdsGesture(
                onTap: onHandle,
                child: GdsText('@$handle', color: .textGraySubtle, style: .label6),
              ),
              8.verticalGap,

              // 팔로워, 팔로잉 개수 표시
              GdsUserInfo.follow(
                followerCount: followerCount,
                followingCount: followingCount,
                onFollower: onFollower,
                onFollowing: onFollowing,
              ),
            ],
          ),

          // 스크롤 가능한 탭 목록 표시
          Expanded(
            child: GdsMasking(
              child: ListView.separated(
                clipBehavior: .none,
                itemCount: tabs.length,
                itemBuilder: (context, index) => tabs[index],
                separatorBuilder: (context, index) => 8.verticalGap,
              ),
            ),
          ),

          // 하단에 액션 버튼과 앱 정보 표시
          Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            spacing: 12,
            children: [
              // 로그아웃 버튼 표시
              GdsButton.text(
                type: .borderless,
                variant: .assistive,
                size: .sm,
                onTap: onSignOut,
                label: '로그아웃',
                trailingIcon: .out,
              ),

              Column(
                crossAxisAlignment: .start,
                mainAxisSize: .min,
                spacing: 4,
                children: [
                  Row(
                    spacing: 6,
                    children: GdsDot.separated([
                      // 이용약관 버튼 표시
                      GdsGesture(
                        onTap: onTermsOfService,
                        child: GdsText('이용약관', color: .textGraySubtle, style: .label6),
                      ),

                      // 개인정보처리방침 버튼 표시
                      GdsGesture(
                        onTap: onPrivacyPolicy,
                        child: GdsText('개인정보처리방침', color: .textGraySubtle, style: .label6),
                      ),
                    ]),
                  ),

                  // 사용자 정보 버튼 표시
                  GdsGesture(
                    onTap: onBusinessInfo,
                    child: GdsText('사용자 정보', color: .textGraySubtle, style: .label6),
                  ),

                  // 그리미티 저작권 표시
                  GdsText(
                    '© Grimity. All rights reserved.',
                    color: .textGraySubtle,
                    style: .label6,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
