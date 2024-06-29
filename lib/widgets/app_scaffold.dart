import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final List<Tab> tabs;
  final List<Widget> tabViews;
  final TabController? tabController;

  const AppScaffold({
    super.key,
    required this.title,
    required this.tabs,
    required this.tabViews,
    this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          bottom: TabBar(
            controller: tabController,
            tabs: tabs,
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: tabViews,
        ),
      ),
    );
  }
}
