import 'package:finance_tracking/services/category.dart';
import 'package:finance_tracking/widgets/app_scaffold.dart';
import 'package:finance_tracking/widgets/home_content.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../services/income.dart';
import '../widgets/add_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<String> incomeItems = [];
  List<String> expenseItems = [];
  List<String> categories = [];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _loadIncomeItems();
    _loadExpenseItems();
    _loadCategories();
    configureFirebaseMessaging();
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {
      if (_tabController.index == 0) {
        _loadIncomeItems();
        _loadExpenseItems();
      } else if (_tabController.index == 1) {
        _loadCategories();
      }
    });
  }

  Future<void> _loadIncomeItems() async {
    final items = await checkPayments(context, type: 'income');
    if (mounted) {
      setState(() {
        incomeItems = items;
      });
    }
  }

  Future<void> _loadExpenseItems() async {
    final items = await checkPayments(context, type: 'expense');
    if (mounted) {
      setState(() {
        expenseItems = items;
      });
    }
  }

  Future<void> _loadCategories() async {
    final items = await getCategories(context);
    if (mounted) {
      setState(() {
        categories = items;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: widget.title,
      tabs: const [
        Tab(icon: Icon(Icons.home), text: 'Financial Info'),
        Tab(icon: Icon(Icons.add), text: 'Add'),
      ],
      tabViews: [
        HomeContent(incomeItems: incomeItems, expenseItems: expenseItems),
        AddContent(
          categories: categories,
        )
      ],
      tabController: _tabController,
    );
  }
}
