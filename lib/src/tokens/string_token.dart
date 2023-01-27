import '../token.dart';

class StringToken extends Token {
  StringToken(this.value, int line, int column) : super(line, column);
  final String value;

  @override
  String toString() => '"$value"';
}
