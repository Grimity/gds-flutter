import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 모바일에서는 목록에서 선택한 상세 페이지를 새 화면으로 열고,
/// 태블릿에서는 목록과 상세 페이지를 한 화면에 함께 표시하는 위젯.
class GdsListDetail extends StatefulWidget {
  const new({
    super.key,
    required this.title,
    required this.pages,
  }) : assert(pages.length != 0);

  final String title;
  final List<GdsListDetailPage> pages;

  /// 현재 컨텍스트에서 가장 가까운 [GdsListDetailState]를 반환합니다.
  static GdsListDetailState of(BuildContext context) {
    final result = context.findAncestorStateOfType<GdsListDetailState>();
    if (result == null) {
      throw StateError('현재 컨텍스트에서 GdsListDetail을 찾을 수 없습니다.');
    }

    return result;
  }

  @override
  State<GdsListDetail> createState() => GdsListDetailState();
}

/// 목록 선택 상태와 상세 페이지 전환을 관리합니다.
class GdsListDetailState extends State<GdsListDetail> {
  /// 현재 선택된 상세 페이지의 인덱스.
  int index = 0;

  /// 상세 페이지 전환 애니메이션의 이동 방향.
  AxisDirection direction = .up;

  /// 선택한 페이지를 모바일에서는 열고 태블릿에서는 상세 영역에 표시합니다.
  void select(int newIndex) {
    assert(newIndex >= 0);
    assert(newIndex < widget.pages.length);
    final page = widget.pages[newIndex];

    // 기기 유형과 관계없이 페이지 자체를 바로 라우트로 열기.
    if (page.pushDirectly) {
      context.push(page);
      return;
    }

    if (context.isMobile) {
      final view = page.buildView(context);

      context.push(view);
    } else if (index != newIndex) {
      setState(() {
        direction = newIndex > index ? .up : .down;
        index = newIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 상세 페이지 선택 목록 위젯.
    final list = ListView.builder(
      itemCount: widget.pages.length,
      itemBuilder: (context, index) {
        final page = widget.pages[index];

        return GdsListItem.icon(
          icon: page.icon,
          label: page.title,
          onTap: () => select(index),

          // 태블릿에서만 현재 항목을 선택 상태로 표시
          status: .from(selected: context.isTablet && this.index == index),
        );
      },
    );

    return GdsScaffold(
      appBar: GdsTopNavigation.iconButton(
        onBack: context.pop,
        title: widget.title,
        actions: const [],
      ),
      body: Row(
        children: [
          // 상세 페이지를 선택하는 목록 표시
          if (context.isTablet) ...[
            SizedBox(width: 240, child: list),
          ] else ...[
            Expanded(child: list),
          ],

          // 태블릿에서만 상세 페이지 표시
          if (context.isTablet) ...[
            Expanded(
              child: GdsPageTransition(
                direction: direction,
                child: KeyedSubtree(
                  key: ValueKey(index),
                  child: widget.pages[index],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
