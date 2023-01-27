class Rune {
  final int value;
  const Rune(this.value);

  String describe() {
    assert(value >= 0);
    assert(value < 0x10FFFF);
    if (value > 0x20) {
      return 'U+${value.toRadixString(16).toUpperCase().padLeft(4, "0")} ("${String.fromCharCode(value)}")';
    }
    return 'U+${value.toRadixString(16).toUpperCase().padLeft(4, "0")}';
  }
}
