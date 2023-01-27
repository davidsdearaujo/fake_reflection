import 'package:fake_reflection/fake_reflection.dart';
import 'package:test/test.dart';

class Test1Class {
  final int param1;
  final String? param2;
  final Map param3;
  final Map<List, double>? param4;
  const Test1Class(
    this.param1, {
    this.param2,
    required this.param3,
    required this.param4,
  });
}

class Test2Class {
  final int? param1;
  const Test2Class(this.param1);
}

class Test3Class {
  final int? param1;
  final String? param2;
  final Map param3;
  final Map<List<Map<List, double?>>, double>? param4;
  const Test3Class(
    this.param1, {
    this.param2,
    required this.param3,
    required this.param4,
  });
}

void main() {
  group('reflection()', () {
    group('Test1Class', () {
      late ClassData classData;
      setUp(() {
        classData = Test1Class.new.reflection();
      });
      test('className', () {
        expect(classData.className, 'Test1Class');
      });
      test('namedParams', () {
        expect(classData.namedParams, {
          const NamedParam(name: 'param2', type: 'String', required: false, nullable: true),
          const NamedParam(name: 'param3', type: 'Map<dynamic, dynamic>', required: true, nullable: false),
          const NamedParam(name: 'param4', type: 'Map<List<dynamic>, double>', required: true, nullable: true),
        });
      });
      test('positionalParams', () {
        expect(classData.positionalParams, [
          const PositionalParam(type: 'int', nullable: false),
        ]);
      });
    });
    group('Test2Class', () {
      late ClassData classData;
      setUp(() {
        classData = Test2Class.new.reflection();
      });
      test('className', () {
        expect(classData.className, 'Test2Class');
      });
      test('namedParams', () {
        expect(classData.namedParams.isEmpty, true);
      });
      test('positionalParams', () {
        expect(classData.positionalParams, [
          const PositionalParam(type: 'int', nullable: true),
        ]);
      });
    });
    group('Test3Class', () {
      late ClassData classData;
      setUp(() {
        classData = Test3Class.new.reflection();
      });
      test('className', () {
        expect(classData.className, 'Test3Class');
      });
      test('namedParams', () {
        expect(classData.namedParams, {
          const NamedParam(name: 'param2', type: 'String', required: false, nullable: true),
          const NamedParam(name: 'param3', type: 'Map<dynamic, dynamic>', required: true, nullable: false),
          const NamedParam(name: 'param4', type: 'Map<List<Map<List, double?>>, double>, double>', required: true, nullable: true),
        });
      });
      test('positionalParams', () {
        expect(classData.positionalParams, [
          const PositionalParam(type: 'int', nullable: true),
        ]);
      });
    });
  });
}
