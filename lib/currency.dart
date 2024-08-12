enum Currency {
  usd(value: 'USD', currencyIcon: '\$'),
  pound(value: 'GBP', currencyIcon: '£');

  final String value;
  final String currencyIcon;

  const Currency({required this.value, required this.currencyIcon});

  static Currency fromString(String value) {
    return Currency.values
        .firstWhere((e) => e.value == value, orElse: () => Currency.usd);
  }
}
