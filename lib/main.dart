import 'package:flutter/material.dart';
import 'package:pie_chart_project/currency.dart';
import 'package:pie_chart_project/formatter/number_formatters.dart';
import 'package:pie_chart_project/model/amount.dart';
import 'package:pie_chart_project/model/portfolio_response.dart';
import 'package:pie_chart_project/pie_chart/pie_chart_segment.dart';
import 'package:pie_chart_project/pie_chart/pie_chart_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pie Chart Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Pie Chart Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PortfolioResponse? portfolioResponse;
  @override
  void initState() {
    portfolioResponse = const PortfolioResponse(
      totalEquityValue: Amount(amount: 1000, currency: Currency.usd),
      positionAnalysis: [
        PositionAnalysis(
          symbol: 'Fruits & Vegetables',
          distribution: 20,
          totalValue: Amount(amount: 200, currency: Currency.usd),
        ),
        PositionAnalysis(
          symbol: 'Dairy & Eggs',
          distribution: 15,
          totalValue: Amount(amount: 150, currency: Currency.usd),
        ),
        PositionAnalysis(
          symbol: 'Meat & Seafood',
          distribution: 10,
          totalValue: Amount(amount: 100, currency: Currency.usd),
        ),
        PositionAnalysis(
          symbol: 'Grains & Bread',
          distribution: 5,
          totalValue: Amount(amount: 50, currency: Currency.usd),
        ),
        PositionAnalysis(
          symbol: 'Miscellaneous',
          distribution: 5,
          totalValue: Amount(amount: 50, currency: Currency.usd),
        ),
        PositionAnalysis(
          symbol: 'TSM',
          distribution: 5,
          totalValue: Amount(amount: 50, currency: Currency.usd),
        ),
      ],
    );

    super.initState();
  }

  String get portfolioTotalValue => NumberFormatters.formatCurrencyWithSymbol(
              symbol: portfolioResponse!.totalEquityValue.currency.currencyIcon)
          .format(
        portfolioResponse!.totalEquityValue.amount,
      );

  List<Color> get fixedColors => [
        const Color(0xFF7A65FC),
        const Color(0xFF11BFDE),
        const Color(0xFFFC7A5D),
        const Color(0xFFFFA726),
        const Color(0xFFFFCC01),
        const Color(0xFFA5D6A7),
      ];

  List<PieChartSegment> get pieChartSegments {
    final List<PieChartSegment> segments = [];
    double othersTotal = 0.0;
    double othersTotalAmount = 0;

    for (final analysis in portfolioResponse!.positionAnalysis) {
      if (analysis.distribution >= 5) {
        segments.add(
          PieChartSegment(
            color: fixedColors[segments.length % fixedColors.length],
            chartValue: analysis.distribution,
            label: analysis.symbol,
            amount: analysis.totalValue.amount,
            currency: analysis.totalValue.currency,
            listValue: analysis.distribution,
          ),
        );
      } else {
        othersTotal += analysis.distribution;
        othersTotalAmount += analysis.totalValue.amount;
      }
    }

    if (othersTotal > 0) {
      segments.insert(
        0,
        PieChartSegment(
          color: fixedColors[segments.length % fixedColors.length + 1],
          chartValue: othersTotal < 5 ? 5 : othersTotal,
          label: 'Others',
          amount: othersTotalAmount,
          currency: Currency.usd,
          listValue: othersTotal,
        ),
      );
    }

    return segments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              PieChart(
                segments: pieChartSegments,
                portfolioValue: portfolioTotalValue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
