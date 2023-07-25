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

  @override
  void dispose() {
    _titleTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleTextController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text("Title")),
          ),
          Row(children: [
            ElevatedButton(onPressed: () {
              print(_titleTextController.text);
            }, child: const Text("Save"))
          ],)
        ],
      ),
    );
  }
}
