import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 목록에서 선택할 상세 페이지의 공통 속성을 정의하는 믹스인.
mixin GdsListDetailPage on Widget {
  /// 목록 항목에 표시할 아이콘.
  GdsIcon get icon;

  /// 목록 항목에 표시할 라벨 및 제목.
  String get title;

  /// 상세 콘텐츠를 상단 내비게이션이 있는 모바일 페이지로 구성합니다.
  Widget buildView(BuildContext context) {
    return GdsScaffold(
      appBar: GdsTopNavigation.iconButton(
        onBack: context.pop,
        title: title,
        actions: const [],
      ),
      body: this,
    );
  }
}
