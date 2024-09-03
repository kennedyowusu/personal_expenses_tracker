import 'package:flutter/material.dart';

void showCategorySelectionSheet(
  BuildContext context,
  TextEditingController categoryController,
) {
  final List<String> categories = [
    'Food',
    'Transport',
    'Shopping',
    'Health',
    'Others',
  ];

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    barrierColor: Colors.black.withOpacity(0.5),
    enableDrag: true,
    isDismissible: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        height: MediaQuery.of(context).size.height * 0.60,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // add close icon button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            const Text(
              'Choose category',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Select a category below for your new\ntransaction',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: categories.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: Colors.grey.shade200,
                ),
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(categories[index]),
                    trailing: const Icon(
                      Icons.add,
                      size: 20,
                    ),
                    onTap: () {
                      categoryController.text = categories[index];
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
            // TODO: Add bonus functionality
            // PrimaryButton(
            //   backgroundColor: Colors.white,
            //   labelColor: secondaryColor,
            //   text: 'Add Category',
            //   onPressed: () {
            //     // Add your logic for adding a new category
            //   },
            // ),
            const SizedBox(height: 32),
          ],
        ),
      );
    },
  );
}
