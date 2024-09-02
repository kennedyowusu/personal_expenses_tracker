import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:personal_expenses_tracker/constants/colors.dart';
import 'package:personal_expenses_tracker/model/income_expense_model.dart';

class IncomeAndExpensesChart extends StatefulWidget {
  const IncomeAndExpensesChart({
    super.key,
    required this.incomeExpenseData,
  });

  final List<IncomeExpenseData> incomeExpenseData;

  @override
  State<IncomeAndExpensesChart> createState() => _IncomeAndExpensesChartState();
}

class _IncomeAndExpensesChartState extends State<IncomeAndExpensesChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 300,
      child: BarChart(
        swapAnimationCurve: Curves.easeInOut,
        swapAnimationDuration: const Duration(milliseconds: 500),
        BarChartData(
          backgroundColor: Colors.transparent,
          alignment: BarChartAlignment.spaceAround,
          minY: 1000,
          maxY: 5000,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) => const FlLine(
              color: Colors.white,
              strokeWidth: 1,
            ),
            horizontalInterval: 10,
            drawHorizontalLine: true,
          ),
          barGroups: widget.incomeExpenseData.map((data) {
            return BarChartGroupData(
              x: widget.incomeExpenseData.indexOf(data),
              barRods: [
                BarChartRodData(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                  borderSide: const BorderSide(color: Colors.transparent),
                  toY: data.income,
                  color: secondaryColor,
                  width: 15,
                ),
                BarChartRodData(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                  borderSide: const BorderSide(color: Colors.transparent),
                  toY: data.expenses,
                  color: Colors.red,
                  width: 15,
                ),
              ],
              showingTooltipIndicators: [0, 1],
            );
          }).toList(),
          borderData: FlBorderData(
            show: false,
            border: Border.all(color: Colors.white, width: 0),
          ),
          titlesData: FlTitlesData(
            show: true,
            topTitles: const AxisTitles(),
            rightTitles: const AxisTitles(),
            leftTitles: AxisTitles(
              axisNameSize: 18,
              axisNameWidget: const Text(
                'Income',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 42,
                interval: 1000,
                getTitlesWidget: (value, meta) {
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(
                      'GH₵ ${value.toInt().toString()}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              axisNameWidget: const Text(
                'Expenses',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                getTitlesWidget: (value, meta) {
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(
                      widget.incomeExpenseData[value.toInt()].income
                          .toInt()
                          .toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          barTouchData: BarTouchData(
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
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => textColor,
              tooltipBorder: const BorderSide(
                color: Color(0xFFABACBA),
                width: 1,
              ),
              tooltipRoundedRadius: 8,
              tooltipMargin: 8,
              tooltipPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              tooltipHorizontalOffset: touchedIndex < 2 ? 8 : -8,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                if (groupIndex != touchedIndex) {
                  return null;
                }
                return BarTooltipItem(
                  rodIndex == 0
                      ? 'Inc: GH₵ ${rod.toY.round().toString()}'
                      : 'Exp: GH₵ ${rod.toY.round().toString()}',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text:
                          ' ${widget.incomeExpenseData[group.x.toInt()].month}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
