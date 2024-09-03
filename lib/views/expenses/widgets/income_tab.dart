import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expenses_tracker/repositories/models/income_list_res.dart';
import 'package:personal_expenses_tracker/widgets/dialogs/add_income_modal_sheet.dart';
import 'package:personal_expenses_tracker/widgets/no_data.dart';
import 'package:personal_expenses_tracker/constants/colors.dart';
import 'package:personal_expenses_tracker/providers/income_provider.dart';

class IncomeTab extends ConsumerStatefulWidget {
  const IncomeTab({super.key});

  @override
  ConsumerState<IncomeTab> createState() => _IncomeTabState();
}

class _IncomeTabState extends ConsumerState<IncomeTab> {
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
    final incomes = ref.watch(incomeProvider).incomes;

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
        onPressed: () {
          showAddIncomeModalSheet(
            context: context,
            ref: ref,
          );
        },
        child: const Icon(Icons.add_circle_outline_sharp, color: Colors.white),
      ),
      body: incomes.isEmpty
          ? const Center(
              child: NoDataWidget(
                title: 'No Income Added Yet',
                message: 'Click the add button below to add an income',
              ),
            )
          : ListView.builder(
              itemCount: incomes.length,
              itemBuilder: (context, index) {
                final Income income = incomes[index];
                return Dismissible(
                  key: Key(income.id ?? ""),
                  direction: DismissDirection.endToStart,
                  dismissThresholds: const {DismissDirection.endToStart: 0.5},
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
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
                        child: Icon(Icons.attach_money, color: Colors.white),
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
    );
  }
}
