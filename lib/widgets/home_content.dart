import 'package:finance_tracking/widgets/home_container.dart';
import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  final List<String> incomeItems;
  final List<String> expenseItems;


  const HomeContent({
    super.key,
    required this.incomeItems,
    required this.expenseItems,

  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeContainer(
            title: "Upcoming Payments",
            items: [],
          ),
          HomeContainer(
            title: "Income",
            items: incomeItems,
          ),
          HomeContainer(
            title: "Outcome",
            items: expenseItems,
          )
        ],
      ),
    );
  }
}
