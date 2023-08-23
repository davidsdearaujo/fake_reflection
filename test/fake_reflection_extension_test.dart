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

class Test4Class {
  final int? param1;
  final bool? param2;
  const Test4Class(this.param1, [this.param2]);
}

class Test5Class {
  final int? param1;
  const Test5Class([this.param1]);
}

class Test6Class<T> {}

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
      test('notRequiredPositionalParams', () {
        expect(classData.notRequiredPositionalParams.isEmpty, true);
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
      test('notRequiredPositionalParams', () {
        expect(classData.notRequiredPositionalParams.isEmpty, true);
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
      test('notRequiredPositionalParams', () {
        expect(classData.notRequiredPositionalParams.isEmpty, true);
      });
    });
    group('Test4Class', () {
      late ClassData classData;
      setUp(() {
        classData = Test4Class.new.reflection();
      });
      test('className', () {
        expect(classData.className, 'Test4Class');
      });
      test('namedParams', () {
        expect(classData.namedParams.isEmpty, true);
      });
      test('positionalParams', () {
        expect(classData.positionalParams, [
          const PositionalParam(type: 'int', nullable: true),
        ]);
      });
      test('notRequiredPositionalParams', () {
        expect(classData.notRequiredPositionalParams, [
          const PositionalParam(type: 'bool', nullable: true),
        ]);
      });
    });
    group('Test5Class', () {
      late ClassData classData;
      setUp(() {
        classData = Test5Class.new.reflection();
      });
      test('className', () {
        expect(classData.className, 'Test5Class');
      });
      test('namedParams', () {
        expect(classData.namedParams.isEmpty, true);
      });
      test('positionalParams', () {
        expect(classData.positionalParams.isEmpty, true);
      });
      test('notRequiredPositionalParams', () {
        expect(classData.notRequiredPositionalParams, [
          const PositionalParam(type: 'int', nullable: true),
        ]);
      });
    });
    group('Test6Class (without params)', () {
      late ClassData classData;
      setUp(() {
        classData = Test6Class<Test5Class>.new.reflection();
      });
      test('className', () {
        expect(classData.className, 'Test6Class');
      });
      test('namedParams', () {
        expect(classData.namedParams.isEmpty, true);
      });
      test('positionalParams', () {
        expect(classData.positionalParams.isEmpty, true);
      });
      test('notRequiredPositionalParams', () {
        expect(classData.notRequiredPositionalParams, []);
      });
    });
  });
}
