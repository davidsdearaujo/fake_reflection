import '../token.dart';

class StringToken extends Token {
  const StringToken(this.value, int line, int column) : super(line, column);
  final String value;

  @override
  String toString() => '"$value"';
}
