import 'package:flutter/material.dart';

class ExpenseTab extends StatefulWidget {
  @override
  State<ExpenseTab> createState() => _ExpenseTabState();
}

class _ExpenseTabState extends State<ExpenseTab>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  var position = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
    _tabController.addListener(getTabIndex);
  }

  void getTabIndex() {
    var index = _tabController.index;
    setState(() {
      position = index;
    });
    // print("Current Index : "+index.toString());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: (position == 0)
              ? Colors.purple
              : (position == 1)
                  ? Colors.pink[600]
                  : Colors.green[900],
          title: Text(
            "ExpenseManager",
          ),
          centerTitle: true,
          bottom: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // Creates border
                color: Colors.indigo), //Change background color from here
            tabs: [
              Tab(
                child: Text("Transaction"),
              ),
              Tab(
                child: Text("Balance"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
