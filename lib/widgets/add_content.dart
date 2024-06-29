import 'package:finance_tracking/widgets/add_container.dart';
import 'package:flutter/material.dart';

class AddContent extends StatelessWidget {
  final List<String> categories;

  const AddContent(
      {super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AddContainer(
            categories: categories,
          ),
        ],
      ),
    );
  }
}
