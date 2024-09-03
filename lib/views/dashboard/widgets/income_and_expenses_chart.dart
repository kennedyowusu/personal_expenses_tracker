import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class IncomeAndExpensesChart extends StatefulWidget {
  const IncomeAndExpensesChart({
    super.key,
    required this.totalIncome,
    required this.totalExpenditure,
  });

  final double totalIncome;
  final double totalExpenditure;

  @override
  State<IncomeAndExpensesChart> createState() => _IncomeAndExpensesChartState();
}

class _IncomeAndExpensesChartState extends State<IncomeAndExpensesChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: (widget.totalIncome > widget.totalExpenditure
                  ? widget.totalIncome
                  : widget.totalExpenditure) +
              10,
          gridData: const FlGridData(
            show: false,
          ),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                String weekDay;
                switch (group.x.toInt()) {
                  case 0:
                    weekDay = 'Income';
                    break;
                  case 1:
                    weekDay = 'Expenditure';
                    break;
                  default:
                    weekDay = '';
                }
                return BarTooltipItem(
                  '$weekDay\n',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: (rod.toY - 1).toString(),
                      style: const TextStyle(
                        color: Colors.yellow,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              },
            ),
            touchCallback: (FlTouchEvent event, barTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    barTouchResponse == null ||
                    barTouchResponse.spot == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
              });
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  switch (value.toInt()) {
                    case 0:
                      return const Text(
                        'Income',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      );
                    case 1:
                      return const Text(
                        'Expenditure',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      );
                    default:
                      return const Text('');
                  }
                },
              ),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: _createBarGroups(),
        ),
      ),
    );
  }

  List<BarChartGroupData> _createBarGroups() {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: widget.totalIncome,
            color: Colors.green,
            width: 20,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 0,
              color: Colors.green.withOpacity(0.1),
            ),
          ),
        ],
        showingTooltipIndicators: touchedIndex == 0 ? [0] : [],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            toY: widget.totalExpenditure,
            color: Colors.red,
            width: 20,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 0,
              color: Colors.red.withOpacity(0.1),
            ),
          ),
        ],
        showingTooltipIndicators: touchedIndex == 1 ? [0] : [],
      ),
    ];
  }
}
