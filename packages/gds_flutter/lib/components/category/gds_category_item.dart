/// 카테고리 항목에 표시할 라벨과 숫자 정보를 정의하는 인터페이스.
class GdsCategoryItem {
  const GdsCategoryItem({
    required this.label,
    this.count,
  });

  final String label;
  final int? count;
}
