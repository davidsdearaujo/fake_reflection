import '../token.dart';

/// Indicates that there an error was detected while parsing a file.
///
/// This is used by [parseDataFile] and [parseLibraryFile] to indicate that the
/// given file has a syntax or semantic error.
///
/// The [line] and [column] describe how far the parser had reached when the
/// error was detected (this may not precisely indicate the actual location of
/// the error).
///
/// The [message] property is a human-readable string describing the error.
class ParserException implements Exception {
  /// Create an instance of [ParserException].
  ///
  /// The arguments must not be null. See [message] for details on
  /// the expected syntax of the error description.
  const ParserException(this.message, this.line, this.column);

  factory ParserException.fromToken(String message, Token token) {
    return ParserException(message, token.line, token.column);
  }

  factory ParserException.expected(String what, Token token) {
    return ParserException('Expected $what but found $token', token.line, token.column);
  }

  factory ParserException.unexpected(Token token) {
    return ParserException('Unexpected $token', token.line, token.column);
  }

  /// The error that was detected by the parser.
  ///
  /// This should be the start of a sentence which will make sense when " at
  /// line ... column ..." is appended. So, for example, it should not end with
  /// a period.
  final String message;

  /// The line number (using 1-based indexing) that the parser had reached when
  /// the error was detected.
  final int line;

  /// The column number (using 1-based indexing) that the parser had reached
  /// when the error was detected.
  ///
  /// This is measured in UTF-16 code units, even if the source file was UTF-8.
  final int column;

  @override
  String toString() => '$message at line $line column $column.';
}
