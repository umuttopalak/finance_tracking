import 'package:finance_tracking/widgets/app_scaffold.dart';
import 'package:finance_tracking/widgets/home_content.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../services/income.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<String> incomeItems = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _loadIncomeItems();
    configureFirebaseMessaging();
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      if (_tabController.index == 0) {
        _loadIncomeItems();
      }
    }
  }

  Future<void> _loadIncomeItems() async {
    final items = await checkPayments(context);
    setState(() {
      incomeItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: widget.title,
      tabs: const [
        Tab(icon: Icon(Icons.home), text: 'Home'),
        Tab(icon: Icon(Icons.add), text: 'Add Transaction'),
        // Tab(icon: Icon(Icons.abc), text: 'Deneme')
      ],
      tabViews: [
        HomeContent(items: incomeItems),
        HomeContent(items: []),
        // HomeContent(items: [])
      ],
      tabController: _tabController,
    );
  }
}
