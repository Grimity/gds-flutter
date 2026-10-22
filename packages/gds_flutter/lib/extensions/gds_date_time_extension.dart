import 'package:intl/intl.dart';

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

  /// 오늘 날짜인지 여부.
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// 이번 달 날짜인지 여부.
  bool get isThisMonth {
    final now = DateTime.now();
    return year == now.year && month == now.month;
  }

  /// 올해 날짜인지 여부.
  bool get isThisYear => year == DateTime.now().year;

  /// 날짜를 yyyy-MM-dd 형식의 문자열로 반환합니다.
  String get yearMonthDay {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  /// 날짜를 yyyy-MM 형식의 문자열로 반환합니다.
  String get yearMonth {
    return DateFormat('yyyy-MM').format(this);
  }

  /// 날짜를 yyyy.MM.dd 형식 혹은 '오늘' 문자열로 반환합니다.
  String get dateLabel {
    return isToday ? '오늘' : DateFormat('yyyy.MM.dd').format(this);
  }

  /// 날짜를 yyyy년 MM월 형식 혹은 MM월 문자열로 반환합니다.
  String get yearMonthLabel {
    return isThisYear ? '$month월' : DateFormat('yyyy년 MM월').format(this);
  }
}
