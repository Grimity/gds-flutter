import 'package:flutter/widgets.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_foundation/gds_foundation.dart';

/// Top Navigation 컴포넌트의 고유 타입을 정의하는 열거형입니다.
enum GdsTopNavigationType {
  main("Main"),
  title("Title"),
  iconButton("IconButton"),
  search("Search"),
  dm("DM"),
  editor("Editor"),
  imageViewer("ImageViewer");

  final String displayName;

  const GdsTopNavigationType(this.displayName);
}

/// 디자인 시스템에 따라 구현된 Top Navigation 컴포넌트입니다.
class GdsTopNavigation {
  const GdsTopNavigation._();

  /// 주어진 타입에 해당하는 Top Navigation 위젯을 반환합니다.
  static Widget of(GdsTopNavigationType type) {
    return switch (type) {
      GdsTopNavigationType.main => main(
        onSearch: () => debugPrint('Search button tapped'),
        onAvatar: () => debugPrint('Avatar button tapped'),
        onNotification: () => debugPrint('Notification button tapped'),
        hasNotification: true,
      ),
      GdsTopNavigationType.title => title(
        title: 'Title',
        onBack: () => debugPrint('Back button tapped'),
        onSearch: () => debugPrint('Search button tapped'),
        onAvatar: () => debugPrint('Avatar button tapped'),
        onNotification: () => debugPrint('Notification button tapped'),
        hasNotification: true,
      ),
      GdsTopNavigationType.iconButton => iconButton(
        title: 'Title',
        onBack: () => debugPrint('Back button tapped'),
        icons: const [GdsIcon.blank, GdsIcon.blank, GdsIcon.blank],
        onIconTap: [
          () => debugPrint('first button tapped'),
          () => debugPrint('second button tapped'),
          () => debugPrint('third button tapped'),
        ],
      ),
      GdsTopNavigationType.search => search(
        onBack: () => debugPrint('Back button tapped'),
        field: GdsTextField.search(placeholder: 'Input filled'),
      ),
      GdsTopNavigationType.dm => dm(
        displayName: '호두마루',
        userId: '@hodumaru',
        onBack: () => debugPrint('Back button tapped'),
        onReport: () => debugPrint('Report button tapped'),
        onSignOut: () => debugPrint('Sign out button tapped'),
        onProfile: () => debugPrint('Profile area tapped'),
      ),
      GdsTopNavigationType.editor => editor(
        title: 'Title',
        label: 'Label',
        onBack: () => debugPrint('Back button tapped'),
        onTitle: () => debugPrint('Title tapped'),
        onSave: () => debugPrint('Save button tapped'),
        saveEnabled: true,
      ),
      GdsTopNavigationType.imageViewer => imageViewer(
        onClose: () => debugPrint('Close button tapped'),
        onDownload: () => debugPrint('Download button tapped'),
      ),
    };
  }

  /// Top Navigation의 `Main` 타입을 빌드합니다.
  static Widget main({
    Key? key,
    required VoidCallback onSearch,
    required VoidCallback onAvatar,
    required VoidCallback onNotification,
    String? avatarImageUrl,
    required bool hasNotification,
  }) {
    return _Main(
      key: key,
      onSearch: onSearch,
      onAvatar: onAvatar,
      onNotification: onNotification,
      avatarImageUrl: avatarImageUrl,
      hasNotification: hasNotification,
    );
  }

  /// Top Navigation의 `Title` 타입을 빌드합니다.
  static Widget title({
    Key? key,
    required String title,
    required VoidCallback onBack,
    required VoidCallback onSearch,
    required VoidCallback onAvatar,
    required VoidCallback onNotification,
    String? avatarImageUrl,
    required bool hasNotification,
    bool showTitle = true,
    bool showIcons = true,
  }) {
    return _Title(
      key: key,
      title: title,
      onBack: onBack,
      onSearch: onSearch,
      onAvatar: onAvatar,
      onNotification: onNotification,
      avatarImageUrl: avatarImageUrl,
      hasNotification: hasNotification,
      showTitle: showTitle,
      showIcons: showIcons,
    );
  }

  /// Top Navigation의 `IconButton` 타입을 빌드합니다.
  static Widget iconButton({
    Key? key,
    required String title,
    required VoidCallback onBack,
    required List<GdsIcon> icons,
    required List<VoidCallback> onIconTap,
    bool showTitle = true,
    bool showIcons = true,
  }) {
    return _IconButton(
      key: key,
      title: title,
      onBack: onBack,
      icons: icons,
      onIconTap: onIconTap,
      showTitle: showTitle,
      showIcons: showIcons,
    );
  }

  /// Top Navigation의 `Search` 타입을 빌드합니다.
  static Widget search({
    Key? key,
    required VoidCallback onBack,
    required GdsTextField field,
  }) {
    return _Search(key: key, onBack: onBack, field: field);
  }

  /// Top Navigation의 `DM` 타입을 빌드합니다.
  static Widget dm({
    Key? key,
    required String displayName,
    required String userId,
    required VoidCallback onBack,
    required VoidCallback onReport,
    required VoidCallback onSignOut,
    required VoidCallback onProfile,
    String? avatarImageUrl,
  }) {
    return _Dm(
      key: key,
      displayName: displayName,
      userId: userId,
      onBack: onBack,
      onReport: onReport,
      onSignOut: onSignOut,
      onProfile: onProfile,
      avatarImageUrl: avatarImageUrl,
    );
  }

  /// Top Navigation의 `Editor` 타입을 빌드합니다.
  static Widget editor({
    Key? key,
    required String title,
    required String label,
    VoidCallback? onBack,
    VoidCallback? onTitle,
    required VoidCallback onSave,
    required bool saveEnabled,
  }) {
    return _Editor(
      key: key,
      title: title,
      label: label,
      onBack: onBack,
      onTitle: onTitle,
      onSave: onSave,
      saveEnabled: saveEnabled,
    );
  }

  /// Top Navigation의 `ImageViewer` 타입을 빌드합니다.
  static Widget imageViewer({
    Key? key,
    required VoidCallback onClose,
    required VoidCallback onDownload,
    bool showDownload = true,
  }) {
    return _ImageViewer(
      key: key,
      onClose: onClose,
      onDownload: onDownload,
      showDownload: showDownload,
    );
  }

  /// Top Navigation의 아이콘 버튼들을 빌드합니다.
  static Widget _buildNavigationIcons({
    required BuildContext context,
    required VoidCallback onSearch,
    required VoidCallback onAvatar,
    required VoidCallback onNotification,
    String? avatarImageUrl,
    required bool hasNotification,
  }) {
    final colors = context.gdsColors;
    final bellIcon = hasNotification ? GdsIcon.bellFill : GdsIcon.bellOutline;
    final notification = GdsGesture(
      onTap: onNotification,
      child: bellIcon.build(color: colors.icon.grayBold),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: GdsSpacing.spacing16,
      children: [
        GdsGesture(
          onTap: onSearch,
          child: GdsIcon.magnifierOutline.build(color: colors.icon.grayBold),
        ),
        // 알림 아이콘에 푸시 배지.
        if (hasNotification) ...[
          GdsDotPushBadge(child: notification),
        ] else ...[
          notification,
        ],
        GdsGesture(
          onTap: onAvatar,
          child: GdsPersonAvatar(
            size: GdsAvatarSize.xs,
            imageUrl: avatarImageUrl,
          ),
        ),
      ],
    );
  }

  /// Top Navigation의 뒤로가기 버튼과 제목을 포함하는 레이아웃을 빌드합니다.
  static Widget _buildWithBackButton({
    required BuildContext context,
    required VoidCallback onBack,
    required Widget body,
    EdgeInsets padding = const EdgeInsets.all(GdsSpacing.spacing16),
  }) {
    final colors = context.gdsColors;

    return Padding(
      padding: padding,
      child: Row(
        spacing: GdsSpacing.spacing8,
        children: [
          GdsGesture(
            onTap: onBack,
            child: GdsIcon.chevronLeft.build(color: colors.icon.grayBold),
          ),
          Expanded(child: body),
        ],
      ),
    );
  }
}

/// 해당 위젯은 디자인 시스템에 따라 구현된 Top Navigation의 `Main` 타입 컴포넌트입니다.
/// 화면 상단에 위치하며, 로고, 검색 버튼, 알림 버튼, 프로필 버튼을 포함합니다.
class _Main extends StatelessWidget {
  const _Main({
    super.key,
    required this.onSearch,
    required this.onAvatar,
    required this.onNotification,
    this.avatarImageUrl,
    required this.hasNotification,
  });

  /// 검색 버튼이 탭될 때 호출되는 콜백 함수입니다.
  final VoidCallback onSearch;

  /// 알림 버튼이 탭될 때 호출되는 콜백 함수입니다.
  final VoidCallback onNotification;

  /// 아바타 버튼이 탭될 때 호출되는 콜백 함수입니다.
  final VoidCallback onAvatar;

  /// 프로필 아바타 이미지의 URL입니다.
  final String? avatarImageUrl;

  /// 알림이 있는지에 대한 여부입니다.
  final bool hasNotification;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Padding(
      padding: EdgeInsets.all(GdsSpacing.spacing16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GdsIcon.logo.build(width: 100, color: colors.graphic.bold),
          GdsTopNavigation._buildNavigationIcons(
            context: context,
            onSearch: onSearch,
            onAvatar: onAvatar,
            onNotification: onNotification,
            avatarImageUrl: avatarImageUrl,
            hasNotification: hasNotification,
          ),
        ],
      ),
    );
  }
}

/// 해당 위젯은 디자인 시스템에 따라 구현된 Top Navigation의 `Title` 타입 컴포넌트입니다.
class _Title extends StatelessWidget {
  const _Title({
    super.key,
    required this.title,
    required this.onBack,
    required this.onSearch,
    required this.onAvatar,
    required this.onNotification,
    this.avatarImageUrl,
    required this.hasNotification,
    this.showTitle = true,
    this.showIcons = true,
  });

  /// 제목 텍스트입니다.
  final String title;

  /// 뒤로가기 버튼이 탭될 때 호출되는 콜백 함수입니다.
  final VoidCallback onBack;

  /// 검색 버튼이 탭될 때 호출되는 콜백 함수입니다.
  final VoidCallback onSearch;

  /// 알림 버튼이 탭될 때 호출되는 콜백 함수입니다.
  final VoidCallback onNotification;

  /// 아바타 버튼이 탭될 때 호출되는 콜백 함수입니다.
  final VoidCallback onAvatar;

  /// 프로필 아바타 이미지의 URL입니다.
  final String? avatarImageUrl;

  /// 알림이 있는지에 대한 여부입니다.
  final bool hasNotification;

  /// 제목 텍스트를 표시할지 여부입니다.
  final bool showTitle;

  /// 오른쪽 아이콘을 표시할지 여부입니다.
  final bool showIcons;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return GdsTopNavigation._buildWithBackButton(
      context: context,
      onBack: onBack,
      body: Row(
        children: [
          if (showTitle) ...[
            Text(title, style: GdsTypography.subtitle2.copyWith(color: colors.text.grayBold)),
          ],

          Expanded(child: SizedBox()),

          if (showIcons) ...[
            GdsTopNavigation._buildNavigationIcons(
              context: context,
              onSearch: onSearch,
              onAvatar: onAvatar,
              onNotification: onNotification,
              avatarImageUrl: avatarImageUrl,
              hasNotification: hasNotification,
            ),
          ],
        ],
      ),
    );
  }
}

/// 해당 위젯은 디자인 시스템에 따라 구현된 Top Navigation의 `IconButton` 타입 컴포넌트입니다.
class _IconButton extends StatelessWidget {
  const _IconButton({
    super.key,
    required this.title,
    required this.onBack,
    required this.icons,
    required this.onIconTap,
    this.showTitle = true,
    this.showIcons = true,
  });

  /// 제목 텍스트입니다.
  final String title;

  /// 뒤로가기 버튼이 탭될 때 호출되는 콜백 함수입니다.
  final VoidCallback onBack;

  /// 아이콘 버튼 목록입니다. 최대 3개까지 허용됩니다.
  final List<GdsIcon> icons;

  /// 각 아이콘 버튼이 탭될 때 호출되는 콜백 함수 목록입니다.
  /// 아이콘과 콜백 목록의 길이는 동일해야 합니다.
  final List<VoidCallback> onIconTap;

  /// 제목 텍스트를 표시할지 여부입니다.
  final bool showTitle;

  /// 오른쪽 아이콘을 표시할지 여부입니다.
  final bool showIcons;

  @override
  Widget build(BuildContext context) {
    assert(showIcons ? icons.isNotEmpty : true, '주어진 `icons` 리스트는 최소 하나 이상의 아이콘이 필요합니다.');
    assert(icons.length <= 3, '주어진 `icons` 리스트는 최대 3개까지 허용됩니다.');
    assert(onIconTap.length == icons.length, '아이콘과 콜백 리스트의 길이는 동일해야 합니다.');

    final colors = context.gdsColors;

    // 아이콘 리스트를 GdsIcon 위젯으로 변환합니다.
    final iconRows = icons.map((icon) {
      return GdsGesture(
        onTap: onIconTap[icons.indexOf(icon)],
        child: icon.build(color: context.gdsColors.icon.grayBold),
      );
    }).toList();

    return GdsTopNavigation._buildWithBackButton(
      context: context,
      onBack: onBack,
      body: Row(
        children: [
          if (showTitle) ...[
            Text(title, style: GdsTypography.subtitle2.copyWith(color: colors.text.grayBold)),
          ],

          Expanded(child: SizedBox()),

          if (showIcons) ...[
            Row(spacing: GdsSpacing.spacing16, children: iconRows),
          ],
        ],
      ),
    );
  }
}

/// 해당 위젯은 디자인 시스템에 따라 구현된 Top Navigation의 `Search` 타입 컴포넌트입니다.
class _Search extends StatelessWidget {
  _Search({
    super.key,
    required this.onBack,
    required this.field,
  }) {
    // GdsTextField의 타입이 search인지 디버그 시점에서 검증합니다.
    assert(field.type == GdsTextFieldType.search);
  }

  /// 뒤로가기 버튼이 탭될 때 호출되는 콜백 함수입니다.
  final VoidCallback onBack;

  /// 검색 입력 필드입니다. [GdsTextFieldType.search] 타입이어야 합니다.
  final GdsTextField field;

  @override
  Widget build(BuildContext context) {
    return GdsTopNavigation._buildWithBackButton(
      padding: EdgeInsets.symmetric(horizontal: GdsSpacing.spacing16),
      context: context,
      onBack: onBack,
      body: field,
    );
  }
}

/// 해당 위젯은 디자인 시스템에 따라 구현된 Top Navigation의 `DM` 타입 컴포넌트입니다.
class _Dm extends StatelessWidget {
  const _Dm({
    super.key,
    required this.displayName,
    required this.userId,
    required this.onBack,
    required this.onReport,
    required this.onSignOut,
    required this.onProfile,
    this.avatarImageUrl,
  });

  /// 사용자 이름을 표시하는 텍스트입니다.
  final String displayName;

  /// 사용자 ID를 표시하는 텍스트입니다.
  final String userId;

  /// 사용자 아바타 이미지의 URL입니다.
  final String? avatarImageUrl;

  /// 뒤로가기 버튼이 탭될 때 호출되는 콜백 함수입니다.
  final VoidCallback onBack;

  /// 신고 버튼이 탭될 때 호출되는 콜백 함수입니다.
  final VoidCallback onReport;

  /// 로그아웃 버튼이 탭될 때 호출되는 콜백 함수입니다.
  final VoidCallback onSignOut;

  /// 프로필 영역이 탭될 때 호출되는 콜백 함수입니다.
  final VoidCallback onProfile;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return GdsTopNavigation._buildWithBackButton(
      context: context,
      onBack: onBack,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: GdsSpacing.spacing8,
        children: [
          GdsGesture(
            onTap: onProfile,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: GdsSpacing.spacing8,
              children: [
                GdsPersonAvatar(size: GdsAvatarSize.md, imageUrl: avatarImageUrl),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  spacing: GdsSpacing.spacing2,
                  children: [
                    Text(displayName, style: GdsTypography.label3.copyWith(color: colors.text.grayBold)),
                    Text(userId, style: GdsTypography.label6.copyWith(color: colors.text.graySubtle)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: GdsSpacing.spacing8,
              children: [
                GdsGesture(
                  onTap: onReport,
                  child: GdsIcon.sirenOutline.build(color: colors.icon.grayBold),
                ),
                GdsGesture(
                  onTap: onSignOut,
                  child: GdsIcon.signOut.build(color: colors.icon.grayBold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 해당 위젯은 디자인 시스템에 따라 구현된 Top Navigation의 `Editor` 타입 컴포넌트입니다.
class _Editor extends StatelessWidget {
  const _Editor({
    super.key,
    required this.title,
    required this.label,
    required this.onBack,
    required this.onTitle,
    required this.onSave,
    required this.saveEnabled,
  });

  /// 제목 텍스트입니다.
  final String title;

  /// 저장 버튼의 레이블 텍스트입니다.
  final String label;

  /// 뒤로가기 버튼이 탭될 때 호출되는 콜백 함수입니다.
  final VoidCallback? onBack;

  /// 제목이 탭될 때 호출되는 콜백 함수입니다.
  final VoidCallback? onTitle;

  /// 저장 버튼이 탭될 때 호출되는 콜백 함수입니다.
  final VoidCallback onSave;

  /// 저장 버튼이 활성화되어야 하는지 여부입니다.
  final bool saveEnabled;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return GdsTopNavigation._buildWithBackButton(
      context: context,
      onBack: onBack ?? () => Navigator.pop(context),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GdsGesture(
              onTap: onTitle,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: GdsSpacing.spacing4,
                children: [
                  Text(title, style: GdsTypography.subtitle2.copyWith(color: colors.text.grayBold)),
                  GdsIcon.chevronDown.build(color: context.gdsColors.icon.grayBold, width: GdsIconSize.v20),
                ],
              ),
            ),
          ),
          GdsTextButton(
            text: label,
            onPressed: onSave,
            enabled: saveEnabled,
          ),
        ],
      ),
    );
  }
}

/// 해당 위젯은 디자인 시스템에 따라 구현된 Top Navigation의 `ImageViewer` 타입 컴포넌트입니다.
class _ImageViewer extends StatelessWidget {
  const _ImageViewer({
    super.key,
    required this.onClose,
    required this.onDownload,
    required this.showDownload,
  });

  /// 닫기 버튼이 탭될 때 호출되는 콜백 함수입니다.
  final VoidCallback onClose;

  /// 다운로드 버튼이 탭될 때 호출되는 콜백 함수입니다.
  final VoidCallback onDownload;

  /// 다운로드 버튼을 표시할지 여부입니다.
  final bool showDownload;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Container(
      padding: EdgeInsets.all(GdsSpacing.spacing16),
      color: colors.bg.overlayBlack,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GdsGesture(
            onTap: onClose,
            child: GdsIcon.xMark.build(color: context.gdsColors.icon.grayBold),
          ),

          if (showDownload) ...[
            GdsGesture(
              onTap: onDownload,
              child: GdsIcon.download.build(color: context.gdsColors.icon.grayBold),
            ),
          ],
        ],
      ),
    );
  }
}
