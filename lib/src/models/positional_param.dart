class PositionalParam {
  final String type;
  final bool nullable;

  const PositionalParam({
    required this.type,
    required this.nullable,
  });

  @override
  String toString() => 'PositionalParam(type: $type, nullable: $nullable)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PositionalParam &&
      other.type == type &&
      other.nullable == nullable;
  }

  @override
  int get hashCode => type.hashCode ^ nullable.hashCode;
}
