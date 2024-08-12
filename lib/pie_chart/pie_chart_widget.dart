import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pie_chart_project/formatter/number_formatters.dart';
import 'package:pie_chart_project/pie_chart/pie_chart_painter.dart';
import 'package:pie_chart_project/pie_chart/pie_chart_segment.dart';

class PieChart extends StatefulWidget {
  final List<PieChartSegment> segments;
  final String portfolioValue;

  const PieChart({
    required this.portfolioValue,
    required this.segments,
    super.key,
  });

  @override
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> with TickerProviderStateMixin {
  late AnimationController _generalController;
  late Animation<double> _generalAnimation;
  late AnimationController _selectionController;
  late Animation<double> _selectionAnimation;
  int selectedIndex = -1;
  int previousIndex = -1;

  bool isAscending = true;
  List<PieChartSegment> sortedSegments = [];

  String get selectedItemAmount {
    return NumberFormatters.formatCurrencyWithSymbol(
            symbol: sortedSegments[selectedIndex].currency.currencyIcon)
        .format(sortedSegments[selectedIndex].amount);
  }

  @override
  void initState() {
    super.initState();
    _generalController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    _generalAnimation =
        CurvedAnimation(parent: _generalController, curve: Curves.easeInOut);

    _selectionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _selectionAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _selectionController,
        curve: Curves.easeInOut,
      ),
    );
    sortedSegments = List.from(widget.segments);
  }

  @override
  void dispose() {
    _generalController.dispose();
    _selectionController.dispose();
    super.dispose();
  }

  void onSegmentTap(int index) {
    setState(
      () {
        if (selectedIndex == index) {
          _selectionController.reverse().whenComplete(
            () {
              setState(
                () {
                  selectedIndex = -1;
                  previousIndex = -1;
                },
              );
            },
          );
        } else {
          if (selectedIndex != -1) {
            _selectionController.reverse().whenComplete(
              () {
                setState(
                  () {
                    previousIndex = selectedIndex;
                    selectedIndex = index;
                    _selectionController.forward(from: 0);
                  },
                );
              },
            );
          } else {
            selectedIndex = index;
            _selectionController.forward(from: 0);
          }
        }
      },
    );
  }

  void onTapPainterIndex(TapUpDetails details) {
    final tapPosition = details.localPosition;

    const size = Size(188, 188);
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    final dx = tapPosition.dx - center.dx;
    final dy = tapPosition.dy - center.dy;

    if (dx * dx + dy * dy <= radius * radius) {
      final tapAngle = (atan2(dy, dx) + pi / 2) % (2 * pi);

      double startAngle = 0.0;
      final total = sortedSegments.fold<double>(
          0, (sum, segment) => sum + segment.chartValue);

      for (int i = 0; i < sortedSegments.length; i++) {
        final sweepAngle = 2 * pi * (sortedSegments[i].chartValue / total);
        if (tapAngle >= startAngle && tapAngle < startAngle + sweepAngle) {
          onSegmentTap(i);
          break;
        }
        startAngle += sweepAngle;
      }
    }
  }

  void sortSegments() {
    setState(
      () {
        if (isAscending) {
          sortedSegments.sort((a, b) => b.chartValue.compareTo(a.chartValue));
        } else {
          sortedSegments.sort((a, b) => a.chartValue.compareTo(b.chartValue));
        }

        isAscending = !isAscending;

        selectedIndex = -1;
        _generalController.reset();
        _generalController.forward();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          color: Colors.white,
          width: 300,
          child: SizedBox(
            height: 200,
            width: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: Listenable.merge(
                    [_generalAnimation, _selectionAnimation],
                  ),
                  builder: (context, child) {
                    return GestureDetector(
                      onTapUp: (details) => onTapPainterIndex(details),
                      child: CustomPaint(
                        size: const Size(188, 188),
                        painter: PieChartPainter(
                          segments: sortedSegments,
                          animationValue: _generalAnimation.value,
                          selectedIndex: selectedIndex,
                          selectedScale: _selectionAnimation.value,
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        selectedIndex != -1
                            ? sortedSegments[selectedIndex].label
                            : 'Total Expense',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        selectedIndex != -1
                            ? selectedItemAmount
                            : widget.portfolioValue,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isAscending ? 'Increasing Rate' : 'Decreasing Rate',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              GestureDetector(
                onTap: sortSegments,
                child: Text(
                  'Sort By',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.inverseSurface,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ListView.separated(
          key: ValueKey(sortedSegments),
          shrinkWrap: true,
          primary: false,
          itemCount: sortedSegments.length,
          separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(height: 1),
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onSegmentTap(index),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? Theme.of(context).colorScheme.inversePrimary
                      : Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 7,
                            backgroundColor: sortedSegments[index].color,
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 60,
                            child: Text(
                              '%${sortedSegments[index].listValue}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            sortedSegments[index].label,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        NumberFormatters.formatCurrencyWithSymbol(
                          symbol: sortedSegments[index].currency.currencyIcon,
                        ).format(
                          sortedSegments[index].amount,
                        ),
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
