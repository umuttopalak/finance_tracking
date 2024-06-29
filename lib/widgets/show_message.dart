import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/category.dart';
import '../services/financial_item.dart';

void showMessage(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Payments'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void showWidget(BuildContext context, Widget widget) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Custom Widget'),
        content: widget,
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void showAddCategoryDialog(BuildContext context) {
  final TextEditingController nameController = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add Category'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Save'),
            onPressed: () {
              final name = nameController.text;
              if (name.isNotEmpty) {
                _addCategory(context, name: name);
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}

void showAddFinancialItemDialog(BuildContext context) {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String selectedCategoryId = '';
  String selectedType = '';
  List<Map<String, dynamic>> categories = [];
  List<String> types = ["income", "expense"];

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      dateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return FutureBuilder<List<Map<String, dynamic>>>(
        future: getCategoriesData(context),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text('Failed to load categories: ${snapshot.error}'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return AlertDialog(
              title: const Text('No Categories'),
              content: const Text('No categories available.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }

          // Assign fetched categories
          categories = snapshot.data!;

          return AlertDialog(
            title: const Text('Add Financial Item'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedType.isNotEmpty ? selectedType : null,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        selectedType = newValue;
                      }
                    },
                    decoration: const InputDecoration(labelText: 'Type'),
                    items: types.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  TextField(
                    controller: amountController,
                    decoration: const InputDecoration(labelText: 'Amount'),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                  ),
                  GestureDetector(
                    onTap: () => selectDate(context),
                    child: AbsorbPointer(
                      child: TextField(
                        controller: dateController,
                        decoration: const InputDecoration(labelText: 'Date'),
                      ),
                    ),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  DropdownButtonFormField<Map<String, dynamic>>(
                    value: selectedCategoryId.isNotEmpty
                        ? categories.firstWhere((category) =>
                            category['id'].toString() == selectedCategoryId)
                        : null,
                    onChanged: (Map<String, dynamic>? newValue) {
                      if (newValue != null) {
                        selectedCategoryId = newValue['id'].toString();
                      }
                    },
                    decoration: const InputDecoration(labelText: 'Category'),
                    items: categories.map((Map<String, dynamic> category) {
                      return DropdownMenuItem<Map<String, dynamic>>(
                        value: category,
                        child: Text(category['name']),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Save'),
                onPressed: () {
                  final name = nameController.text;
                  final amount = double.tryParse(amountController.text) ?? 0.0;
                  final date = dateController.text;
                  final description = descriptionController.text;

                  if (name.isNotEmpty &&
                      amount > 0 &&
                      date.isNotEmpty &&
                      selectedCategoryId.isNotEmpty &&
                      selectedType.isNotEmpty) {
                    addFinancialItem(
                      context,
                      type: selectedType,
                      name: name,
                      amount: amount,
                      date: date,
                      description: description,
                      categoryId: selectedCategoryId,
                    );
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        },
      );
    },
  );
}

Future<void> _addCategory(BuildContext context, {required String name}) async {
  await postCategory(context, name: name);
}
