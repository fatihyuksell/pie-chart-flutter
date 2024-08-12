import 'package:flutter/material.dart';
import 'package:pie_chart_project/currency.dart';

final class PieChartSegment {
  final Color color;
  final double chartValue;
  final double? listValue;
  final String label;
  final double amount;
  final Currency currency;

  const PieChartSegment({
    required this.color,
    required this.chartValue,
    required this.label,
    required this.amount,
    required this.currency,
    this.listValue,
  });
}
