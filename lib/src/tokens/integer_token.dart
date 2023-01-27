import '../token.dart';

class IntegerToken extends Token {
  IntegerToken(this.value, int line, int column) : super(line, column);
  final int value;

  @override
  String toString() => '$value';
}
