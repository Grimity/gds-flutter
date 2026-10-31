// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

/// 카테고리 항목에 표시할 라벨과 숫자 정보를 정의하는 인터페이스.
class GdsCategoryItem {
  const new({
    required this.label,
    this.count,
  });

  final String label;
  final int? count;
}
