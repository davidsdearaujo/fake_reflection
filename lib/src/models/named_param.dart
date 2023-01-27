class NamedParam {
  final String name;
  final String type;
  final bool required;
  final bool nullable;
  const NamedParam({
    required this.name,
    required this.type,
    required this.required,
    required this.nullable,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NamedParam && other.name == name;
  }

  @override
  int get hashCode {
    return name.hashCode;
  }

  @override
  String toString() {
    return 'NamedParam(name: $name, type: $type, required: $required, nullable: $nullable)';
  }

  NamedParam copyWith({
    String? name,
    String? type,
    bool? required,
    bool? nullable,
  }) {
    return NamedParam(
      name: name ?? this.name,
      type: type ?? this.type,
      required: required ?? this.required,
      nullable: nullable ?? this.nullable,
    );
  }
}
