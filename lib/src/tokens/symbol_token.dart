import '../token.dart';

class SymbolToken extends Token {
  SymbolToken(this.symbol, int line, int column) : super(line, column);
  final int symbol;

  static const int dot = 0x2E;
  static const int tripleDot = 0x2026;
  static const int openParen = 0x28; // U+0028 LEFT PARENTHESIS character (()
  static const int closeParen = 0x29; // U+0029 RIGHT PARENTHESIS character ())
  static const int comma = 0x2C; // U+002C COMMA character (,)
  static const int colon = 0x3A; // U+003A COLON character (:)
  static const int semicolon = 0x3B; // U+003B SEMICOLON character (;)
  static const int equals = 0x3D; // U+003D EQUALS SIGN character (=)
  static const int openBracket = 0x5B; // U+005B LEFT SQUARE BRACKET character ([)
  static const int closeBracket = 0x5D; // U+005D RIGHT SQUARE BRACKET character (])
  static const int openBrace = 0x7B; // U+007B LEFT CURLY BRACKET character ({)
  static const int closeBrace = 0x7D; // U+007D RIGHT CURLY BRACKET character (})
  static const int moreThan = 0x3E; // U+003E MORE THAN character (>)
  static const int lessThan = 0x3C; // U+003C LESS THAN character (<)
  static const int question = 0x3F; // U+003F QUESTION character (?)

  @override
  String toString() => String.fromCharCode(symbol);
}
