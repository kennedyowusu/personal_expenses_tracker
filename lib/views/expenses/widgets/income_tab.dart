import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expenses_tracker/common/dialogs/add_income_modal_sheet.dart';
import 'package:personal_expenses_tracker/common/dialogs/edit_income_dialog.dart';
import 'package:personal_expenses_tracker/common/no_data.dart';
import 'package:personal_expenses_tracker/constants/colors.dart';
import 'package:personal_expenses_tracker/helper/format_date.dart';
import 'package:personal_expenses_tracker/model/income_model.dart';
import 'package:personal_expenses_tracker/providers/income_provider.dart';

class IncomeTab extends ConsumerWidget {
  const IncomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final income = ref.watch(incomeProvider);

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
          showAddIncomeModalSheet(context);
        },
        child: const Icon(Icons.add_circle_outline_sharp, color: Colors.white),
      ),
      body: income.isEmpty
          ? const Center(
              child: NoDataWidget(message: 'No Income added yet.'),
            )
          : ListView.builder(
              itemCount: income.length,
              itemBuilder: (context, index) {
                final Income inc = income[index];
                return Dismissible(
                  key: Key(inc.id),
                  direction: DismissDirection.endToStart,
                  dismissThresholds: const {DismissDirection.endToStart: 0.5},
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    ref.read(incomeProvider.notifier).deleteIncome(inc);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${inc.title} removed')),
                    );
                  },
                  child: GestureDetector(
                    onTap: () {
                      showEditIncomeDialog(context, inc, ref);
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
                          inc.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          formatDate(inc.date),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        trailing: Text(
                          'GHS ${inc.amount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
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
