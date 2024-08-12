import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:intl/intl.dart';

mixin NumberFormatters {
  static CurrencyTextInputFormatter get currencyInputFormatter =>
      CurrencyTextInputFormatter.currency(
        locale: 'en',
        decimalDigits: 2,
        symbol: '\$',
      );

  static NumberFormat get currencyFormatter => NumberFormat.currency(
        locale: 'en',
        symbol: '\$',
        decimalDigits: 2,
      );

  static NumberFormat formatCurrencyWithSymbol({
    required String symbol,
    int decimalDigits = 2,
  }) {
    return NumberFormat.currency(
      locale: 'en',
      symbol: symbol,
      decimalDigits: decimalDigits,
    );
  }
}
