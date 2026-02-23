import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(name: 'default', type: GdsCircularLoading)
Widget buildGdsCircularLoadingUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'CircularLoading',
    description: '데이터 로딩 시 사용하는 원형 로딩 인디케이터입니다.',
    children: [
      _buildCircularPlaygroundSection(context),
    ],
  );
}

Widget _buildCircularPlaygroundSection(BuildContext context) {
  final size = context.knobs.double.slider(label: 'size', initialValue: 80, min: 24, max: 200);

  return WidgetbookPlayground(
    info: ['size: ${size.toInt()}px'],
    child: GdsCircularLoading(width: size, height: size),
  );
}

@widgetbook.UseCase(name: 'default', type: GdsRefreshLoading)
Widget buildGdsRefreshLoadingUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'RefreshLoading',
    description: '당겨서 새로고침 후 로딩 중일 때 표시되는 애니메이션입니다.',
    children: [
      _buildRefreshLoadingPlaygroundSection(context),
    ],
  );
}

Widget _buildRefreshLoadingPlaygroundSection(BuildContext context) {
  final size = context.knobs.double.slider(label: 'size', initialValue: 80, min: 24, max: 200);

  return WidgetbookPlayground(
    info: ['size: ${size.toInt()}px'],
    child: GdsRefreshLoading(width: size, height: size),
  );
}

@widgetbook.UseCase(name: 'default', type: GdsRefreshDragging)
Widget buildGdsRefreshDraggingUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'RefreshDragging',
    description: '당겨서 새로고침 중 드래그 상태를 표시하는 애니메이션입니다.',
    children: [
      _buildRefreshDraggingPlaygroundSection(context),
    ],
  );
}

Widget _buildRefreshDraggingPlaygroundSection(BuildContext context) {
  final size = context.knobs.double.slider(label: 'size', initialValue: 80, min: 24, max: 200);

  return WidgetbookPlayground(
    info: ['size: ${size.toInt()}px'],
    child: GdsRefreshDragging(width: size, height: size),
  );
}
