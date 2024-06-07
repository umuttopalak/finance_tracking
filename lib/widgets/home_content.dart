import 'package:finance_tracking/services/income.dart';
import 'package:finance_tracking/widgets/home_container.dart';
import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  final List<String> items;

  const HomeContent({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeContainer(
            title: "Upcoming Payments",
            items: items,
          ),
          HomeContainer(
            title: "Income",
            items: items,
          ),
          HomeContainer(
            title: "Outcome",
            items: items,
          ),
          ElevatedButton(
            child: Text("Çalıştır"),
            onPressed: () => checkPayments(context),
          ),
        ],
      ),
    );
  }
}
