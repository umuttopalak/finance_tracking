import 'package:finance_tracking/widgets/show_message.dart';
import 'package:flutter/material.dart';

class AddContainer extends StatelessWidget {
  final List<String>? categories;
  final List<String>? financialItems;

  const AddContainer({
    super.key,
    this.categories,
    this.financialItems,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [addFinancialItemDialog(context), addCategoryDialog(context)],
    );
  }

  Container addCategoryDialog(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Category",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  showAddCategoryDialog(context);
                },
              ),
            ],
          ),
          const Divider(thickness: 1),
          if (categories != null && categories!.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: categories!.map((item) {
                return Row(
                  children: [
                    Text(item),
                  ],
                );
              }).toList(),
            ),
          if (categories == null || categories!.isEmpty)
            const Center(
              child: Text(
                'No categories available',
                style:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }

  Container addFinancialItemDialog(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Financial Item",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  showAddFinancialItemDialog(context);
                },
              ),
            ],
          ),
          const Divider(thickness: 1)
        ],
      ),
    );
  }
}
