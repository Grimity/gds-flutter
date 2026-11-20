// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsListDetail]에 대한 프리뷰 위젯.
class GdsListDetailPreview extends PreviewWidget {
  @override
  String get displayName => 'List Detail';

  @override
  List<String> get groups => ['Micro Interaction'];

  @override
  Widget build(BuildContext context) {
    return GdsListDetail(
      title: '설정',
      pages: [
        _Page(icon: .person, title: '내 계정'),
        _Page(icon: .pallete, title: '화면 테마'),
        _Page(icon: .bell, title: '알림'),
        _Page(icon: .infoCircle, title: '이용 안내'),
        _Page(icon: .questionCircle, title: '문의하기'),
      ],
    );
  }
}

/// [GdsListDetail]의 상세 영역에 표시하는 프리뷰용 페이지.
class _Page extends StatelessWidget with GdsListDetailPage {
  const new({
    required this.title,
    required this.icon,
  });

  @override
  final String title;

  @override
  final GdsIcon icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GdsText(
        title,
        color: .textGrayBold,
        style: .title2,
      ),
    );
  }
}
