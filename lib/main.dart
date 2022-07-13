import 'package:expensemanager/ExpenseManagerPage.dart';
import 'package:expensemanager/ExpenseTab.dart';
import 'package:expensemanager/HomePage.dart';
import 'package:expensemanager/TabExample.dart';
import 'package:expensemanager/Transactions.dart';
import 'package:flutter/material.dart';

import 'CreatePin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Transactions(),
    );
  }
}

