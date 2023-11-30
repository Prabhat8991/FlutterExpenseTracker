import 'package:flutter/material.dart';
import 'package:expense_tracker/data/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({required this.onNewExpense, super.key});

  final void Function(Expense expense) onNewExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleTextController = TextEditingController();
  final _amountTextController = TextEditingController();
  DateTime? _selectedDateTime;
  var _selectedCategory = Category.leisure;

  void _validateSubmitData() {
    var amountEntered = double.tryParse(_amountTextController.text.trim());
    var isAmountInValid = amountEntered == null;

    if (_titleTextController.text
        .trim()
        .isEmpty || isAmountInValid) {
      showDialog(context: context, builder: (context) =>
          AlertDialog(
            title: const Text("Invalid Values"),
            content: const Text("Please enter valid amount and title"),
            actions: [
              TextButton(onPressed: () {
                Navigator.pop(context);
              }, child: const Text("Ok"))
            ],

          ));
      return;
    }

    widget.onNewExpense(
        Expense(title: _titleTextController.text,
            amount: amountEntered,
            date: _selectedDateTime!,
            category: _selectedCategory)
    );
  }

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
          const SizedBox(height: 20,),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map((category) =>
                      DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase())))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    _validateSubmitData();
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
