import 'package:business_transactions/config/constants/string_const.dart';
import 'package:business_transactions/models/transaction.dart';
import 'package:intl/intl.dart';


/// Central utility for consistent formatting of Currency, Dates, and Time.
class Formatters {

  // PERFORMANCE OPTIMIZATION (Static Caching):
  // We cache the NumberFormat instance to avoid expensive object creation
  // during list scrolling, which can cause frame drops.
  static final _cachedCurrencyFormat = NumberFormat.simpleCurrency(
    locale: localeENIN,
    name: inrCurrencyCode,
  );

  /// Formats an integer amount (Paisa) into a display string (e.g. 1000 -> "₹ 1,000.00").
  static String formatCurrency(
    int amount, {
    bool includeSign = true,
    String? currencyCode,
    String? locale,
  }) {
    return _formatAmount(
      amount,
      includeSign: includeSign,
      currencyCode: currencyCode,
      locale: locale,
      type: null,
    );
  }

  /// Formats transaction amounts with a prefix sign (+/-) based on the type (Sent/Received).
  static String formatTransactionAmount(
    int amount,
    TransactionType type, {
    String? currencyCode,
    String? locale,
  }) {
    return _formatAmount(
      amount,
      includeSign: true, // Always show + or - for transactions
      currencyCode: currencyCode,
      locale: locale,
      type: type,
    );
  }

  /// Internal helper implementing the core formatting logic.
  static String _formatAmount(
    int amount, {
    required bool includeSign,
    String? currencyCode,
    String? locale,
    TransactionType? type,
  }) {

    // Logic: Use cached formatter unless a specific non-default locale is requested.
    final useDefault = (locale == null || locale == localeENIN) &&
        (currencyCode == null || currencyCode == inrCurrencyCode);

    final format = useDefault
        ? _cachedCurrencyFormat
        : NumberFormat.simpleCurrency(
            locale: locale ?? localeENIN,
            name: currencyCode ?? inrCurrencyCode,
          );
    
    String sign = '';
    if (includeSign) {
      if (type != null) {
        // Business Logic: Sent = Expense (-), Received = Income (+)
        sign = type == TransactionType.sent ? minusSign : plusSign;
      } else if (amount != 0) {
        sign = amount > 0 ? plusSign : minusSign;
      }
    }

    format.minimumFractionDigits = 0;
    format.maximumFractionDigits = 2;

    // CRITICAL MATH:
    // Database stores 'Paisa' (int) to avoid floating-point errors.
    // (e.g. 100.10 as a double can result in 100.09999999999)
    // We convert to 'Rupees' (double) only for display purposes here.
    final double amountInRupees = amount / 100.0;

    final formattedAmount = format.format(amountInRupees.abs());
    return '$sign $formattedAmount';
  }

  /// Formats date to standard list format: "MMM dd, yyyy" (e.g., Oct 24, 2023).
  static String formatDate(DateTime dateTime) {
    return DateFormat(dateFormatMMMddyyyy).format(dateTime);
  }

  /// Formats time to 12-hour format: "hh:mm a" (e.g., 10:30 PM).
  static String formatTime(DateTime dateTime) {
    return DateFormat(timeFormathhmma).format(dateTime);
  }

  /// Formats full timestamp for detailed history logs.
  static String formatDateTime(DateTime dateTime) {
    return DateFormat(dateTimeFormatdMMMyhmma).format(dateTime);
  }

  /// Helper: Converts Paisa (int) -> Rupee String (e.g., 50000 -> "500.00") for text fields.
  static String getAmountInRupeeString(int amountInPaisa) {
    return (amountInPaisa / 100.0).toStringAsFixed(2);
  }

  /// Helper: Parses User Input String -> Paisa (int) for safe storage.(e.g. "10.50" -> 1050 )
  static int parseAmountStringToPaisa(String? amountInText) {
    // tryParse handles invalid chars gracefully by defaulting to 0.0
    // .round() removes any tiny floating point errors.
    // (e.g. 10.50 * 100 → 1049.999999 → 1049 if truncated).
    return ((double.tryParse(amountInText ?? '') ?? 0.0) * 100).round();
  }
}
