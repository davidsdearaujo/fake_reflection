# fake_reflection

A flutter package to get class structure in runtime without code generation. With this package, you can get the class name, named params, positional params, and positional non-required params.

## Features

- Get class name
- Get named params: name, type, isNullable, isRequired
- Get positional params: type, isNullable
- Get positional non-required params: type, isNullable

## Installation

Add this to your `pubspec.yaml` file:

```yaml
dependencies:
 ...
 fake_reflection: <last version here>
```

## Usage

Import the package into your dart code:

```dart
import 'package:fake_reflection/fake_reflection.dart';
```

To use it, simply create an instance of the class you want to reflect on and call the `reflection()` method on it:

```dart
ClassData classData = YourClass.new.reflection();
```

## Example

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

That's it! You can now use the `fake_reflection` package to reflect on class structures in runtime without code generation.
