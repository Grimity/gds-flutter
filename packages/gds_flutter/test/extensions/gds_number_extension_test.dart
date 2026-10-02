import 'package:flutter_test/flutter_test.dart';
import 'package:gds_flutter/gds_flutter.dart';

void main() {
  test('숫자의 정수 부분을 세 자리마다 쉼표로 구분한다', () {
    expect(0.comma, '0');
    expect(999.comma, '999');
    expect(1000.comma, '1,000');
    expect(10000.comma, '10,000');
    expect(100000.comma, '100,000');
    expect(123456789.comma, '123,456,789');
    expect((-1234567).comma, '-1,234,567');
    expect(12345.67.comma, '12,345.67');
  });

  test('천 미만은 단위 없이 반환한다', () {
    expect(0.compact, '0');
    expect(999.compact, '999');
    expect(12.5.compact, '12.5');
  });

  test('천 단위로 반환한다', () {
    expect(1000.compact, '1천');
    expect(1234.compact, '1.2천');
    expect(9999.compact, '9.9천');
  });

  test('만 이상의 한국어 단위로 반환한다', () {
    expect(10000.compact, '1만');
    expect(123456.compact, '12.3만');
    expect(90000000.compact, '9천만');
    expect(100000000.compact, '1억');
    expect(900000000000.compact, '9천억');
    expect(1200000000000.compact, '1.2조');
    expect(9000000000000000.compact, '9천조');
    expect(10000000000000000.compact, '1경');
  });

  test('무한대는 특수문자 문자로 반환한다', () {
    expect(double.infinity.compact, '∞');
  });
}
