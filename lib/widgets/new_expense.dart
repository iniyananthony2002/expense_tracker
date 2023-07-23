import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expenseModel.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<StatefulWidget> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  DateTime? _selectedDate;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final _datePicker = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(now.year - 10000, now.month, now.day),
        lastDate: now);
    setState(() {
      _selectedDate = _datePicker;
    });
  }

  @override
  void dispose() {
    _titlecontroller.dispose();
    _amountcontroller.dispose();
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
              counterText: '',
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountcontroller,
                  maxLength: 16,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\u{20B9}',
                    label: Text('Amount'),
                    counterText: '',
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null? 'Select Date' : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  print(_titlecontroller.text);
                  print(_amountcontroller.text);
                  print(_selectedDate);
                },
                child: const Text('Save changes'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
