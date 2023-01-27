import 'package:fake_reflection/src/token.dart';

import 'exceptions/parser_exception.dart';
import 'models/class_data.dart';
import 'models/named_param.dart';
import 'models/positional_param.dart';

/// API for parsing Remote Flutter Widgets text files.
///
/// Text data files can be parsed by using [readDataFile]. (Unlike the binary
/// variant of this format, the root of a text data file is always a map.)
///
/// Test library files can be parsed by using [readLibraryFile].
class Parser {
  Parser(Iterable<Token> source) : _source = source.iterator..moveNext();

  final Iterator<Token> _source;

  void _advance() {
    assert(_source.current is! EofToken);
    final bool advanced = _source.moveNext();
    assert(advanced == true); // see https://github.com/dart-lang/sdk/issues/47017
  }

  bool _foundIdentifier(String identifier) {
    return (_source.current is IdentifierToken) && ((_source.current as IdentifierToken).value == identifier);
  }

  void _expectIdentifier(String value) {
    if (_source.current is! IdentifierToken) {
      throw ParserException.expected('identifier', _source.current);
    }
    if ((_source.current as IdentifierToken).value != value) {
      throw ParserException.expected(value, _source.current);
    }
    _advance();
  }

  String _readIdentifier() {
    if (_source.current is! IdentifierToken) {
      throw ParserException.expected('identifier', _source.current);
    }
    final String result = (_source.current as IdentifierToken).value;
    _advance();
    return result;
  }

  // ignore: unused_element
  String _readString() {
    if (_source.current is! StringToken) {
      throw ParserException.expected('string', _source.current);
    }
    final String result = (_source.current as StringToken).value;
    _advance();
    return result;
  }

  bool _foundSymbol(int symbol) {
    return (_source.current is SymbolToken) && ((_source.current as SymbolToken).symbol == symbol);
  }

  bool _foundAnySymbol(List<int> symbols) {
    return (_source.current is SymbolToken) && symbols.contains((_source.current as SymbolToken).symbol);
  }

  bool _maybeReadSymbol(int symbol) {
    if (_foundSymbol(symbol)) {
      _advance();
      return true;
    }
    return false;
  }

  bool _maybeReadIdentifier(String identifier) {
    if (_foundIdentifier(identifier)) {
      _advance();
      return true;
    }
    return false;
  }

  void _expectSymbol(int symbol) {
    if (_source.current is! SymbolToken) {
      throw ParserException.expected('symbol "${String.fromCharCode(symbol)}"', _source.current);
    }
    if ((_source.current as SymbolToken).symbol != symbol) {
      throw ParserException.expected('symbol "${String.fromCharCode(symbol)}"', _source.current);
    }
    _advance();
  }

  String _readType() {
    String response;
    final String name = _readIdentifier();
    response = name;
    if (_maybeReadSymbol(SymbolToken.lessThan)) {
      final genericType1 = _readType();
      response += '<$genericType1';
      if (_maybeReadSymbol(SymbolToken.question)) response += '?';
      if (_maybeReadSymbol(SymbolToken.comma)) {
        final genericType2 = _readType();
        response += ', $genericType2';
        if (_maybeReadSymbol(SymbolToken.question)) response += '?';
      }
      _expectSymbol(SymbolToken.moreThan);
      response += '>';
    }
    return response;
  }

  PositionalParam _readPositionalParam() {
    String type = _readType();
    final isNullable = _maybeReadSymbol(SymbolToken.question);
    return PositionalParam(type: type, nullable: isNullable);
  }

  Iterable<PositionalParam> _readPositionalParams() sync* {
    do {
      yield _readPositionalParam();
      _maybeReadSymbol(SymbolToken.comma);
    } while (!_foundAnySymbol([SymbolToken.openBrace, SymbolToken.closeParen]));
  }

  NamedParam _readNamedParam() {
    bool required = false;
    bool isNullable = false;
    String type;
    String? name;

    if (_maybeReadIdentifier('required')) required = true;

    type = _readType();
    isNullable = _maybeReadSymbol(SymbolToken.question);
    name = _readIdentifier();

    return NamedParam(
      name: name,
      nullable: isNullable,
      required: required,
      type: type,
    );
  }

  Iterable<NamedParam> _readNamedParams() sync* {
    do {
      yield _readNamedParam();
      _maybeReadSymbol(SymbolToken.comma);
    } while (!_foundSymbol(SymbolToken.closeBrace));
  }

  ClassData readClosureString() {
    var namedParams = <NamedParam>{};
    var positionalParams = <PositionalParam>[];
    String className;

    _expectIdentifier('Closure');
    _expectSymbol(SymbolToken.colon);
    _expectSymbol(SymbolToken.openParen);
    if (!_foundSymbol(SymbolToken.openBrace)) {
      positionalParams = _readPositionalParams().toList();
    }
    if (_maybeReadSymbol(SymbolToken.openBrace)) {
      namedParams = _readNamedParams().toSet();
      _expectSymbol(SymbolToken.closeBrace);
    }
    _expectSymbol(SymbolToken.closeParen);
    _expectSymbol(SymbolToken.equals);
    _expectSymbol(SymbolToken.moreThan);
    className = _readIdentifier();
    return ClassData(
      className: className,
      namedParams: namedParams,
      positionalParams: positionalParams,
    );
  }
}
