// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// This file is hand-formatted.

// This file must not import `dart:ui`, directly or indirectly, as it is
// intended to function even in pure Dart server or CLI environments.

// ignore_for_file: unused_field
library fake_reflection;

import 'exceptions/parser_exception.dart';
import 'models/class_data.dart';
import 'parser.dart';
import 'rune.dart';
import 'token.dart';

import 'tokenizer_mode.dart';

extension FakeReflectionExtension on Function {
  ClassData reflection() {
    final data = toString();
    final Parser parser = Parser(_tokenize(data));
    return parser.readClosureString();
  }
}

Iterable<Token> _tokenize(String data) sync* {
  final List<int> characters = data.runes.toList();
  int index = 0;
  int line = 1;
  int column = 0;
  final List<int> buffer = <int>[];
  final List<int> buffer2 = <int>[];
  TokenizerMode mode = TokenizerMode.main;

  while (true) {
    final int current;
    if (index >= characters.length) {
      current = -1;
    } else {
      current = characters[index];
      if (current == 0x0A) {
        line += 1;
        column = 0;
      } else {
        column += 1;
      }
    }
    switch (mode) {
      case TokenizerMode.main:
        switch (current) {
          case -1:
            yield EofToken(line, column);
            return;
          case 0x0A: // U+000A LINE FEED (LF)
          case 0x20: // U+0020 SPACE character
            break;
          case 0x28: // U+0028 LEFT PARENTHESIS character (()
          case 0x29: // U+0029 RIGHT PARENTHESIS character ())
          case 0x2C: // U+002C COMMA character (,)
          case 0x3A: // U+003A COLON character (:)
          case 0x3B: // U+003B SEMICOLON character (;)
          case 0x3D: // U+003D EQUALS SIGN character (=)
          case 0x5B: // U+005B LEFT SQUARE BRACKET character ([)
          case 0x5D: // U+005D RIGHT SQUARE BRACKET character (])
          case 0x7B: // U+007B LEFT CURLY BRACKET character ({)
          case 0x7D: // U+007D RIGHT CURLY BRACKET character (})
          case 0x3E: // U+003E MORE THAN character (>)
          case 0x3C: // U+003C LESS THAN character (<)
          case 0x3F: // U+003F QUESTION character (?)
            yield SymbolToken(current, line, column);
            break;
          case 0x22: // U+0022 QUOTATION MARK character (")
            assert(buffer.isEmpty);
            mode = TokenizerMode.doubleQuote;
            break;
          case 0x27: // U+0027 APOSTROPHE character (')
            assert(buffer.isEmpty);
            mode = TokenizerMode.quote;
            break;
          case 0x2D: // U+002D HYPHEN-MINUS character (-)
            assert(buffer.isEmpty);
            mode = TokenizerMode.minus;
            buffer.add(current);
            break;
          case 0x2E: // U+002E FULL STOP character (.)
            mode = TokenizerMode.dot1;
            break;
          case 0x2F: // U+002F SOLIDUS character (/)
            mode = TokenizerMode.slash;
            break;
          case 0x30: // U+0030 DIGIT ZERO character (0)
            assert(buffer.isEmpty);
            mode = TokenizerMode.zero;
            buffer.add(current);
            break;
          case 0x31: // U+0031 DIGIT ONE character (1)
          case 0x32: // U+0032 DIGIT TWO character (2)
          case 0x33: // U+0033 DIGIT THREE character (3)
          case 0x34: // U+0034 DIGIT FOUR character (4)
          case 0x35: // U+0035 DIGIT FIVE character (5)
          case 0x36: // U+0036 DIGIT SIX character (6)
          case 0x37: // U+0037 DIGIT SEVEN character (7)
          case 0x38: // U+0038 DIGIT EIGHT character (8)
          case 0x39: // U+0039 DIGIT NINE character (9)
            assert(buffer.isEmpty);
            mode = TokenizerMode.integer;
            buffer.add(current);
            break;
          case 0x41: // U+0041 LATIN CAPITAL LETTER A character
          case 0x42: // U+0042 LATIN CAPITAL LETTER B character
          case 0x43: // U+0043 LATIN CAPITAL LETTER C character
          case 0x44: // U+0044 LATIN CAPITAL LETTER D character
          case 0x45: // U+0045 LATIN CAPITAL LETTER E character
          case 0x46: // U+0046 LATIN CAPITAL LETTER F character
          case 0x47: // U+0047 LATIN CAPITAL LETTER G character
          case 0x48: // U+0048 LATIN CAPITAL LETTER H character
          case 0x49: // U+0049 LATIN CAPITAL LETTER I character
          case 0x4A: // U+004A LATIN CAPITAL LETTER J character
          case 0x4B: // U+004B LATIN CAPITAL LETTER K character
          case 0x4C: // U+004C LATIN CAPITAL LETTER L character
          case 0x4D: // U+004D LATIN CAPITAL LETTER M character
          case 0x4E: // U+004E LATIN CAPITAL LETTER N character
          case 0x4F: // U+004F LATIN CAPITAL LETTER O character
          case 0x50: // U+0050 LATIN CAPITAL LETTER P character
          case 0x51: // U+0051 LATIN CAPITAL LETTER Q character
          case 0x52: // U+0052 LATIN CAPITAL LETTER R character
          case 0x53: // U+0053 LATIN CAPITAL LETTER S character
          case 0x54: // U+0054 LATIN CAPITAL LETTER T character
          case 0x55: // U+0055 LATIN CAPITAL LETTER U character
          case 0x56: // U+0056 LATIN CAPITAL LETTER V character
          case 0x57: // U+0057 LATIN CAPITAL LETTER W character
          case 0x58: // U+0058 LATIN CAPITAL LETTER X character
          case 0x59: // U+0059 LATIN CAPITAL LETTER Y character
          case 0x5A: // U+005A LATIN CAPITAL LETTER Z character
          case 0x61: // U+0061 LATIN SMALL LETTER A character
          case 0x62: // U+0062 LATIN SMALL LETTER B character
          case 0x63: // U+0063 LATIN SMALL LETTER C character
          case 0x64: // U+0064 LATIN SMALL LETTER D character
          case 0x65: // U+0065 LATIN SMALL LETTER E character
          case 0x66: // U+0066 LATIN SMALL LETTER F character
          case 0x67: // U+0067 LATIN SMALL LETTER G character
          case 0x68: // U+0068 LATIN SMALL LETTER H character
          case 0x69: // U+0069 LATIN SMALL LETTER I character
          case 0x6A: // U+006A LATIN SMALL LETTER J character
          case 0x6B: // U+006B LATIN SMALL LETTER K character
          case 0x6C: // U+006C LATIN SMALL LETTER L character
          case 0x6D: // U+006D LATIN SMALL LETTER M character
          case 0x6E: // U+006E LATIN SMALL LETTER N character
          case 0x6F: // U+006F LATIN SMALL LETTER O character
          case 0x70: // U+0070 LATIN SMALL LETTER P character
          case 0x71: // U+0071 LATIN SMALL LETTER Q character
          case 0x72: // U+0072 LATIN SMALL LETTER R character
          case 0x73: // U+0073 LATIN SMALL LETTER S character
          case 0x74: // U+0074 LATIN SMALL LETTER T character
          case 0x75: // U+0075 LATIN SMALL LETTER U character
          case 0x76: // U+0076 LATIN SMALL LETTER V character
          case 0x77: // U+0077 LATIN SMALL LETTER W character
          case 0x78: // U+0078 LATIN SMALL LETTER X character
          case 0x79: // U+0079 LATIN SMALL LETTER Y character
          case 0x7A: // U+007A LATIN SMALL LETTER Z character
          case 0x5F: // U+005F LOW LINE character (_)
            assert(buffer.isEmpty);
            mode = TokenizerMode.identifier;
            buffer.add(current);
            break;
          default:
            throw ParserException('Unexpected character ${Rune(current).describe()}', line, column);
        }
        break;

      case TokenizerMode.minus: // "-"
        assert(buffer.length == 1 && buffer[0] == 0x2D);
        switch (current) {
          case -1:
            throw ParserException('Unexpected end of file after minus sign', line, column);
          case 0x30: // U+0030 DIGIT ZERO character (0)
          case 0x31: // U+0031 DIGIT ONE character (1)
          case 0x32: // U+0032 DIGIT TWO character (2)
          case 0x33: // U+0033 DIGIT THREE character (3)
          case 0x34: // U+0034 DIGIT FOUR character (4)
          case 0x35: // U+0035 DIGIT FIVE character (5)
          case 0x36: // U+0036 DIGIT SIX character (6)
          case 0x37: // U+0037 DIGIT SEVEN character (7)
          case 0x38: // U+0038 DIGIT EIGHT character (8)
          case 0x39: // U+0039 DIGIT NINE character (9)
            mode = TokenizerMode.minusInteger;
            buffer.add(current);
            break;
          default:
            throw ParserException('Unexpected character ${Rune(current).describe()} after minus sign (expected digit)', line, column);
        }
        break;
      case TokenizerMode.zero: // "0"
        assert(buffer.length == 1 && buffer[0] == 0x30);
        switch (current) {
          case -1:
            yield IntegerToken(0, line, column);
            yield EofToken(line, column);
            return;
          case 0x0A: // U+000A LINE FEED (LF)
          case 0x20: // U+0020 SPACE character
            yield IntegerToken(0, line, column);
            buffer.clear();
            mode = TokenizerMode.main;
            break;
          case 0x28: // U+0028 LEFT PARENTHESIS character (()
          case 0x29: // U+0029 RIGHT PARENTHESIS character ())
          case 0x2C: // U+002C COMMA character (,)
          case 0x3A: // U+003A COLON character (:)
          case 0x3B: // U+003B SEMICOLON character (;)
          case 0x3D: // U+003D EQUALS SIGN character (=)
          case 0x5B: // U+005B LEFT SQUARE BRACKET character ([)
          case 0x5D: // U+005D RIGHT SQUARE BRACKET character (])
          case 0x7B: // U+007B LEFT CURLY BRACKET character ({)
          case 0x7D: // U+007D RIGHT CURLY BRACKET character (})
            yield IntegerToken(0, line, column);
            buffer.clear();
            yield SymbolToken(current, line, column);
            mode = TokenizerMode.main;
            break;
          case 0x2E: // U+002E FULL STOP character (.)
            mode = TokenizerMode.numericDot;
            buffer.add(current);
            break;
          case 0x30: // U+0030 DIGIT ZERO character (0)
          case 0x31: // U+0031 DIGIT ONE character (1)
          case 0x32: // U+0032 DIGIT TWO character (2)
          case 0x33: // U+0033 DIGIT THREE character (3)
          case 0x34: // U+0034 DIGIT FOUR character (4)
          case 0x35: // U+0035 DIGIT FIVE character (5)
          case 0x36: // U+0036 DIGIT SIX character (6)
          case 0x37: // U+0037 DIGIT SEVEN character (7)
          case 0x38: // U+0038 DIGIT EIGHT character (8)
          case 0x39: // U+0039 DIGIT NINE character (9)
            mode = TokenizerMode.integer;
            buffer.add(current);
            break;
          case 0x45: // U+0045 LATIN CAPITAL LETTER E character
          case 0x65: // U+0065 LATIN SMALL LETTER E character
            mode = TokenizerMode.e;
            buffer.add(current);
            break;
          case 0x58: // U+0058 LATIN CAPITAL LETTER X character
          case 0x78: // U+0078 LATIN SMALL LETTER X character
            mode = TokenizerMode.x;
            buffer.clear();
            break;
          default:
            throw ParserException('Unexpected character ${Rune(current).describe()} after zero', line, column);
        }
        break;

      case TokenizerMode.minusInteger: // "-0"
        switch (current) {
          case -1:
            yield IntegerToken(int.parse(String.fromCharCodes(buffer), radix: 10), line, column);
            yield EofToken(line, column);
            return;
          case 0x0A: // U+000A LINE FEED (LF)
          case 0x20: // U+0020 SPACE character
            yield IntegerToken(int.parse(String.fromCharCodes(buffer), radix: 10), line, column);
            buffer.clear();
            mode = TokenizerMode.main;
            break;
          case 0x28: // U+0028 LEFT PARENTHESIS character (()
          case 0x29: // U+0029 RIGHT PARENTHESIS character ())
          case 0x2C: // U+002C COMMA character (,)
          case 0x3A: // U+003A COLON character (:)
          case 0x3B: // U+003B SEMICOLON character (;)
          case 0x3D: // U+003D EQUALS SIGN character (=)
          case 0x5B: // U+005B LEFT SQUARE BRACKET character ([)
          case 0x5D: // U+005D RIGHT SQUARE BRACKET character (])
          case 0x7B: // U+007B LEFT CURLY BRACKET character ({)
          case 0x7D: // U+007D RIGHT CURLY BRACKET character (})
            yield IntegerToken(int.parse(String.fromCharCodes(buffer), radix: 10), line, column);
            buffer.clear();
            yield SymbolToken(current, line, column);
            mode = TokenizerMode.main;
            break;
          case 0x2E: // U+002E FULL STOP character (.)
            mode = TokenizerMode.numericDot;
            buffer.add(current);
            break;
          case 0x30: // U+0030 DIGIT ZERO character (0)
          case 0x31: // U+0031 DIGIT ONE character (1)
          case 0x32: // U+0032 DIGIT TWO character (2)
          case 0x33: // U+0033 DIGIT THREE character (3)
          case 0x34: // U+0034 DIGIT FOUR character (4)
          case 0x35: // U+0035 DIGIT FIVE character (5)
          case 0x36: // U+0036 DIGIT SIX character (6)
          case 0x37: // U+0037 DIGIT SEVEN character (7)
          case 0x38: // U+0038 DIGIT EIGHT character (8)
          case 0x39: // U+0039 DIGIT NINE character (9)
            mode = TokenizerMode.integer;
            buffer.add(current);
            break;
          case 0x45: // U+0045 LATIN CAPITAL LETTER E character
          case 0x65: // U+0065 LATIN SMALL LETTER E character
            mode = TokenizerMode.e;
            buffer.add(current);
            break;
          default:
            throw ParserException('Unexpected character ${Rune(current).describe()} after negative zero', line, column);
        }
        break;

      case TokenizerMode.integer: // "00", "1", "-00"
        switch (current) {
          case -1:
            yield IntegerToken(int.parse(String.fromCharCodes(buffer), radix: 10), line, column);
            buffer.clear();
            yield EofToken(line, column);
            return;
          case 0x0A: // U+000A LINE FEED (LF)
          case 0x20: // U+0020 SPACE character
            yield IntegerToken(int.parse(String.fromCharCodes(buffer), radix: 10), line, column);
            buffer.clear();
            mode = TokenizerMode.main;
            break;
          case 0x28: // U+0028 LEFT PARENTHESIS character (()
          case 0x29: // U+0029 RIGHT PARENTHESIS character ())
          case 0x2C: // U+002C COMMA character (,)
          case 0x3A: // U+003A COLON character (:)
          case 0x3B: // U+003B SEMICOLON character (;)
          case 0x3D: // U+003D EQUALS SIGN character (=)
          case 0x5B: // U+005B LEFT SQUARE BRACKET character ([)
          case 0x5D: // U+005D RIGHT SQUARE BRACKET character (])
          case 0x7B: // U+007B LEFT CURLY BRACKET character ({)
          case 0x7D: // U+007D RIGHT CURLY BRACKET character (})
            yield IntegerToken(int.parse(String.fromCharCodes(buffer), radix: 10), line, column);
            buffer.clear();
            yield SymbolToken(current, line, column);
            mode = TokenizerMode.main;
            break;
          case 0x2E: // U+002E FULL STOP character (.)
            mode = TokenizerMode.numericDot;
            buffer.add(current);
            break;
          case 0x30: // U+0030 DIGIT ZERO character (0)
          case 0x31: // U+0031 DIGIT ONE character (1)
          case 0x32: // U+0032 DIGIT TWO character (2)
          case 0x33: // U+0033 DIGIT THREE character (3)
          case 0x34: // U+0034 DIGIT FOUR character (4)
          case 0x35: // U+0035 DIGIT FIVE character (5)
          case 0x36: // U+0036 DIGIT SIX character (6)
          case 0x37: // U+0037 DIGIT SEVEN character (7)
          case 0x38: // U+0038 DIGIT EIGHT character (8)
          case 0x39: // U+0039 DIGIT NINE character (9)
            buffer.add(current);
            break;
          case 0x45: // U+0045 LATIN CAPITAL LETTER E character
          case 0x65: // U+0065 LATIN SMALL LETTER E character
            mode = TokenizerMode.e;
            buffer.add(current);
            break;
          default:
            throw ParserException('Unexpected character ${Rune(current).describe()}', line, column);
        }
        break;

      case TokenizerMode.integerOnly:
        switch (current) {
          case -1:
            yield IntegerToken(int.parse(String.fromCharCodes(buffer), radix: 10), line, column);
            buffer.clear();
            yield EofToken(line, column);
            return;
          case 0x0A: // U+000A LINE FEED (LF)
          case 0x20: // U+0020 SPACE character
            yield IntegerToken(int.parse(String.fromCharCodes(buffer), radix: 10), line, column);
            buffer.clear();
            mode = TokenizerMode.main;
            break;
          case 0x28: // U+0028 LEFT PARENTHESIS character (()
          case 0x29: // U+0029 RIGHT PARENTHESIS character ())
          case 0x2C: // U+002C COMMA character (,)
          case 0x3A: // U+003A COLON character (:)
          case 0x3B: // U+003B SEMICOLON character (;)
          case 0x3D: // U+003D EQUALS SIGN character (=)
          case 0x5B: // U+005B LEFT SQUARE BRACKET character ([)
          case 0x5D: // U+005D RIGHT SQUARE BRACKET character (])
          case 0x7B: // U+007B LEFT CURLY BRACKET character ({)
          case 0x7D: // U+007D RIGHT CURLY BRACKET character (})
            yield IntegerToken(int.parse(String.fromCharCodes(buffer), radix: 10), line, column);
            buffer.clear();
            yield SymbolToken(current, line, column);
            mode = TokenizerMode.main;
            break;
          case 0x2E: // U+002E FULL STOP character (.)
            yield IntegerToken(int.parse(String.fromCharCodes(buffer), radix: 10), line, column);
            buffer.clear();
            mode = TokenizerMode.dot1;
            break;
          case 0x30: // U+0030 DIGIT ZERO character (0)
          case 0x31: // U+0031 DIGIT ONE character (1)
          case 0x32: // U+0032 DIGIT TWO character (2)
          case 0x33: // U+0033 DIGIT THREE character (3)
          case 0x34: // U+0034 DIGIT FOUR character (4)
          case 0x35: // U+0035 DIGIT FIVE character (5)
          case 0x36: // U+0036 DIGIT SIX character (6)
          case 0x37: // U+0037 DIGIT SEVEN character (7)
          case 0x38: // U+0038 DIGIT EIGHT character (8)
          case 0x39: // U+0039 DIGIT NINE character (9)
            buffer.add(current);
            break;
          default:
            throw ParserException('Unexpected character ${Rune(current).describe()} in integer', line, column);
        }
        break;

      case TokenizerMode.numericDot: // "0.", "-0.", "00.", "1.", "-00."
        switch (current) {
          case -1:
            throw ParserException('Unexpected end of file after decimal point', line, column);
          case 0x30: // U+0030 DIGIT ZERO character (0)
          case 0x31: // U+0031 DIGIT ONE character (1)
          case 0x32: // U+0032 DIGIT TWO character (2)
          case 0x33: // U+0033 DIGIT THREE character (3)
          case 0x34: // U+0034 DIGIT FOUR character (4)
          case 0x35: // U+0035 DIGIT FIVE character (5)
          case 0x36: // U+0036 DIGIT SIX character (6)
          case 0x37: // U+0037 DIGIT SEVEN character (7)
          case 0x38: // U+0038 DIGIT EIGHT character (8)
          case 0x39: // U+0039 DIGIT NINE character (9)
            mode = TokenizerMode.fraction;
            buffer.add(current);
            break;
          default:
            throw ParserException('Unexpected character ${Rune(current).describe()} in fraction component', line, column);
        }
        break;

      case TokenizerMode.fraction: // "0.0", "-0.0", "00.0", "1.0", "-00.0"
        switch (current) {
          case -1:
            yield DoubleToken(double.parse(String.fromCharCodes(buffer)), line, column);
            yield EofToken(line, column);
            return;
          case 0x0A: // U+000A LINE FEED (LF)
          case 0x20: // U+0020 SPACE character
            yield DoubleToken(double.parse(String.fromCharCodes(buffer)), line, column);
            buffer.clear();
            mode = TokenizerMode.main;
            break;
          case 0x28: // U+0028 LEFT PARENTHESIS character (()
          case 0x29: // U+0029 RIGHT PARENTHESIS character ())
          case 0x2C: // U+002C COMMA character (,)
          case 0x3A: // U+003A COLON character (:)
          case 0x3B: // U+003B SEMICOLON character (;)
          case 0x3D: // U+003D EQUALS SIGN character (=)
          case 0x5B: // U+005B LEFT SQUARE BRACKET character ([)
          case 0x5D: // U+005D RIGHT SQUARE BRACKET character (])
          case 0x7B: // U+007B LEFT CURLY BRACKET character ({)
          case 0x7D: // U+007D RIGHT CURLY BRACKET character (})
            yield DoubleToken(double.parse(String.fromCharCodes(buffer)), line, column);
            buffer.clear();
            yield SymbolToken(current, line, column);
            mode = TokenizerMode.main;
            break;
          case 0x30: // U+0030 DIGIT ZERO character (0)
          case 0x31: // U+0031 DIGIT ONE character (1)
          case 0x32: // U+0032 DIGIT TWO character (2)
          case 0x33: // U+0033 DIGIT THREE character (3)
          case 0x34: // U+0034 DIGIT FOUR character (4)
          case 0x35: // U+0035 DIGIT FIVE character (5)
          case 0x36: // U+0036 DIGIT SIX character (6)
          case 0x37: // U+0037 DIGIT SEVEN character (7)
          case 0x38: // U+0038 DIGIT EIGHT character (8)
          case 0x39: // U+0039 DIGIT NINE character (9)
            buffer.add(current);
            break;
          case 0x45: // U+0045 LATIN CAPITAL LETTER E character
          case 0x65: // U+0065 LATIN SMALL LETTER E character
            mode = TokenizerMode.e;
            buffer.add(current);
            break;
          default:
            throw ParserException('Unexpected character ${Rune(current).describe()} in fraction component', line, column);
        }
        break;

      case TokenizerMode.e: // "0e", "-0e", "00e", "1e", "-00e", "0.0e", "-0.0e", "00.0e", "1.0e", "-00.0e"
        switch (current) {
          case -1:
            throw ParserException('Unexpected end of file after exponent separator', line, column);
          case 0x2D: // U+002D HYPHEN-MINUS character (-)
            mode = TokenizerMode.negativeExponent;
            buffer.add(current);
            break;
          case 0x30: // U+0030 DIGIT ZERO character (0)
          case 0x31: // U+0031 DIGIT ONE character (1)
          case 0x32: // U+0032 DIGIT TWO character (2)
          case 0x33: // U+0033 DIGIT THREE character (3)
          case 0x34: // U+0034 DIGIT FOUR character (4)
          case 0x35: // U+0035 DIGIT FIVE character (5)
          case 0x36: // U+0036 DIGIT SIX character (6)
          case 0x37: // U+0037 DIGIT SEVEN character (7)
          case 0x38: // U+0038 DIGIT EIGHT character (8)
          case 0x39: // U+0039 DIGIT NINE character (9)
            mode = TokenizerMode.exponent;
            buffer.add(current);
            break;
          default:
            throw ParserException('Unexpected character ${Rune(current).describe()} after exponent separator', line, column);
        }
        break;

      case TokenizerMode.negativeExponent: // "0e-", "-0e-", "00e-", "1e-", "-00e-", "0.0e-", "-0.0e-", "00.0e-", "1.0e-", "-00.0e-"
        switch (current) {
          case -1:
            throw ParserException('Unexpected end of file after exponent separator and minus sign', line, column);
          case 0x30: // U+0030 DIGIT ZERO character (0)
          case 0x31: // U+0031 DIGIT ONE character (1)
          case 0x32: // U+0032 DIGIT TWO character (2)
          case 0x33: // U+0033 DIGIT THREE character (3)
          case 0x34: // U+0034 DIGIT FOUR character (4)
          case 0x35: // U+0035 DIGIT FIVE character (5)
          case 0x36: // U+0036 DIGIT SIX character (6)
          case 0x37: // U+0037 DIGIT SEVEN character (7)
          case 0x38: // U+0038 DIGIT EIGHT character (8)
          case 0x39: // U+0039 DIGIT NINE character (9)
            mode = TokenizerMode.exponent;
            buffer.add(current);
            break;
          default:
            throw ParserException('Unexpected character ${Rune(current).describe()} in exponent', line, column);
        }
        break;

      // "0e0", "-0e0", "00e0", "1e0", "-00e0", "0.0e0", "-0.0e0", "00.0e0", "1.0e0", "-00.0e0", "0e-0", "-0e-0", "00e-0", "1e-0", "-00e-0", "0.0e-0", "-0.0e-0", "00.0e-0", "1.0e-0", "-00.0e-0"
      case TokenizerMode.exponent:
        switch (current) {
          case -1:
            yield DoubleToken(double.parse(String.fromCharCodes(buffer)), line, column);
            yield EofToken(line, column);
            return;
          case 0x0A: // U+000A LINE FEED (LF)
          case 0x20: // U+0020 SPACE character
            yield DoubleToken(double.parse(String.fromCharCodes(buffer)), line, column);
            buffer.clear();
            mode = TokenizerMode.main;
            break;
          case 0x28: // U+0028 LEFT PARENTHESIS character (()
          case 0x29: // U+0029 RIGHT PARENTHESIS character ())
          case 0x2C: // U+002C COMMA character (,)
          case 0x3A: // U+003A COLON character (:)
          case 0x3B: // U+003B SEMICOLON character (;)
          case 0x3D: // U+003D EQUALS SIGN character (=)
          case 0x5B: // U+005B LEFT SQUARE BRACKET character ([)
          case 0x5D: // U+005D RIGHT SQUARE BRACKET character (])
          case 0x7B: // U+007B LEFT CURLY BRACKET character ({)
          case 0x7D: // U+007D RIGHT CURLY BRACKET character (})
            yield DoubleToken(double.parse(String.fromCharCodes(buffer)), line, column);
            buffer.clear();
            yield SymbolToken(current, line, column);
            mode = TokenizerMode.main;
            break;
          case 0x30: // U+0030 DIGIT ZERO character (0)
          case 0x31: // U+0031 DIGIT ONE character (1)
          case 0x32: // U+0032 DIGIT TWO character (2)
          case 0x33: // U+0033 DIGIT THREE character (3)
          case 0x34: // U+0034 DIGIT FOUR character (4)
          case 0x35: // U+0035 DIGIT FIVE character (5)
          case 0x36: // U+0036 DIGIT SIX character (6)
          case 0x37: // U+0037 DIGIT SEVEN character (7)
          case 0x38: // U+0038 DIGIT EIGHT character (8)
          case 0x39: // U+0039 DIGIT NINE character (9)
            buffer.add(current);
            break;
          default:
            throw ParserException('Unexpected character ${Rune(current).describe()} in exponent', line, column);
        }
        break;

      case TokenizerMode.x: // "0x", "0X"
        switch (current) {
          case -1:
            throw ParserException('Unexpected end of file after 0x prefix', line, column);
          case 0x30: // U+0030 DIGIT ZERO character (0)
          case 0x31: // U+0031 DIGIT ONE character (1)
          case 0x32: // U+0032 DIGIT TWO character (2)
          case 0x33: // U+0033 DIGIT THREE character (3)
          case 0x34: // U+0034 DIGIT FOUR character (4)
          case 0x35: // U+0035 DIGIT FIVE character (5)
          case 0x36: // U+0036 DIGIT SIX character (6)
          case 0x37: // U+0037 DIGIT SEVEN character (7)
          case 0x38: // U+0038 DIGIT EIGHT character (8)
          case 0x39: // U+0039 DIGIT NINE character (9)
          case 0x41: // U+0041 LATIN CAPITAL LETTER A character
          case 0x42: // U+0042 LATIN CAPITAL LETTER B character
          case 0x43: // U+0043 LATIN CAPITAL LETTER C character
          case 0x44: // U+0044 LATIN CAPITAL LETTER D character
          case 0x45: // U+0045 LATIN CAPITAL LETTER E character
          case 0x46: // U+0046 LATIN CAPITAL LETTER F character
          case 0x61: // U+0061 LATIN SMALL LETTER A character
          case 0x62: // U+0062 LATIN SMALL LETTER B character
          case 0x63: // U+0063 LATIN SMALL LETTER C character
          case 0x64: // U+0064 LATIN SMALL LETTER D character
          case 0x65: // U+0065 LATIN SMALL LETTER E character
          case 0x66: // U+0066 LATIN SMALL LETTER F character
            mode = TokenizerMode.hex;
            buffer.add(current);
            break;
          default:
            throw ParserException('Unexpected character ${Rune(current).describe()} after 0x prefix', line, column);
        }
        break;

      case TokenizerMode.hex:
        switch (current) {
          case -1:
            yield IntegerToken(int.parse(String.fromCharCodes(buffer), radix: 16), line, column);
            yield EofToken(line, column);
            return;
          case 0x0A: // U+000A LINE FEED (LF)
          case 0x20: // U+0020 SPACE character
            yield IntegerToken(int.parse(String.fromCharCodes(buffer), radix: 16), line, column);
            buffer.clear();
            mode = TokenizerMode.main;
            break;
          case 0x28: // U+0028 LEFT PARENTHESIS character (()
          case 0x29: // U+0029 RIGHT PARENTHESIS character ())
          case 0x2C: // U+002C COMMA character (,)
          case 0x3A: // U+003A COLON character (:)
          case 0x3B: // U+003B SEMICOLON character (;)
          case 0x3D: // U+003D EQUALS SIGN character (=)
          case 0x5B: // U+005B LEFT SQUARE BRACKET character ([)
          case 0x5D: // U+005D RIGHT SQUARE BRACKET character (])
          case 0x7B: // U+007B LEFT CURLY BRACKET character ({)
          case 0x7D: // U+007D RIGHT CURLY BRACKET character (})
            yield IntegerToken(int.parse(String.fromCharCodes(buffer), radix: 16), line, column);
            buffer.clear();
            yield SymbolToken(current, line, column);
            mode = TokenizerMode.main;
            break;
          case 0x30: // U+0030 DIGIT ZERO character (0)
          case 0x31: // U+0031 DIGIT ONE character (1)
          case 0x32: // U+0032 DIGIT TWO character (2)
          case 0x33: // U+0033 DIGIT THREE character (3)
          case 0x34: // U+0034 DIGIT FOUR character (4)
          case 0x35: // U+0035 DIGIT FIVE character (5)
          case 0x36: // U+0036 DIGIT SIX character (6)
          case 0x37: // U+0037 DIGIT SEVEN character (7)
          case 0x38: // U+0038 DIGIT EIGHT character (8)
          case 0x39: // U+0039 DIGIT NINE character (9)
          case 0x41: // U+0041 LATIN CAPITAL LETTER A character
          case 0x42: // U+0042 LATIN CAPITAL LETTER B character
          case 0x43: // U+0043 LATIN CAPITAL LETTER C character
          case 0x44: // U+0044 LATIN CAPITAL LETTER D character
          case 0x45: // U+0045 LATIN CAPITAL LETTER E character
          case 0x46: // U+0046 LATIN CAPITAL LETTER F character
          case 0x61: // U+0061 LATIN SMALL LETTER A character
          case 0x62: // U+0062 LATIN SMALL LETTER B character
          case 0x63: // U+0063 LATIN SMALL LETTER C character
          case 0x64: // U+0064 LATIN SMALL LETTER D character
          case 0x65: // U+0065 LATIN SMALL LETTER E character
          case 0x66: // U+0066 LATIN SMALL LETTER F character
            buffer.add(current);
            break;
          default:
            throw ParserException('Unexpected character ${Rune(current).describe()} in hex literal', line, column);
        }
        break;

      case TokenizerMode.dot1: // "."
        switch (current) {
          case -1:
            yield SymbolToken(0x2E, line, column);
            yield EofToken(line, column);
            return;
          case 0x0A: // U+000A LINE FEED (LF)
          case 0x20: // U+0020 SPACE character
            yield SymbolToken(0x2E, line, column);
            mode = TokenizerMode.main;
            break;
          case 0x22: // U+0022 QUOTATION MARK character (")
            yield SymbolToken(0x2E, line, column);
            assert(buffer.isEmpty);
            mode = TokenizerMode.doubleQuote;
            break;
          case 0x27: // U+0027 APOSTROPHE character (')
            yield SymbolToken(0x2E, line, column);
            assert(buffer.isEmpty);
            mode = TokenizerMode.quote;
            break;
          case 0x28: // U+0028 LEFT PARENTHESIS character (()
          case 0x29: // U+0029 RIGHT PARENTHESIS character ())
          case 0x2C: // U+002C COMMA character (,)
          case 0x3A: // U+003A COLON character (:)
          case 0x3B: // U+003B SEMICOLON character (;)
          case 0x3D: // U+003D EQUALS SIGN character (=)
          case 0x5B: // U+005B LEFT SQUARE BRACKET character ([)
          case 0x5D: // U+005D RIGHT SQUARE BRACKET character (])
          case 0x7B: // U+007B LEFT CURLY BRACKET character ({)
          case 0x7D: // U+007D RIGHT CURLY BRACKET character (})
            yield SymbolToken(0x2E, line, column);
            yield SymbolToken(current, line, column);
            break;
          case 0x2E: // U+002E FULL STOP character (.)
            mode = TokenizerMode.dot2;
            break;
          case 0x30: // U+0030 DIGIT ZERO character (0)
          case 0x31: // U+0031 DIGIT ONE character (1)
          case 0x32: // U+0032 DIGIT TWO character (2)
          case 0x33: // U+0033 DIGIT THREE character (3)
          case 0x34: // U+0034 DIGIT FOUR character (4)
          case 0x35: // U+0035 DIGIT FIVE character (5)
          case 0x36: // U+0036 DIGIT SIX character (6)
          case 0x37: // U+0037 DIGIT SEVEN character (7)
          case 0x38: // U+0038 DIGIT EIGHT character (8)
          case 0x39: // U+0039 DIGIT NINE character (9)
            yield SymbolToken(0x2E, line, column);
            assert(buffer.isEmpty);
            mode = TokenizerMode.integerOnly;
            buffer.add(current);
            break;
          case 0x41: // U+0041 LATIN CAPITAL LETTER A character
          case 0x42: // U+0042 LATIN CAPITAL LETTER B character
          case 0x43: // U+0043 LATIN CAPITAL LETTER C character
          case 0x44: // U+0044 LATIN CAPITAL LETTER D character
          case 0x45: // U+0045 LATIN CAPITAL LETTER E character
          case 0x46: // U+0046 LATIN CAPITAL LETTER F character
          case 0x47: // U+0047 LATIN CAPITAL LETTER G character
          case 0x48: // U+0048 LATIN CAPITAL LETTER H character
          case 0x49: // U+0049 LATIN CAPITAL LETTER I character
          case 0x4A: // U+004A LATIN CAPITAL LETTER J character
          case 0x4B: // U+004B LATIN CAPITAL LETTER K character
          case 0x4C: // U+004C LATIN CAPITAL LETTER L character
          case 0x4D: // U+004D LATIN CAPITAL LETTER M character
          case 0x4E: // U+004E LATIN CAPITAL LETTER N character
          case 0x4F: // U+004F LATIN CAPITAL LETTER O character
          case 0x50: // U+0050 LATIN CAPITAL LETTER P character
          case 0x51: // U+0051 LATIN CAPITAL LETTER Q character
          case 0x52: // U+0052 LATIN CAPITAL LETTER R character
          case 0x53: // U+0053 LATIN CAPITAL LETTER S character
          case 0x54: // U+0054 LATIN CAPITAL LETTER T character
          case 0x55: // U+0055 LATIN CAPITAL LETTER U character
          case 0x56: // U+0056 LATIN CAPITAL LETTER V character
          case 0x57: // U+0057 LATIN CAPITAL LETTER W character
          case 0x58: // U+0058 LATIN CAPITAL LETTER X character
          case 0x59: // U+0059 LATIN CAPITAL LETTER Y character
          case 0x5A: // U+005A LATIN CAPITAL LETTER Z character
          case 0x61: // U+0061 LATIN SMALL LETTER A character
          case 0x62: // U+0062 LATIN SMALL LETTER B character
          case 0x63: // U+0063 LATIN SMALL LETTER C character
          case 0x64: // U+0064 LATIN SMALL LETTER D character
          case 0x65: // U+0065 LATIN SMALL LETTER E character
          case 0x66: // U+0066 LATIN SMALL LETTER F character
          case 0x67: // U+0067 LATIN SMALL LETTER G character
          case 0x68: // U+0068 LATIN SMALL LETTER H character
          case 0x69: // U+0069 LATIN SMALL LETTER I character
          case 0x6A: // U+006A LATIN SMALL LETTER J character
          case 0x6B: // U+006B LATIN SMALL LETTER K character
          case 0x6C: // U+006C LATIN SMALL LETTER L character
          case 0x6D: // U+006D LATIN SMALL LETTER M character
          case 0x6E: // U+006E LATIN SMALL LETTER N character
          case 0x6F: // U+006F LATIN SMALL LETTER O character
          case 0x70: // U+0070 LATIN SMALL LETTER P character
          case 0x71: // U+0071 LATIN SMALL LETTER Q character
          case 0x72: // U+0072 LATIN SMALL LETTER R character
          case 0x73: // U+0073 LATIN SMALL LETTER S character
          case 0x74: // U+0074 LATIN SMALL LETTER T character
          case 0x75: // U+0075 LATIN SMALL LETTER U character
          case 0x76: // U+0076 LATIN SMALL LETTER V character
          case 0x77: // U+0077 LATIN SMALL LETTER W character
          case 0x78: // U+0078 LATIN SMALL LETTER X character
          case 0x79: // U+0079 LATIN SMALL LETTER Y character
          case 0x7A: // U+007A LATIN SMALL LETTER Z character
          case 0x5F: // U+005F LOW LINE character (_)
            yield SymbolToken(0x2E, line, column);
            assert(buffer.isEmpty);
            mode = TokenizerMode.identifier;
            buffer.add(current);
            break;
          default:
            throw ParserException('Unexpected character ${Rune(current).describe()} after period', line, column);
        }
        break;

      case TokenizerMode.dot2: // ".."
        switch (current) {
          case -1:
            throw ParserException('Unexpected end of file inside "..." symbol', line, column);
          case 0x2E: // U+002E FULL STOP character (.)
            yield SymbolToken(SymbolToken.tripleDot, line, column);
            mode = TokenizerMode.main;
            break;
          default:
            throw ParserException('Unexpected character ${Rune(current).describe()} inside "..." symbol', line, column);
        }
        break;

      case TokenizerMode.identifier:
        switch (current) {
          case -1:
            yield IdentifierToken(String.fromCharCodes(buffer), line, column);
            yield EofToken(line, column);
            return;
          case 0x0A: // U+000A LINE FEED (LF)
          case 0x20: // U+0020 SPACE character
            yield IdentifierToken(String.fromCharCodes(buffer), line, column);
            buffer.clear();
            mode = TokenizerMode.main;
            break;

          case 0x3C: // U+003C LESS THAN character (<)
          case 0x3E: // U+003E LESS THAN character (>)
          case 0x28: // U+0028 LEFT PARENTHESIS character (()
          case 0x29: // U+0029 RIGHT PARENTHESIS character ())
          case 0x2C: // U+002C COMMA character (,)
          case 0x3A: // U+003A COLON character (:)
          case 0x3B: // U+003B SEMICOLON character (;)
          case 0x3D: // U+003D EQUALS SIGN character (=)
          case 0x5B: // U+005B LEFT SQUARE BRACKET character ([)
          case 0x5D: // U+005D RIGHT SQUARE BRACKET character (])
          case 0x7B: // U+007B LEFT CURLY BRACKET character ({)
          case 0x7D: // U+007D RIGHT CURLY BRACKET character (})
          case 0x3F: // U+003F QUESTION character (?)
            yield IdentifierToken(String.fromCharCodes(buffer), line, column);
            buffer.clear();
            yield SymbolToken(current, line, column);
            mode = TokenizerMode.main;
            break;
          case 0x2E: // U+002E FULL STOP character (.)
            yield IdentifierToken(String.fromCharCodes(buffer), line, column);
            buffer.clear();
            mode = TokenizerMode.dot1;
            break;
          case 0x30: // U+0030 DIGIT ZERO character (0)
          case 0x31: // U+0031 DIGIT ONE character (1)
          case 0x32: // U+0032 DIGIT TWO character (2)
          case 0x33: // U+0033 DIGIT THREE character (3)
          case 0x34: // U+0034 DIGIT FOUR character (4)
          case 0x35: // U+0035 DIGIT FIVE character (5)
          case 0x36: // U+0036 DIGIT SIX character (6)
          case 0x37: // U+0037 DIGIT SEVEN character (7)
          case 0x38: // U+0038 DIGIT EIGHT character (8)
          case 0x39: // U+0039 DIGIT NINE character (9)
          case 0x41: // U+0041 LATIN CAPITAL LETTER A character
          case 0x42: // U+0042 LATIN CAPITAL LETTER B character
          case 0x43: // U+0043 LATIN CAPITAL LETTER C character
          case 0x44: // U+0044 LATIN CAPITAL LETTER D character
          case 0x45: // U+0045 LATIN CAPITAL LETTER E character
          case 0x46: // U+0046 LATIN CAPITAL LETTER F character
          case 0x47: // U+0047 LATIN CAPITAL LETTER G character
          case 0x48: // U+0048 LATIN CAPITAL LETTER H character
          case 0x49: // U+0049 LATIN CAPITAL LETTER I character
          case 0x4A: // U+004A LATIN CAPITAL LETTER J character
          case 0x4B: // U+004B LATIN CAPITAL LETTER K character
          case 0x4C: // U+004C LATIN CAPITAL LETTER L character
          case 0x4D: // U+004D LATIN CAPITAL LETTER M character
          case 0x4E: // U+004E LATIN CAPITAL LETTER N character
          case 0x4F: // U+004F LATIN CAPITAL LETTER O character
          case 0x50: // U+0050 LATIN CAPITAL LETTER P character
          case 0x51: // U+0051 LATIN CAPITAL LETTER Q character
          case 0x52: // U+0052 LATIN CAPITAL LETTER R character
          case 0x53: // U+0053 LATIN CAPITAL LETTER S character
          case 0x54: // U+0054 LATIN CAPITAL LETTER T character
          case 0x55: // U+0055 LATIN CAPITAL LETTER U character
          case 0x56: // U+0056 LATIN CAPITAL LETTER V character
          case 0x57: // U+0057 LATIN CAPITAL LETTER W character
          case 0x58: // U+0058 LATIN CAPITAL LETTER X character
          case 0x59: // U+0059 LATIN CAPITAL LETTER Y character
          case 0x5A: // U+005A LATIN CAPITAL LETTER Z character
          case 0x61: // U+0061 LATIN SMALL LETTER A character
          case 0x62: // U+0062 LATIN SMALL LETTER B character
          case 0x63: // U+0063 LATIN SMALL LETTER C character
          case 0x64: // U+0064 LATIN SMALL LETTER D character
          case 0x65: // U+0065 LATIN SMALL LETTER E character
          case 0x66: // U+0066 LATIN SMALL LETTER F character
          case 0x67: // U+0067 LATIN SMALL LETTER G character
          case 0x68: // U+0068 LATIN SMALL LETTER H character
          case 0x69: // U+0069 LATIN SMALL LETTER I character
          case 0x6A: // U+006A LATIN SMALL LETTER J character
          case 0x6B: // U+006B LATIN SMALL LETTER K character
          case 0x6C: // U+006C LATIN SMALL LETTER L character
          case 0x6D: // U+006D LATIN SMALL LETTER M character
          case 0x6E: // U+006E LATIN SMALL LETTER N character
          case 0x6F: // U+006F LATIN SMALL LETTER O character
          case 0x70: // U+0070 LATIN SMALL LETTER P character
          case 0x71: // U+0071 LATIN SMALL LETTER Q character
          case 0x72: // U+0072 LATIN SMALL LETTER R character
          case 0x73: // U+0073 LATIN SMALL LETTER S character
          case 0x74: // U+0074 LATIN SMALL LETTER T character
          case 0x75: // U+0075 LATIN SMALL LETTER U character
          case 0x76: // U+0076 LATIN SMALL LETTER V character
          case 0x77: // U+0077 LATIN SMALL LETTER W character
          case 0x78: // U+0078 LATIN SMALL LETTER X character
          case 0x79: // U+0079 LATIN SMALL LETTER Y character
          case 0x7A: // U+007A LATIN SMALL LETTER Z character
          case 0x5F: // U+005F LOW LINE character (_)
            buffer.add(current);
            break;
          default:
            throw ParserException('Unexpected character ${Rune(current).describe()} inside identifier', line, column);
        }
        break;

      case TokenizerMode.quote:
        switch (current) {
          case -1:
            throw ParserException('Unexpected end of file inside string', line, column);
          case 0x0A: // U+000A LINE FEED (LF)
            throw ParserException('Unexpected end of line inside string', line, column);
          case 0x27: // U+0027 APOSTROPHE character (')
            yield StringToken(String.fromCharCodes(buffer), line, column);
            buffer.clear();
            mode = TokenizerMode.endQuote;
            break;
          case 0x5C: // U+005C REVERSE SOLIDUS character (\)
            mode = TokenizerMode.quoteEscape;
            break;
          default:
            buffer.add(current);
        }
        break;

      case TokenizerMode.quoteEscape:
        switch (current) {
          case -1:
            throw ParserException('Unexpected end of file inside string', line, column);
          case 0x22: // U+0022 QUOTATION MARK character (")
          case 0x27: // U+0027 APOSTROPHE character (')
          case 0x5C: // U+005C REVERSE SOLIDUS character (\)
          case 0x2F: // U+002F SOLIDUS character (/)
            buffer.add(current);
            mode = TokenizerMode.quote;
            break;
          case 0x62: // U+0062 LATIN SMALL LETTER B character
            buffer.add(0x08);
            mode = TokenizerMode.quote;
            break;
          case 0x66: // U+0066 LATIN SMALL LETTER F character
            buffer.add(0x0C);
            mode = TokenizerMode.quote;
            break;
          case 0x6E: // U+006E LATIN SMALL LETTER N character
            buffer.add(0x0A);
            mode = TokenizerMode.quote;
            break;
          case 0x72: // U+0072 LATIN SMALL LETTER R character
            buffer.add(0x0D);
            mode = TokenizerMode.quote;
            break;
          case 0x74: // U+0074 LATIN SMALL LETTER T character
            buffer.add(0x09);
            mode = TokenizerMode.quote;
            break;
          case 0x75: // U+0075 LATIN SMALL LETTER U character
            assert(buffer2.isEmpty);
            mode = TokenizerMode.quoteEscapeUnicode1;
            break;
          default:
            throw ParserException('Unexpected character ${Rune(current).describe()} after backslash in string', line, column);
        }
        break;

      case TokenizerMode.quoteEscapeUnicode1:
        switch (current) {
          case -1:
            throw ParserException('Unexpected end of file inside Unicode escape', line, column);
          case 0x30: // U+0030 DIGIT ZERO character (0)
          case 0x31: // U+0031 DIGIT ONE character (1)
          case 0x32: // U+0032 DIGIT TWO character (2)
          case 0x33: // U+0033 DIGIT THREE character (3)
          case 0x34: // U+0034 DIGIT FOUR character (4)
          case 0x35: // U+0035 DIGIT FIVE character (5)
          case 0x36: // U+0036 DIGIT SIX character (6)
          case 0x37: // U+0037 DIGIT SEVEN character (7)
          case 0x38: // U+0038 DIGIT EIGHT character (8)
          case 0x39: // U+0039 DIGIT NINE character (9)
          case 0x41: // U+0041 LATIN CAPITAL LETTER A character
          case 0x42: // U+0042 LATIN CAPITAL LETTER B character
          case 0x43: // U+0043 LATIN CAPITAL LETTER C character
          case 0x44: // U+0044 LATIN CAPITAL LETTER D character
          case 0x45: // U+0045 LATIN CAPITAL LETTER E character
          case 0x46: // U+0046 LATIN CAPITAL LETTER F character
          case 0x61: // U+0061 LATIN SMALL LETTER A character
          case 0x62: // U+0062 LATIN SMALL LETTER B character
          case 0x63: // U+0063 LATIN SMALL LETTER C character
          case 0x64: // U+0064 LATIN SMALL LETTER D character
          case 0x65: // U+0065 LATIN SMALL LETTER E character
          case 0x66: // U+0066 LATIN SMALL LETTER F character
            buffer2.add(current);
            mode = TokenizerMode.quoteEscapeUnicode2;
            break;
          default:
            throw ParserException('Unexpected character ${Rune(current).describe()} in Unicode escape', line, column);
        }
        break;

      case TokenizerMode.quoteEscapeUnicode2:
        switch (current) {
          case -1:
            throw ParserException('Unexpected end of file inside Unicode escape', line, column);
          case 0x30: // U+0030 DIGIT ZERO character (0)
          case 0x31: // U+0031 DIGIT ONE character (1)
          case 0x32: // U+0032 DIGIT TWO character (2)
          case 0x33: // U+0033 DIGIT THREE character (3)
          case 0x34: // U+0034 DIGIT FOUR character (4)
          case 0x35: // U+0035 DIGIT FIVE character (5)
          case 0x36: // U+0036 DIGIT SIX character (6)
          case 0x37: // U+0037 DIGIT SEVEN character (7)
          case 0x38: // U+0038 DIGIT EIGHT character (8)
          case 0x39: // U+0039 DIGIT NINE character (9)
          case 0x41: // U+0041 LATIN CAPITAL LETTER A character
          case 0x42: // U+0042 LATIN CAPITAL LETTER B character
          case 0x43: // U+0043 LATIN CAPITAL LETTER C character
          case 0x44: // U+0044 LATIN CAPITAL LETTER D character
          case 0x45: // U+0045 LATIN CAPITAL LETTER E character
          case 0x46: // U+0046 LATIN CAPITAL LETTER F character
          case 0x61: // U+0061 LATIN SMALL LETTER A character
          case 0x62: // U+0062 LATIN SMALL LETTER B character
          case 0x63: // U+0063 LATIN SMALL LETTER C character
          case 0x64: // U+0064 LATIN SMALL LETTER D character
          case 0x65: // U+0065 LATIN SMALL LETTER E character
          case 0x66: // U+0066 LATIN SMALL LETTER F character
            buffer2.add(current);
            mode = TokenizerMode.quoteEscapeUnicode3;
            break;
          default:
            throw ParserException('Unexpected character ${Rune(current).describe()} in Unicode escape', line, column);
        }
        break;

      case TokenizerMode.quoteEscapeUnicode3:
        switch (current) {
          case -1:
            throw ParserException('Unexpected end of file inside Unicode escape', line, column);
          case 0x30: // U+0030 DIGIT ZERO character (0)
          case 0x31: // U+0031 DIGIT ONE character (1)
          case 0x32: // U+0032 DIGIT TWO character (2)
          case 0x33: // U+0033 DIGIT THREE character (3)
          case 0x34: // U+0034 DIGIT FOUR character (4)
          case 0x35: // U+0035 DIGIT FIVE character (5)
          case 0x36: // U+0036 DIGIT SIX character (6)
          case 0x37: // U+0037 DIGIT SEVEN character (7)
          case 0x38: // U+0038 DIGIT EIGHT character (8)
          case 0x39: // U+0039 DIGIT NINE character (9)
          case 0x41: // U+0041 LATIN CAPITAL LETTER A character
          case 0x42: // U+0042 LATIN CAPITAL LETTER B character
          case 0x43: // U+0043 LATIN CAPITAL LETTER C character
          case 0x44: // U+0044 LATIN CAPITAL LETTER D character
          case 0x45: // U+0045 LATIN CAPITAL LETTER E character
          case 0x46: // U+0046 LATIN CAPITAL LETTER F character
          case 0x61: // U+0061 LATIN SMALL LETTER A character
          case 0x62: // U+0062 LATIN SMALL LETTER B character
          case 0x63: // U+0063 LATIN SMALL LETTER C character
          case 0x64: // U+0064 LATIN SMALL LETTER D character
          case 0x65: // U+0065 LATIN SMALL LETTER E character
          case 0x66: // U+0066 LATIN SMALL LETTER F character
            buffer2.add(current);
            mode = TokenizerMode.quoteEscapeUnicode4;
            break;
          default:
            throw ParserException('Unexpected character ${Rune(current).describe()} in Unicode escape', line, column);
        }
        break;

      case TokenizerMode.quoteEscapeUnicode4:
        switch (current) {
          case -1:
            throw ParserException('Unexpected end of file inside Unicode escape', line, column);
          case 0x30: // U+0030 DIGIT ZERO character (0)
          case 0x31: // U+0031 DIGIT ONE character (1)
          case 0x32: // U+0032 DIGIT TWO character (2)
          case 0x33: // U+0033 DIGIT THREE character (3)
          case 0x34: // U+0034 DIGIT FOUR character (4)
          case 0x35: // U+0035 DIGIT FIVE character (5)
          case 0x36: // U+0036 DIGIT SIX character (6)
          case 0x37: // U+0037 DIGIT SEVEN character (7)
          case 0x38: // U+0038 DIGIT EIGHT character (8)
          case 0x39: // U+0039 DIGIT NINE character (9)
          case 0x41: // U+0041 LATIN CAPITAL LETTER A character
          case 0x42: // U+0042 LATIN CAPITAL LETTER B character
          case 0x43: // U+0043 LATIN CAPITAL LETTER C character
          case 0x44: // U+0044 LATIN CAPITAL LETTER D character
          case 0x45: // U+0045 LATIN CAPITAL LETTER E character
          case 0x46: // U+0046 LATIN CAPITAL LETTER F character
          case 0x61: // U+0061 LATIN SMALL LETTER A character
          case 0x62: // U+0062 LATIN SMALL LETTER B character
          case 0x63: // U+0063 LATIN SMALL LETTER C character
          case 0x64: // U+0064 LATIN SMALL LETTER D character
          case 0x65: // U+0065 LATIN SMALL LETTER E character
          case 0x66: // U+0066 LATIN SMALL LETTER F character
            buffer2.add(current);
            buffer.add(int.parse(String.fromCharCodes(buffer2), radix: 16));
            buffer2.clear();
            mode = TokenizerMode.quote;
            break;
          default:
            throw ParserException('Unexpected character ${Rune(current).describe()} in Unicode escape', line, column);
        }
        break;

      case TokenizerMode.endQuote:
        switch (current) {
          case -1:
            yield EofToken(line, column);
            return;
          case 0x0A: // U+000A LINE FEED (LF)
          case 0x20: // U+0020 SPACE character
            mode = TokenizerMode.main;
            break;
          case 0x28: // U+0028 LEFT PARENTHESIS character (()
          case 0x29: // U+0029 RIGHT PARENTHESIS character ())
          case 0x2C: // U+002C COMMA character (,)
          case 0x3A: // U+003A COLON character (:)
          case 0x3B: // U+003B SEMICOLON character (;)
          case 0x3D: // U+003D EQUALS SIGN character (=)
          case 0x5B: // U+005B LEFT SQUARE BRACKET character ([)
          case 0x5D: // U+005D RIGHT SQUARE BRACKET character (])
          case 0x7B: // U+007B LEFT CURLY BRACKET character ({)
          case 0x7D: // U+007D RIGHT CURLY BRACKET character (})
            yield SymbolToken(current, line, column);
            mode = TokenizerMode.main;
            break;
          case 0x2E: // U+002E FULL STOP character (.)
            mode = TokenizerMode.dot1;
            break;
          default:
            throw ParserException('Unexpected character ${Rune(current).describe()} after end quote', line, column);
        }
        break;

      case TokenizerMode.doubleQuote:
        switch (current) {
          case -1:
            throw ParserException('Unexpected end of file inside string', line, column);
          case 0x0A: // U+000A LINE FEED (LF)
            throw ParserException('Unexpected end of line inside string', line, column);
          case 0x22: // U+0022 QUOTATION MARK character (")
            yield StringToken(String.fromCharCodes(buffer), line, column);
            buffer.clear();
            mode = TokenizerMode.endQuote;
            break;
          case 0x5C: // U+005C REVERSE SOLIDUS character (\)
            mode = TokenizerMode.doubleQuoteEscape;
            break;
          default:
            buffer.add(current);
        }
        break;

      case TokenizerMode.doubleQuoteEscape:
        switch (current) {
          case -1:
            throw ParserException('Unexpected end of file inside string', line, column);
          case 0x22: // U+0022 QUOTATION MARK character (")
          case 0x27: // U+0027 APOSTROPHE character (')
          case 0x5C: // U+005C REVERSE SOLIDUS character (\)
          case 0x2F: // U+002F SOLIDUS character (/)
            buffer.add(current);
            mode = TokenizerMode.doubleQuote;
            break;
          case 0x62: // U+0062 LATIN SMALL LETTER B character
            buffer.add(0x08);
            mode = TokenizerMode.doubleQuote;
            break;
          case 0x66: // U+0066 LATIN SMALL LETTER F character
            buffer.add(0x0C);
            mode = TokenizerMode.doubleQuote;
            break;
          case 0x6E: // U+006E LATIN SMALL LETTER N character
            buffer.add(0x0A);
            mode = TokenizerMode.doubleQuote;
            break;
          case 0x72: // U+0072 LATIN SMALL LETTER R character
            buffer.add(0x0D);
            mode = TokenizerMode.doubleQuote;
            break;
          case 0x74: // U+0074 LATIN SMALL LETTER T character
            buffer.add(0x09);
            mode = TokenizerMode.doubleQuote;
            break;
          case 0x75: // U+0075 LATIN SMALL LETTER U character
            assert(buffer2.isEmpty);
            mode = TokenizerMode.doubleQuoteEscapeUnicode1;
            break;
          default:
            throw ParserException('Unexpected character ${Rune(current).describe()} after backslash in string', line, column);
        }
        break;

      case TokenizerMode.doubleQuoteEscapeUnicode1:
        switch (current) {
          case -1:
            throw ParserException('Unexpected end of file inside Unicode escape', line, column);
          case 0x30: // U+0030 DIGIT ZERO character (0)
          case 0x31: // U+0031 DIGIT ONE character (1)
          case 0x32: // U+0032 DIGIT TWO character (2)
          case 0x33: // U+0033 DIGIT THREE character (3)
          case 0x34: // U+0034 DIGIT FOUR character (4)
          case 0x35: // U+0035 DIGIT FIVE character (5)
          case 0x36: // U+0036 DIGIT SIX character (6)
          case 0x37: // U+0037 DIGIT SEVEN character (7)
          case 0x38: // U+0038 DIGIT EIGHT character (8)
          case 0x39: // U+0039 DIGIT NINE character (9)
          case 0x41: // U+0041 LATIN CAPITAL LETTER A character
          case 0x42: // U+0042 LATIN CAPITAL LETTER B character
          case 0x43: // U+0043 LATIN CAPITAL LETTER C character
          case 0x44: // U+0044 LATIN CAPITAL LETTER D character
          case 0x45: // U+0045 LATIN CAPITAL LETTER E character
          case 0x46: // U+0046 LATIN CAPITAL LETTER F character
          case 0x61: // U+0061 LATIN SMALL LETTER A character
          case 0x62: // U+0062 LATIN SMALL LETTER B character
          case 0x63: // U+0063 LATIN SMALL LETTER C character
          case 0x64: // U+0064 LATIN SMALL LETTER D character
          case 0x65: // U+0065 LATIN SMALL LETTER E character
          case 0x66: // U+0066 LATIN SMALL LETTER F character
            buffer2.add(current);
            mode = TokenizerMode.doubleQuoteEscapeUnicode2;
            break;
          default:
            throw ParserException('Unexpected character ${Rune(current).describe()} in Unicode escape', line, column);
        }
        break;

      case TokenizerMode.doubleQuoteEscapeUnicode2:
        switch (current) {
          case -1:
            throw ParserException('Unexpected end of file inside Unicode escape', line, column);
          case 0x30: // U+0030 DIGIT ZERO character (0)
          case 0x31: // U+0031 DIGIT ONE character (1)
          case 0x32: // U+0032 DIGIT TWO character (2)
          case 0x33: // U+0033 DIGIT THREE character (3)
          case 0x34: // U+0034 DIGIT FOUR character (4)
          case 0x35: // U+0035 DIGIT FIVE character (5)
          case 0x36: // U+0036 DIGIT SIX character (6)
          case 0x37: // U+0037 DIGIT SEVEN character (7)
          case 0x38: // U+0038 DIGIT EIGHT character (8)
          case 0x39: // U+0039 DIGIT NINE character (9)
          case 0x41: // U+0041 LATIN CAPITAL LETTER A character
          case 0x42: // U+0042 LATIN CAPITAL LETTER B character
          case 0x43: // U+0043 LATIN CAPITAL LETTER C character
          case 0x44: // U+0044 LATIN CAPITAL LETTER D character
          case 0x45: // U+0045 LATIN CAPITAL LETTER E character
          case 0x46: // U+0046 LATIN CAPITAL LETTER F character
          case 0x61: // U+0061 LATIN SMALL LETTER A character
          case 0x62: // U+0062 LATIN SMALL LETTER B character
          case 0x63: // U+0063 LATIN SMALL LETTER C character
          case 0x64: // U+0064 LATIN SMALL LETTER D character
          case 0x65: // U+0065 LATIN SMALL LETTER E character
          case 0x66: // U+0066 LATIN SMALL LETTER F character
            buffer2.add(current);
            mode = TokenizerMode.doubleQuoteEscapeUnicode3;
            break;
          default:
            throw ParserException('Unexpected character ${Rune(current).describe()} in Unicode escape', line, column);
        }
        break;

      case TokenizerMode.doubleQuoteEscapeUnicode3:
        switch (current) {
          case -1:
            throw ParserException('Unexpected end of file inside Unicode escape', line, column);
          case 0x30: // U+0030 DIGIT ZERO character (0)
          case 0x31: // U+0031 DIGIT ONE character (1)
          case 0x32: // U+0032 DIGIT TWO character (2)
          case 0x33: // U+0033 DIGIT THREE character (3)
          case 0x34: // U+0034 DIGIT FOUR character (4)
          case 0x35: // U+0035 DIGIT FIVE character (5)
          case 0x36: // U+0036 DIGIT SIX character (6)
          case 0x37: // U+0037 DIGIT SEVEN character (7)
          case 0x38: // U+0038 DIGIT EIGHT character (8)
          case 0x39: // U+0039 DIGIT NINE character (9)
          case 0x41: // U+0041 LATIN CAPITAL LETTER A character
          case 0x42: // U+0042 LATIN CAPITAL LETTER B character
          case 0x43: // U+0043 LATIN CAPITAL LETTER C character
          case 0x44: // U+0044 LATIN CAPITAL LETTER D character
          case 0x45: // U+0045 LATIN CAPITAL LETTER E character
          case 0x46: // U+0046 LATIN CAPITAL LETTER F character
          case 0x61: // U+0061 LATIN SMALL LETTER A character
          case 0x62: // U+0062 LATIN SMALL LETTER B character
          case 0x63: // U+0063 LATIN SMALL LETTER C character
          case 0x64: // U+0064 LATIN SMALL LETTER D character
          case 0x65: // U+0065 LATIN SMALL LETTER E character
          case 0x66: // U+0066 LATIN SMALL LETTER F character
            buffer2.add(current);
            mode = TokenizerMode.doubleQuoteEscapeUnicode4;
            break;
          default:
            throw ParserException('Unexpected character ${Rune(current).describe()} in Unicode escape', line, column);
        }
        break;

      case TokenizerMode.doubleQuoteEscapeUnicode4:
        switch (current) {
          case -1:
            throw ParserException('Unexpected end of file inside Unicode escape', line, column);
          case 0x30: // U+0030 DIGIT ZERO character (0)
          case 0x31: // U+0031 DIGIT ONE character (1)
          case 0x32: // U+0032 DIGIT TWO character (2)
          case 0x33: // U+0033 DIGIT THREE character (3)
          case 0x34: // U+0034 DIGIT FOUR character (4)
          case 0x35: // U+0035 DIGIT FIVE character (5)
          case 0x36: // U+0036 DIGIT SIX character (6)
          case 0x37: // U+0037 DIGIT SEVEN character (7)
          case 0x38: // U+0038 DIGIT EIGHT character (8)
          case 0x39: // U+0039 DIGIT NINE character (9)
          case 0x41: // U+0041 LATIN CAPITAL LETTER A character
          case 0x42: // U+0042 LATIN CAPITAL LETTER B character
          case 0x43: // U+0043 LATIN CAPITAL LETTER C character
          case 0x44: // U+0044 LATIN CAPITAL LETTER D character
          case 0x45: // U+0045 LATIN CAPITAL LETTER E character
          case 0x46: // U+0046 LATIN CAPITAL LETTER F character
          case 0x61: // U+0061 LATIN SMALL LETTER A character
          case 0x62: // U+0062 LATIN SMALL LETTER B character
          case 0x63: // U+0063 LATIN SMALL LETTER C character
          case 0x64: // U+0064 LATIN SMALL LETTER D character
          case 0x65: // U+0065 LATIN SMALL LETTER E character
          case 0x66: // U+0066 LATIN SMALL LETTER F character
            buffer2.add(current);
            buffer.add(int.parse(String.fromCharCodes(buffer2), radix: 16));
            buffer2.clear();
            mode = TokenizerMode.doubleQuote;
            break;
          default:
            throw ParserException('Unexpected character ${Rune(current).describe()} in Unicode escape', line, column);
        }
        break;

      case TokenizerMode.endDoubleQuote:
        switch (current) {
          case -1:
            yield EofToken(line, column);
            return;
          case 0x0A: // U+000A LINE FEED (LF)
          case 0x20: // U+0020 SPACE character
            mode = TokenizerMode.main;
            break;
          case 0x28: // U+0028 LEFT PARENTHESIS character (()
          case 0x29: // U+0029 RIGHT PARENTHESIS character ())
          case 0x2C: // U+002C COMMA character (,)
          case 0x3A: // U+003A COLON character (:)
          case 0x3B: // U+003B SEMICOLON character (;)
          case 0x3D: // U+003D EQUALS SIGN character (=)
          case 0x5B: // U+005B LEFT SQUARE BRACKET character ([)
          case 0x5D: // U+005D RIGHT SQUARE BRACKET character (])
          case 0x7B: // U+007B LEFT CURLY BRACKET character ({)
          case 0x7D: // U+007D RIGHT CURLY BRACKET character (})
            yield SymbolToken(current, line, column);
            mode = TokenizerMode.main;
            break;
          case 0x2E: // U+002E FULL STOP character (.)
            mode = TokenizerMode.dot1;
            break;
          default:
            throw ParserException('Unexpected character ${Rune(current).describe()} after end doublequote', line, column);
        }
        break;

      case TokenizerMode.slash:
        switch (current) {
          case -1:
            throw ParserException('Unexpected end of file inside comment delimiter', line, column);
          case 0x2F: // U+002F SOLIDUS character (/)
            mode = TokenizerMode.comment;
            break;
          default:
            throw ParserException('Unexpected character ${Rune(current).describe()} inside comment delimiter', line, column);
        }
        break;

      case TokenizerMode.comment:
        switch (current) {
          case -1:
            yield EofToken(line, column);
            return;
          case 0x0A: // U+000A LINE FEED (LF)
            mode = TokenizerMode.main;
            break;
          default:
            // ignored, comment
            break;
        }
        break;
    }
    index += 1;
  }
}
