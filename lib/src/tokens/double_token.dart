import '../token.dart';

class DoubleToken extends Token {
  DoubleToken(this.value, int line, int column) : super(line, column);
  final double value;

  @override
  String toString() => '$value';
}
