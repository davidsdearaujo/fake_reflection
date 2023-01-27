export 'tokens/double_token.dart';
export 'tokens/eof_token.dart';
export 'tokens/identifier_token.dart';
export 'tokens/integer_token.dart';
export 'tokens/string_token.dart';
export 'tokens/symbol_token.dart';

abstract class Token {
  Token(this.line, this.column);
  final int line;
  final int column;
}
