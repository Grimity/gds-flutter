import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(
  name: 'default',
  type: GdsSidebarNavigation,
  path: '[component]/[navigation]',
)
Widget buildGdsSidebarNavigationUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Bottom Navigation',
    children: [
      _buildPlaygroundSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final size = context.knobs.list<GdsSidebarNavigationSize>(
    label: 'size',
    options: GdsSidebarNavigationSize.values,
    labelBuilder: (type) => type.displayName,
  );

  final height = context.knobs.int.slider(
    label: 'height',
    min: 300,
    max: 600,
    initialValue: 600,
  );

  final dotBadge = context.knobs.boolean(
    label: 'dotBadge',
    initialValue: false,
  );

  return WidgetbookPlayground(
    info: [
      'size: ${size.displayName}',
      'height: ${height}px',
      'dotBadge: $dotBadge',
    ],
    child: ConstrainedBox(
      constraints: BoxConstraints(maxHeight: height.toDouble()),
      child: GdsSidebarNavigation(
        size: size,
        userImageUrl: null,
        userName: '체리마루',
        userId: '@CherryMaru',
        followerCount: 123,
        followingCount: 32,
        menuItems: [
          GdsSidebarNavigationItem(icon: GdsIcon.heartOutline, label: '좋아요한 그림', onTap: () {}, dotPushBadge: dotBadge),
          GdsSidebarNavigationItem(icon: GdsIcon.bookmarkOutline, label: '저장한 글', onTap: () {}),
        ],
      ),
    ),
  );
}
