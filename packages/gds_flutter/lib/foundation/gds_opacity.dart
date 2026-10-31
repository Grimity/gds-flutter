// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

///
enum GdsOpacity {
  opacity80(204), // 80%
  opacity60(153), // 60%
  opacity40(102), // 40%
  opacity20(51), // 20%
  opacity10(25); // 10%

  const new(this.alpha);

  final int alpha;
}
