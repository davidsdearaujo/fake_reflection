import 'named_param.dart';
import 'positional_param.dart';

typedef NewConstructor = Function;

class ClassData {
  final String className;
  final Set<NamedParam> namedParams;
  final List<PositionalParam> positionalParams;
  final List<PositionalParam> notRequiredPositionalParams;
  const ClassData({
    required this.className,
    required this.namedParams,
    required this.positionalParams,
    required this.notRequiredPositionalParams,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClassData &&
        other.className == className &&
        other.namedParams == namedParams &&
        other.positionalParams == positionalParams &&
        other.notRequiredPositionalParams == notRequiredPositionalParams;
  }

  @override
  int get hashCode {
    return className.hashCode ^ namedParams.hashCode ^ positionalParams.hashCode ^ notRequiredPositionalParams.hashCode;
  }

  @override
  String toString() {
    return 'ClassData(className: $className, namedParams: $namedParams, positionalParams: $positionalParams, notRequiredPositionalParams: $notRequiredPositionalParams)';
  }
}
