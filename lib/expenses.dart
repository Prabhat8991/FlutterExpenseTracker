import 'package:expense_tracker/data/expense.dart';
import 'package:expense_tracker/expense_list.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _requiredExpenseList = [
    Expense(
        title: "Flutter course",
        amount: 120,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: "Netflix",
        amount: 1000,
        date: DateTime.now(),
        category: Category.leisure)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      const Text("Chart"),
      Expanded(child: ExpenseList(expenses: _requiredExpenseList))
    ]));
  }
}
