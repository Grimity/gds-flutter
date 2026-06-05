import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(
  name: 'default',
  type: GdsMenu,
  path: '[component]/[gnb]',
)
Widget buildGdsMenuUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Menu',
    children: [
      _buildPlaygroundSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  return WidgetbookPlayground(
    info: [],
    child: Center(
      child: GdsMenuAnchor(
        builder: (link) {
          return GdsMenu(
            items: [
              [
                GdsMenuItem(label: '내 프로필', onTap: () => debugPrint('내 프로필')),
              ],
              [
                GdsMenuItem(label: '좋아요한 그림', onTap: () => debugPrint('좋아요한 그림')),
                GdsMenuItem(label: '저장한 그림', onTap: () => debugPrint('저장한 그림')),
                GdsMenuItem(label: '저장한 글', onTap: () => debugPrint('저장한 글')),
              ],
              [
                GdsMenuItem(label: '설정', onTap: () => debugPrint('설정')),
                GdsMenuItem(label: '로그아웃', onTap: () => debugPrint('로그아웃')),
              ],
            ],
          );
        },
      ),
    ),
  );
}
