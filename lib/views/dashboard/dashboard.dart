import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expenses_tracker/widgets/custom_app_bar.dart';
import 'package:personal_expenses_tracker/widgets/custom_button.dart';
import 'package:personal_expenses_tracker/widgets/dialogs/add_expenditure_modal_sheet.dart';
import 'package:personal_expenses_tracker/constants/colors.dart';
import 'package:personal_expenses_tracker/model/income_expense_model.dart';
import 'package:personal_expenses_tracker/providers/income_provider.dart';
import 'package:personal_expenses_tracker/views/dashboard/widgets/income_and_expenses_chart.dart';
import 'package:personal_expenses_tracker/views/dashboard/widgets/info_card.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final TextEditingController amountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    amountController.dispose();
    categoryController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalIncome = ref.watch(incomeProvider).incomes.fold(
          0.00,
          (previousValue, element) => previousValue + (element.amount ?? 0),
        );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: 'Dashboard',
        ),
        body: Padding(
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
                  const InfoCard(
                    icon: Icons.call_made_sharp,
                    iconColor: Colors.red,
                    text: 'Outflows',
                    value: 0.00,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    const Text(
                      'Add your expenses to keep track of your spending',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 16),
                    PrimaryButton(
                      backgroundColor: primaryColor,
                      text: 'Add Expenditure',
                      onPressed: () {
                        showAddExpenditureSheet(
                          context,
                          amountController,
                          categoryController,
                          nameController,
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              IncomeAndExpensesChart(incomeExpenseData: incomeExpenseData),
            ],
          ),
        ),
      ),
    );
  }
}
