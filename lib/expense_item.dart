import 'package:expense_tracker/data/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {

  const ExpenseItem({required this.expense, super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Text(expense.title),
            const SizedBox(height: 5),
             Row(
              children:[
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                const Icon(Icons.category),
                const SizedBox(width: 30),
                Text(expense.date.toString())
              ],

            )
          ],
        )
       )
    );
  }
}