
It's a package to get a class structure (like reflection) in runtime without code generation.

## Features
 - Get Class name;
 - Get named params: _name, type, isNullable, isRequired_;
 - Get positional params: _type, isNullable_

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
  print(classData.className); //Test1Class
  print(classData.namedParams); /* 
  {
     NamedParam(name: param2, type: String, required: false, nullable: true), 
     NamedParam(name: param3, type: Map<dynamic, dynamic>, required: true, nullable: false), 
     NamedParam(name: param4, type: Map<List<dynamic>, double>, required: true, nullable: true)
   }
  */
  print(classData.positionalParams); //PositionalParam(type: int, nullable: false)

}
```

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
