import '../token.dart';

class DoubleToken extends Token {
  const DoubleToken(this.value, line, int column) : super(line, column);
  final double value;

  @override
  String toString() => '$value';
}
