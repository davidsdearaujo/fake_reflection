import '../token.dart';

class IntegerToken extends Token {
  const IntegerToken(this.value, int line, int column) : super(line, column);
  final int value;

  @override
  String toString() => '$value';
}
