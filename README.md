
Package to get a class structure (like reflection) in runtime **without code generation.**

## Features
 - Get Class name;
 - Get named params: _name, type, isNullable, isRequired_;
 - Get positional params: _type, isNullable_
 - Get positional not required params: _type, isNullable_

## Usage

pubspec.yaml
```yaml
dependencies:
 ...
 fake_reflection: <last version here>
```

import
```dart
import 'package:fake_reflection/fake_reflection.dart';
```

using
```dart
  ClassData classData = YourClass.new.reflection();
```

Example
```dart
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

void main() {
  ClassData classData = Test1Class.new.reflection();
  print(classData.className);
  // output: Test1Class

  print(classData.namedParams);
  // output:
  // {
  //    NamedParam(name: param2, type: String, required: false, nullable: true), 
  //    NamedParam(name: param3, type: Map<dynamic, dynamic>, required: true, nullable: false), 
  //    NamedParam(name: param4, type: Map<List<dynamic>, double>, required: true, nullable: true)
  // }
  
  print(classData.positionalParams); 
  // output: 
  // [
  //   PositionalParam(type: int, nullable: false, required: true),
  // ]
  
  print(classData.notRequiredPositionalParams); 
  //output: []
}
```
