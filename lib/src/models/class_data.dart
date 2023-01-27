import 'named_param.dart';
import 'positional_param.dart';

typedef NewConstructor = Function;

class ClassData {
  final String className;
  final Set<NamedParam> namedParams;
  final List<PositionalParam> positionalParams;
  const ClassData({
    required this.className,
    required this.namedParams,
    required this.positionalParams,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ClassData && other.className == className && other.namedParams == namedParams;
  }

  @override
  int get hashCode => className.hashCode ^ namedParams.hashCode;

  @override
  String toString() => 'ClassData(className: $className, positionalPrams: $positionalParams namedParams: $namedParams)';
}
