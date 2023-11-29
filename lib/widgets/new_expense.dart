import 'package:flutter/material.dart';
import 'package:expense_tracker/data/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleTextController = TextEditingController();
  final _amountTextController = TextEditingController();
  DateTime? _selectedDateTime;

  void _showDatePicker(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime firstDate = DateTime(now.year - 1);
    DateTime lastDate = now;
    var selectedDateTime = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);

    setState(() {
      _selectedDateTime = selectedDateTime;
    });
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _amountTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleTextController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text("Title")),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(children: [
            Expanded(
                child: TextField(
              keyboardType: TextInputType.number,
              controller: _amountTextController,
              decoration: const InputDecoration(
                  prefixText: '\$', label: Text("Amount")),
            )),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text((_selectedDateTime == null)
                    ? "No date selected"
                    : formatter.format(_selectedDateTime!)),
                IconButton(
                  onPressed: () {
                    _showDatePicker(context);
                  },
                  icon: const Icon(Icons.calendar_month),
                )
              ],
            ))
          ]),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    print(_titleTextController.text);
                    print(_amountTextController.text);
                  },
                  child: const Text("Save")),
              const SizedBox(width: 20),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"))
            ],
          )
        ],
      ),
    );
  }
}
