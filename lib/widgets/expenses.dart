import 'package:expense_tracker/data/expense.dart';
import 'package:expense_tracker/widgets/expense_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
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

  void _openExpenseModalSheet() {
    showModalBottomSheet(context: context, builder: (ctx) {
      return const NewExpense();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Expense Tracker App"),
          actions: [
            IconButton(
              onPressed: _openExpenseModalSheet,
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: Column(children: [
      const Text("Chart"),
      Expanded(child: ExpenseList(expenses: _requiredExpenseList))
    ]));
  }
}
