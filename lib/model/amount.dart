import 'package:equatable/equatable.dart';
import 'package:pie_chart_project/currency.dart';

class Amount extends Equatable {
  final double amount;
  final Currency currency;

  const Amount({
    required this.amount,
    required this.currency,
  });

  Amount copyWith({
    double? amount,
    Currency? currency,
  }) {
    return Amount(
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
    );
  }

  factory Amount.fromJson(Map<String, dynamic> json) {
    return Amount(
      amount: json['amount'].toDouble(),
      currency: Currency.fromString(json['currency']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currency,
    };
  }

  @override
  String toString() {
    return '''Amount(amount: $amount, currency: $currency)''';
  }

  @override
  List<Object?> get props {
    return [
      amount,
      currency,
    ];
  }
}
