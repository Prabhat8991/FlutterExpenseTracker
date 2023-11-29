import 'package:flutter/material.dart';

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


  void _showDatePicker(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime firstDate = DateTime(now.year-1);
    DateTime lastDate = now;

    showDatePicker(context: context, initialDate: now, firstDate: firstDate, lastDate: lastDate);
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
                const Text("Select Date"),
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
