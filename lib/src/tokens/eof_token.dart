import '../token.dart';

class EofToken extends Token {
  EofToken(int line, int column) : super(line, column);

  @override
  String toString() => '<EOF>';
}
