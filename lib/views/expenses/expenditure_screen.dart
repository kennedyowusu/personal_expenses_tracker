import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expenses_tracker/constants/colors.dart';
import 'package:personal_expenses_tracker/helper/group_expenditure_by_category.dart';
import 'package:personal_expenses_tracker/providers/expenditure_provider.dart';
import 'package:personal_expenses_tracker/repositories/models/expenditure_list_res.dart';
import 'package:personal_expenses_tracker/widgets/dialogs/add_expenditure_modal_sheet.dart';
import 'package:personal_expenses_tracker/widgets/no_data.dart';

class ExpenditureScreen extends ConsumerStatefulWidget {
  const ExpenditureScreen({super.key});

  @override
  ConsumerState<ExpenditureScreen> createState() => _ExpenditureScreenState();
}

class _ExpenditureScreenState extends ConsumerState<ExpenditureScreen> {
  Future<void> getExpenditures() async {
    final (_, err) = await ref.read(expendituresProvider).getExpenditures();
    if (err != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err.message),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getExpenditures();
    });
  }

  // Function to generate a random color
  Color _generateRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    final expenditures = ref.watch(expendituresProvider).expenditures;

    final Map<String, List<Expenditure>> expensesByCategory =
        groupExpendituresByCategory(expenditures);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: const Text(
            'Expenditures',
            style: TextStyle(color: textColor),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none,
                color: textColor,
              ),
            ),
          ],
        ),
        body: expenditures.isEmpty
            ? const Center(
                child: NoDataWidget(
                  title: 'No Expense Yet',
                  message: 'Click the add button to add an expense',
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: expensesByCategory.length,
                  itemBuilder: (context, index) {
                    final category = expensesByCategory.keys.elementAt(index);
                    final categoryExpenditures = expensesByCategory[category]!;

                    return Container(
                      margin: EdgeInsets.only(bottom: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: ExpansionTile(
                        backgroundColor: Colors.white,
                        clipBehavior: Clip.antiAlias,
                        collapsedBackgroundColor: Colors.white,
                        collapsedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        expandedAlignment: Alignment.centerLeft,
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        expansionAnimationStyle: AnimationStyle.noAnimation,
                        title: Text(
                          category.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: primaryColor,
                          ),
                        ),
                        children: categoryExpenditures.map((expenditure) {
                          Color randomColor = _generateRandomColor();
                          return ListTile(
                            tileColor: randomColor.withOpacity(0.1),
                            leading: CircleAvatar(
                              radius: 18,
                              backgroundColor: randomColor,
                              child: Text(
                                (expenditure.nameOfItem ?? "-")[0]
                                    .toUpperCase(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(
                              expenditure.nameOfItem ?? "-",
                              style: const TextStyle(
                                fontSize: 14,
                                color: textColor,
                              ),
                            ),
                            subtitle: Text(
                              'GHS ${expenditure.estimatedAmount?.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: textColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          onPressed: () {
            showAddExpenditureSheet(
              context: context,
              ref: ref,
            );
          },
          child: const Icon(
            Icons.add,
            size: 36,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
