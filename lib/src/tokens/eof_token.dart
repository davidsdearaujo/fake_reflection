import '../token.dart';

class EofToken extends Token {
  const EofToken(int line, int column) : super(line, column);

  @override
  String toString() => '<EOF>';
}
