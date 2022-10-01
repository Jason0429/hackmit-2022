extension StringExtensions on String {
  bool get isNumeric => int.tryParse(this) != null;

  String get possessive => this + (endsWith("s") ? "'" : "'s");

  String pluralize(int n) => "${this}${n == 1 ? "" : "s"}";

  bool get isNortheasternEmail =>
      RegExp(r"^[A-Za-z0-9._%+-]+@northeastern.edu$").hasMatch(this);
}
