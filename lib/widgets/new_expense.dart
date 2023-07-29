import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expenseModel.dart';
import 'package:expense_tracker/widgets/expenses.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.addExpenses});

  final void Function(ExpenseModel expense) addExpenses;

  @override
  State<StatefulWidget> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final datePicker = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(now.year - 10000, now.month, now.day),
        lastDate: now);
    setState(
      () {
        _selectedDate = datePicker;
      },
    );
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountcontroller.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titlecontroller.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      // ERROR MESSAGE
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content:
              const Text('Make sure that all the fields are entered correctly'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    } 

    widget.addExpenses(
      ExpenseModel(title: _titlecontroller.text,
      amount: enteredAmount,
      date: _selectedDate!,
      category: _selectedCategory,)
    );
    Navigator.pop(context);
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
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
                    Text(_selectedDate == null
                        ? 'Select Date'
                        : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase()),
                        ),
                      )
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
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text('Save changes'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
