// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:personal_expenses_tracker/constants/colors.dart';
// import 'package:personal_expenses_tracker/helper/group_expenditure_by_category.dart';
// import 'package:personal_expenses_tracker/model/expenditure.dart';
// import 'package:personal_expenses_tracker/providers/expenditures_provider.dart';

// class ExpensesTab extends ConsumerWidget {
//   const ExpensesTab({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final expenditures = ref.watch(expendituresProvider);

//     final Map<String, List<Expenditure>> categories =
//         groupExpendituresByCategory(expenditures);

//     return ListView.builder(
//       padding: const EdgeInsets.all(8.0),
//       itemCount: categories.length,
//       itemBuilder: (context, index) {
//         final category = categories.keys.elementAt(index);
//         final categoryExpenditures = categories[category]!;

//         return Container(
//           margin: const EdgeInsets.only(bottom: 8.0),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8.0),
//             border: Border.all(color: Colors.grey.shade200),
//           ),
//           child: ExpansionTile(
//             backgroundColor: Colors.white,
//             clipBehavior: Clip.antiAlias,
//             collapsedBackgroundColor: Colors.white,
//             collapsedShape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             expandedAlignment: Alignment.centerLeft,
//             expandedCrossAxisAlignment: CrossAxisAlignment.start,
//             expansionAnimationStyle: AnimationStyle.noAnimation,
//             title: Text(
//               category,
//               style: const TextStyle(
//                   fontWeight: FontWeight.w400,
//                   fontSize: 16,
//                   color: primaryColor),
//             ),
//             children: categoryExpenditures.map((expenditure) {
//               return ListTile(
//                 leading: CircleAvatar(
//                   backgroundColor: expenditure.color,
//                   child: Text(
//                     expenditure.name[0].toUpperCase(),
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 title: Text(expenditure.name,
//                     style: const TextStyle(fontSize: 16, color: textColor)),
//                 trailing: Text('GHS ${expenditure.amount.toStringAsFixed(2)}'),
//               );
//             }).toList(),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';

class ExpensesTab extends StatelessWidget {
  const ExpensesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
