// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 프로필, 최근 메시지, 경과 시간 등을 표시하는 DM 목록의 항목 위젯.
class GdsDmList extends StatelessWidget {
  const new({
    super.key,
    this.active = false,
    required this.profile,
    required this.nickname,
    required this.message,
    required this.createdAt,
    this.unreadCount = 0,
    required this.onTap,
  });

  final bool active;
  final ImageProvider? profile;
  final String nickname;
  final String message;
  final DateTime createdAt;
  final int unreadCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GdsGesture(
      onTap: onTap,
      child: GdsContainer(
        padding: .symmetric(vertical: 12),
        color: active ? .surfaceGraySubtler : null,
        child: Row(
          children: [
            // 프로필 이미지, 닉네임, 경과 시간, 메시지 표시
            Expanded(
              child: Row(
                spacing: 12,
                children: [
                  GdsProfile(size: .md, image: profile),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      mainAxisSize: .min,
                      spacing: 4,
                      children: [
                        // 닉네임, 경과 시간 표시
                        Row(
                          spacing: 4,
                          children: GdsDot.separated([
                            GdsText(
                              nickname,
                              color: .textGrayNormal,
                              style: .label5,
                            ),

                            GdsText(
                              createdAt.timeAgo,
                              color: .textGrayNormal,
                              style: .label6,
                            ),
                          ]),
                        ),

                        // 메시지 내용을 한 줄로 표시
                        GdsText(
                          message,
                          color: .textGrayBold,
                          style: .body2R,
                          maxLines: 1,
                          overflow: .ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 읽지 않은 메시지 개수를 배지로 표시
            GdsFoldable.builder(
              alignment: .centerRight,
              visible: unreadCount > 0,
              axis: .horizontal,
              builder: (context) {
                return Padding(
                  padding: .only(left: 12),
                  child: GdsPushBadge.number(
                    variant: .solid,
                    value: unreadCount,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
