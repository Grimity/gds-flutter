/// 디자인 시스템에서 제공하는 [DateTime]에 대한 유틸리티 확장.
extension GdsDateTimeExtension on DateTime {
  /// 현재 시각을 기준으로 경과한 시간을 반환합니다.
  String get timeAgo {
    final difference = DateTime.now().difference(this);

    if (difference.isNegative || difference.inMinutes < 1) return '방금 전';
    if (difference.inHours < 1) return '${difference.inMinutes}분 전';
    if (difference.inDays < 1) return '${difference.inHours}시간 전';
    if (difference.inDays < 30) return '${difference.inDays}일 전';
    if (difference.inDays < 365) return '${difference.inDays ~/ 30}달 전';
    return '${difference.inDays ~/ 365}년 전';
  }
}
