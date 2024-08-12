import 'package:equatable/equatable.dart';
import 'package:pie_chart_project/model/amount.dart';

class PortfolioResponse extends Equatable {
  final Amount totalEquityValue;
  final List<PositionAnalysis> positionAnalysis;

  const PortfolioResponse({
    required this.totalEquityValue,
    required this.positionAnalysis,
  });

  PortfolioResponse copyWith({
    Amount? totalEquityValue,
    List<PositionAnalysis>? positionAnalysis,
  }) {
    return PortfolioResponse(
      totalEquityValue: totalEquityValue ?? this.totalEquityValue,
      positionAnalysis: positionAnalysis ?? this.positionAnalysis,
    );
  }

  factory PortfolioResponse.fromJson(Map<String, dynamic> json) {
    return PortfolioResponse(
      totalEquityValue: Amount.fromJson(json['totalEquityValue']),
      positionAnalysis: List<PositionAnalysis>.from(
        json['positionAnalysis']?.map(
          (x) => PositionAnalysis.fromJson(x),
        ),
      ),
    );
  }

  @override
  String toString() =>
      '''PortfolioResponse(totalEquityValue: $totalEquityValue, positionAnalysis: $positionAnalysis)''';

  @override
  List<Object> get props => [
        totalEquityValue,
        positionAnalysis,
      ];
}

class PositionAnalysis extends Equatable {
  final String symbol;
  final double distribution;
  final Amount totalValue;

  const PositionAnalysis({
    required this.symbol,
    required this.distribution,
    required this.totalValue,
  });

  PositionAnalysis copyWith({
    String? symbol,
    double? distribution,
    Amount? totalValue,
  }) {
    return PositionAnalysis(
      symbol: symbol ?? this.symbol,
      distribution: distribution ?? this.distribution,
      totalValue: totalValue ?? this.totalValue,
    );
  }

  factory PositionAnalysis.fromJson(Map<String, dynamic> json) {
    return PositionAnalysis(
      symbol: json['symbol'],
      distribution: json['distribution'],
      totalValue: Amount.fromJson(json['totalValue']),
    );
  }

  @override
  String toString() =>
      '''PositionAnalysis(symbol: $symbol, distribution: $distribution, totalValue: $totalValue)''';

  @override
  List<Object> get props => [
        symbol,
        distribution,
        totalValue,
      ];
}
