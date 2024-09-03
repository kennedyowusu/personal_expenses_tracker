import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expenses_tracker/providers/expenditure_provider.dart';
import 'package:personal_expenses_tracker/repositories/models/income_list_res.dart';
import 'package:personal_expenses_tracker/widgets/custom_app_bar.dart';
import 'package:personal_expenses_tracker/widgets/custom_button.dart';
import 'package:personal_expenses_tracker/widgets/dialogs/add_expenditure_modal_sheet.dart';
import 'package:personal_expenses_tracker/constants/colors.dart';
import 'package:personal_expenses_tracker/providers/income_provider.dart';
import 'package:personal_expenses_tracker/views/dashboard/widgets/income_and_expenses_chart.dart';
import 'package:personal_expenses_tracker/views/dashboard/widgets/info_card.dart';
import 'package:personal_expenses_tracker/widgets/dialogs/add_income_modal_sheet.dart';
import 'package:personal_expenses_tracker/widgets/no_data.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> getIncomes() async {
    final (_, err) = await ref.read(incomeProvider).getIncomes();
    if (err != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err.message),
        ),
      );
    }
  }

  Future<void> deleteIncome({
    required Income income,
  }) async {
    final (res, err) = await ref.read(incomeProvider).deleteIncome(
          incomeId: income.id ?? "",
        );

    Navigator.pop(context);

    if (err != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err.message),
        ),
      );
    }

    if (res?.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${income.nameOfRevenue} removed'),
        ),
      );

      getIncomes();
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalIncome = ref.watch(incomeProvider).incomes.fold(
          0.00,
          (previousValue, element) => previousValue + (element.amount ?? 0),
        );

    final totalExpenses = ref.watch(expendituresProvider).expenditures.fold(
          0.00,
          (previousValue, element) =>
              previousValue + (element.estimatedAmount ?? 0),
        );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: 'Dashboard',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InfoCard(
                      icon: Icons.south_east_sharp,
                      iconColor: secondaryColor,
                      text: 'Inflows',
                      value: totalIncome,
                    ),
                    InfoCard(
                      icon: Icons.call_made_sharp,
                      iconColor: Colors.red,
                      text: 'Outflows',
                      value: totalExpenses,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Column(
                  children: [
                    PrimaryButton(
                      backgroundColor: primaryColor,
                      text: 'Add Expenditure',
                      onPressed: () {
                        showAddExpenditureSheet(
                          context: context,
                          ref: ref,
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    PrimaryButton(
                      backgroundColor: Colors.white,
                      labelColor: primaryColor,
                      text: 'Add Income',
                      isOutlined: true,
                      onPressed: () {
                        showAddIncomeModalSheet(
                          context: context,
                          ref: ref,
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
                const SizedBox(height: 16),
                IncomeAndExpensesChart(
                  totalIncome: totalIncome,
                  totalExpenditure: totalExpenses,
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Incomes',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                ref.watch(incomeProvider).incomes.isEmpty
                    ? const Center(
                        child: NoDataWidget(
                          title: 'No Income Added Yet',
                          message:
                              'Click the add button below to add an income',
                        ),
                      )
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: ref.watch(incomeProvider).incomes.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final Income income =
                              ref.watch(incomeProvider).incomes[index];
                          return Dismissible(
                            key: Key(income.id ?? ""),
                            direction: DismissDirection.endToStart,
                            dismissThresholds: const {
                              DismissDirection.endToStart: 0.5,
                            },
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child:
                                  const Icon(Icons.delete, color: Colors.white),
                            ),
                            onDismissed: (direction) async {
                              await deleteIncome(
                                income: income,
                              );
                            },
                            child: Card(
                              elevation: 1,
                              margin: const EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              color: Colors.white,
                              child: ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                leading: const CircleAvatar(
                                  backgroundColor: primaryColor,
                                  child: Icon(
                                    Icons.attach_money,
                                    color: Colors.white,
                                  ),
                                ),
                                title: Text(
                                  income.nameOfRevenue ?? "-",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: Text(
                                  'GHS ${income.amount?.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
