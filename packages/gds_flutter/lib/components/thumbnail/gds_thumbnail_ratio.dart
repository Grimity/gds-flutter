/// 썸네일 이미지의 가로 세로 비율을 나타내는 열거형.
enum GdsThumbnailRatio {
  square(1, 1), // 1:1
  classic(5, 4), // 5:4
  standard(4, 3), // 4:3
  classicPhoto(3, 2), // 3:2
  golden(16, 10), // 16:10
  widescreen(16, 9), // 16:9
  cinema(2, 1), // 2:1
  ultrawide(21, 9), // 21:9
  banner(4, 1), // 4:1
  portrait(3, 4); // 3:4

  const new(this.width, this.height);

  // 각 비율의 가로와 세로 길이를 나타내는 정수 값.
  final int width;
  final int height;

  /// 비율의 실제 값(가로 길이 / 세로 길이)을 반환합니다.
  double get value => width / height;
}
