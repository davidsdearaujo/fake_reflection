import '../token.dart';

class IdentifierToken extends Token {
  const IdentifierToken(this.value, int line, int column) : super(line, column);
  final String value;

  @override
  String toString() => value;
}
