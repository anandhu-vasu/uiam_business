extension StringNullExtension on String? {
  bool get isNullOrEmpty => this?.isEmpty ?? true;
}
