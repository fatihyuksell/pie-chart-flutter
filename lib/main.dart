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
        //90-2.5-2.3-1.9-1.25-1.25-0.8
        // PositionAnalysis(
        //   distribution: 90,
        // ),
        // PositionAnalysis(
        //   distribution: 2.5,
        // ),
        // PositionAnalysis(
        //   distribution: 2.3,
        // ),
        // PositionAnalysis(
        //   distribution: 1.9,
        // ),
        // PositionAnalysis(
        //   distribution: 1.25,
        // ),
        // PositionAnalysis(
        //   distribution: 1.25,
        // ),
        // PositionAnalysis(
        //   distribution: 0.8,
        // ),
        //90-1-1-1-1-1-1-1-1-1-1
        // PositionAnalysis(distribution: 90),
        // PositionAnalysis(distribution: 1),
        // PositionAnalysis(distribution: 1),
        // PositionAnalysis(distribution: 1),
        // PositionAnalysis(distribution: 1),
        // PositionAnalysis(distribution: 1),
        // PositionAnalysis(distribution: 1),
        // PositionAnalysis(distribution: 1),
        // PositionAnalysis(distribution: 1),
        // PositionAnalysis(distribution: 1),
        // PositionAnalysis(distribution: 1),

        //30-18-12-10-10-10-10-5-3-2
        // PositionAnalysis(distribution: 30),
        // PositionAnalysis(distribution: 18),
        // PositionAnalysis(distribution: 12),
        // PositionAnalysis(distribution: 10),
        // PositionAnalysis(distribution: 10),
        // PositionAnalysis(distribution: 10),
        // PositionAnalysis(distribution: 10),
        // PositionAnalysis(distribution: 5),
        // PositionAnalysis(distribution: 3),
        // PositionAnalysis(distribution: 2),

        //30-18-12-8-7-5-5-5-5-5-5-5-5-5-4-1-1-1-1-1-1
        // PositionAnalysis(distribution: 30),
        // PositionAnalysis(distribution: 18),
        // PositionAnalysis(distribution: 12),
        // PositionAnalysis(distribution: 8),
        // PositionAnalysis(distribution: 7),
        // PositionAnalysis(distribution: 5),
        // PositionAnalysis(distribution: 5),
        // PositionAnalysis(distribution: 5),
        // PositionAnalysis(distribution: 5),
        // PositionAnalysis(distribution: 5),
        // PositionAnalysis(distribution: 5),
        // PositionAnalysis(distribution: 5),
        // PositionAnalysis(distribution: 4),
        // PositionAnalysis(distribution: 1),
        // PositionAnalysis(distribution: 1),
        // PositionAnalysis(distribution: 1),
        // PositionAnalysis(distribution: 1),
        // PositionAnalysis(distribution: 1),
        // PositionAnalysis(distribution: 1),

        //48-42-10
        // PositionAnalysis(distribution: 48),
        // PositionAnalysis(distribution: 42),
        // PositionAnalysis(distribution: 10),

        //52-46-2
        // PositionAnalysis(distribution: 52),
        // PositionAnalysis(distribution: 46),
        // PositionAnalysis(distribution: 2),

        // PositionAnalysis(distribution: 30),
        //         PositionAnalysis(distribution: 18),
        // PositionAnalysis(distribution: 12),
        // PositionAnalysis(distribution: 8),
        // PositionAnalysis(distribution: 7),
        // PositionAnalysis(distribution: 5),
        // PositionAnalysis(distribution: 5),
        // PositionAnalysis(distribution: 5),
        // PositionAnalysis(distribution: 5),
        // PositionAnalysis(distribution: 5),
        // PositionAnalysis(distribution: 5),
        // PositionAnalysis(distribution: 5),
        // PositionAnalysis(distribution: 4),
        // PositionAnalysis(distribution: 30),
        // PositionAnalysis(distribution: 5),
        // PositionAnalysis(distribution: 5),
        // PositionAnalysis(distribution: 1),
        // PositionAnalysis(distribution: 1),
        // PositionAnalysis(distribution: 1),
        // PositionAnalysis(distribution: 1),
        // PositionAnalysis(distribution: 1),
        // PositionAnalysis(distribution: 1),

        // PositionAnalysis(distribution: 5),
        // PositionAnalysis(distribution: 5),
        // PositionAnalysis(distribution: 5),
      ],
    );

    super.initState();
  }

  String get portfolioTotalValue => NumberFormatters.formatCurrencyWithSymbol(
              symbol: portfolioResponse!.totalEquityValue.currency.currencyIcon)
          .format(
        portfolioResponse!.totalEquityValue.amount,
      );

  final List<Color> fixedColors = [
    const Color(0xFF7A65FC),
    const Color(0xFF11BFDE),
    const Color(0xFFFC7A5D),
    const Color(0xFFFFA726),
    const Color(0xFFFFCC01),
    // const Color(0xFFA5D6A7),
    // const Color(0xFF4DB6AC),
    // const Color(0xFF64B5F6),
    // const Color(0xFF9575CD),
  ];

  Color getColor(int index) {
    final colorIndex = index % fixedColors.length;
    final nextColorIndex = (index + 1) % fixedColors.length;
    if (fixedColors[colorIndex] == fixedColors[nextColorIndex]) {
      return fixedColors[(colorIndex + 1) % fixedColors.length];
    }
    return fixedColors[colorIndex];
  }

  List<PieChartSegment> get pieChartSegments {
    final List<PieChartSegment> segments = [];
    double othersTotal = 0.0;
    double othersTotalAmount = 0;

    if (portfolioResponse != null) {
      if (portfolioResponse!.positionAnalysis.isEmpty) {
        segments.add(
          PieChartSegment(
            color: getColor(segments.length),
            chartValue: 100,
            label: 'Empty Space',
            amount: 0,
            currency: Currency.usd,
            listValue: 100,
          ),
        );
      }
    }
    for (final analysis in portfolioResponse!.positionAnalysis) {
      if (analysis.distribution >= 5) {
        segments.add(
          PieChartSegment(
            color: getColor(segments.length),
            chartValue: analysis.distribution,
            label: analysis.symbol ?? 'AAPL',
            amount: analysis.totalValue?.amount ?? 0,
            currency: analysis.totalValue?.currency ?? Currency.usd,
            listValue: analysis.distribution,
          ),
        );
      } else {
        othersTotal += analysis.distribution;
        othersTotalAmount += analysis.totalValue?.amount ?? 0;
      }
    }

    if (othersTotal > 0) {
      segments.insert(
        0,
        PieChartSegment(
          color: getColor(segments.length),
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
