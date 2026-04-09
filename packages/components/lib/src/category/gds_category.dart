import 'package:flutter/material.dart';
import 'package:gds_components/src/button/button.dart';
import 'package:gds_components/src/common/common.dart';
import 'package:gds_foundation/gds_foundation.dart';

enum GdsCategorySize {
  lg,
  md,
}

class GdsCategoryItem {
  const GdsCategoryItem({
    required this.label,
    required this.onTap,
    required this.isActive,
  });

  final String label;
  final VoidCallback onTap;
  final bool isActive;
}

class GdsCategoryAction {
  const GdsCategoryAction({
    required this.icon,
    required this.onTap,
  });

  final GdsIcon icon;
  final VoidCallback onTap;
}

class GdsCategory extends StatefulWidget {
  const GdsCategory({
    super.key,
    required this.items,
    this.action,
    this.size = GdsCategorySize.lg,
  });

  final List<GdsCategoryItem> items;
  final GdsCategoryAction? action;
  final GdsCategorySize size;

  @override
  State<GdsCategory> createState() => _GdsCategoryState();
}

class _GdsCategoryState extends State<GdsCategory> {
  final _controller = ScrollController();

  /// 카테고리 리스트가 좌측에서 마스킹이 필요한지 여부
  bool _canMaskingRight = false;

  /// 카테고리 리스트가 우측에서 마스킹이 필요한지 여부
  bool _canMaskingLeft = false;

  /// 카테고리 리스트의 스크롤 위치에 따라 마스킹 적용 여부를 계산하여 상태 변경
  void _applyMarking() {
    bool needsMasking = _controller.position.maxScrollExtent > 0;
    bool oldCanMaskingRight = _canMaskingRight;
    bool oldCanMaskingLeft = _canMaskingLeft;

    print(_canMaskingRight);
    print(_canMaskingLeft);

    if (needsMasking) {
      // 스크롤 위치가 변경될 때마다 마스킹 적용
      _canMaskingRight = _controller.offset < _controller.position.maxScrollExtent;
      _canMaskingLeft = _controller.offset > _controller.position.minScrollExtent;
    } else {
      // 스크롤이 필요 없는 경우, 마스킹 적용하지 않음
      _canMaskingRight = false;
      _canMaskingLeft = false;
    }

    // 마스킹 적용 여부가 변경된 경우에만 상태 변경
    if (oldCanMaskingLeft != _canMaskingLeft
     || oldCanMaskingRight != _canMaskingRight) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    // 위젯이 처음 렌더링된 후에 마스킹 적용 여부 계산
    WidgetsBinding.instance.addPostFrameCallback((_) => _applyMarking());

    // 스크롤 위치가 변경될 때마다 마스킹 적용
    _controller.addListener(() => setState(_applyMarking));
  }

  @override
  void didUpdateWidget(covariant GdsCategory oldWidget) {
    super.didUpdateWidget(oldWidget);
    _applyMarking();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: GdsSpacing.spacing16,
      children: [
        Expanded(
          child: Stack(
            children: [
              NotificationListener<ScrollMetricsNotification>(
                onNotification: (notification) {
                  _applyMarking();
                  return true;
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: GdsSpacing.spacing8,
                    children: [
                      for (final item in widget.items)
                        _Category(item: item, size: widget.size),
                    ],
                  ),
                ),
              ),

              // 카테고리 리스트가 좌측에서 마스킹이 필요한 경우
              if (_canMaskingLeft)
                Align(
                  alignment: Alignment.centerLeft,
                  child: _buildMasking(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),

              // 카테고리 리스트가 우측에서 마스킹이 필요한 경우
              if (_canMaskingRight)
                Align(
                  alignment: Alignment.centerRight,
                  child: _buildMasking(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                  ),
                ),
            ],
          ),
        ),

        // 버튼이 존재할 경우, 카테고리 리스트 오른쪽에 추가
        if (widget.action != null) ...[
          GdsIconButton(
            icon: widget.action!.icon,
            onPressed: widget.action!.onTap,
            type: GdsIconButtonType.outlined,
          ),
        ],
      ],
    );
  }

  /// 카테고리 리스트의 양쪽 끝에 페이드 효과를 적용하는 마스킹 위젯을 빌드
  Widget _buildMasking({
    required Alignment begin,
    required Alignment end,
  }) {
    final colors = context.gdsColors;

    return Container(
      width: GdsSpacing.spacing40,
      height: GdsSpacing.spacing40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: [
            colors.surface.base.withAlpha(255),
            colors.surface.base.withAlpha(0),
          ],
        ),
      ),
    );
  }
}

class _Category extends StatelessWidget {
  const _Category({
    super.key,
    required this.item,
    required this.size,
  });

  final GdsCategoryItem item;
  final GdsCategorySize size;

  TextStyle get _textStyle {
    return switch (size) {
      GdsCategorySize.lg => GdsTypography.label1,
      GdsCategorySize.md => GdsTypography.label3,
    };
  }

  double get _verticalPadding {
    return switch (size) {
      GdsCategorySize.lg => GdsSpacing.spacing8,
      GdsCategorySize.md => GdsSpacing.spacing6,
    };
  }

  double get _horizontalPadding {
    return switch (size) {
      GdsCategorySize.lg => GdsSpacing.spacing16,
      GdsCategorySize.md => GdsSpacing.spacing12,
    };
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return GdsGesture(
      onTap: item.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: _verticalPadding,
          horizontal: _horizontalPadding,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(GdsRadius.full),
          color: item.isActive ? colors.surface.primaryNormal : null,
          border: Border.all(
            color: item.isActive
              ? colors.surface.primaryNormal
              : colors.border.graySubtle,
          ),
        ),
        child: Text(
          item.label,
          style: _textStyle.copyWith(
            color: item.isActive
              ? colors.text.white
              : colors.surface.grayBold,
          ),
        ),
      ),
    );
  }
}
