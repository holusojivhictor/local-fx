extension NumExtensions on num {
  /// A decimal-point string-representation of this number without padding.
  String toStringWoutPadding(int digits) {
    if (this == 0) return '0.00';
    return toStringAsFixed(digits).replaceAll(RegExp(r'([.]*0+)$'), '');
  }
}
