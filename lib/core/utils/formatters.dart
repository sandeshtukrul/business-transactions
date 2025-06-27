import 'package:business_transactions/config/constants/string_const.dart';
import 'package:business_transactions/models/transaction.dart';
import 'package:intl/intl.dart';

class Formatters {
  /// Cached format for common case (INR + en_IN) insted of calling every time in method.
  static final _cachedCurrencyFormat = NumberFormat.simpleCurrency(
    locale: localeENIN,
    name: inrCurrencyCode,
  );

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

  static String formatTransactionAmount(
    int amount,
    TransactionType type, {
    String? currencyCode,
    String? locale,
  }) {
    return _formatAmount(
      amount,
      includeSign: true,
      currencyCode: currencyCode,
      locale: locale,
      type: type,
    );
  }

  static String _formatAmount(
    int amount, {
    required bool includeSign,
    String? currencyCode,
    String? locale,
    TransactionType? type,
  }) {
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
        sign = type == TransactionType.sent ? minusSign : plusSign;
      } else if (amount != 0) {
        sign = amount > 0 ? plusSign : minusSign;
      }
    }

    // shows amount with no decimal eg. 100 to 100
    format.minimumFractionDigits = 0;
    // shows amount with decimal upto 2 digit if amunt has decimals and round off number after two digits eg. 2.456 to 2.46
    format.maximumFractionDigits = 2;

    // convert amount paisa to rupees.
    final double amountInRupees = amount / 100.0;

    final formattedAmount = format.format(amountInRupees.abs());
    return '$sign $formattedAmount';
  }

  static String formatDate(DateTime dateTime) {
    return DateFormat(dateFormatMMMddyyyy).format(dateTime);
  }

  static String formatTime(DateTime dateTime) {
    return DateFormat(timeFormathhmma).format(dateTime);
  }

  static String formatDateTime(DateTime dateTime) {
    return DateFormat(dateTimeFormatdMMMyhmma).format(dateTime);
  }

  /// converts stored amountInPaisa to amountInRupees string
  static String getAmountInRupeeString(int amountInPaisa) {
    return (amountInPaisa / 100.0).toStringAsFixed(2);
  }

  /// parses an amount(rupees) string and returns it as an integer(paisa) to store in model.
  static int parseAmountStringToPaisa(String? amountInText) {
    return ((double.tryParse(amountInText ?? '') ?? 0.0) * 100).round();
  }
}
