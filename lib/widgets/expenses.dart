import 'package:expense_tracker/data/expense.dart';
import 'package:expense_tracker/widgets/expense_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/chart/chart_bar.dart';

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
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpense(
            onNewExpense: _addExpense,
          );
        });
  }

  void _addExpense(Expense newExpense) {
    setState(() {
      _requiredExpenseList.add(newExpense);
    });
  }

  void _removeExpense(Expense expense) {
    int index = _requiredExpenseList.indexOf(expense);
    setState(() {
      _requiredExpenseList.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Do you want to add it back"),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          setState(() {
            _requiredExpenseList.insert(index, expense);
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text("No expenses added yet"),
    );
    if (_requiredExpenseList.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: _requiredExpenseList,
        onRemoveExpense: _removeExpense,
      );
    }
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
        body: width < 800
            ? Column(children: [
                Chart(
                  expenses: _requiredExpenseList,
                ),
                Expanded(child: mainContent)
              ])
            : Row(children: [
                Expanded(
                    child: Chart(
                  expenses: _requiredExpenseList,
                )),
                Expanded(child: mainContent)
              ]));
  }
}
