import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  NewExpense({super.key});

  @override
  State<StatefulWidget> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titlecontroller = TextEditingController();

  @override
  void dispose() {
    _titlecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titlecontroller,
            maxLength: 100,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {print (_titlecontroller.text);},
                child: const Text('Save changes'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
