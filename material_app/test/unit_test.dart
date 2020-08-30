import 'package:flutter_test/flutter_test.dart';
import '../lib/screens/screens.dart';

//* writing a simple unit test
void main() {
  //* provide the description of your test
  test('this function should return null if name is valid', () {
    //* store the result in a variable
    final result = NameValidator.validate('john');
    //* check if the result was as expected
    expect(result, null);
  });

  test('this function should throw error for an invalid name', () {
    final result = NameValidator.validate('ab');
    expect(result, 'Enter a valid name');
  });
}
