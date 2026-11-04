/// Utility for formatting currency amounts with thousand separators.
abstract final class CurrencyFormatter {
  static final RegExp _thousandRegex = RegExp(r'\B(?=(\d{3})+(?!\d))');

  /// Formats amount with Bengali Taka symbol and thousand separator comma.
  /// Example: format(89990) -> "৳89,990"
  static String format(num amount, {bool showSymbol = true}) {
    final str = amount.round().toString().replaceAll(_thousandRegex, ',');
    return showSymbol ? '৳$str' : str;
  }
}
