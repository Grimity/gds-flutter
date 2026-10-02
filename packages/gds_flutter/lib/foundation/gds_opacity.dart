///
enum GdsOpacity {
  opacity80(204), // 80%
  opacity60(153), // 60%
  opacity40(102), // 40%
  opacity20(51), // 20%
  opacity10(25); // 10%

  const GdsOpacity(this.alpha);

  final int alpha;
}
