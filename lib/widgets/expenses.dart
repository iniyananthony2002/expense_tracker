import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expenseModel.dart';

import 'new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => ExpensesState();
}

class ExpensesState extends State<Expenses> {
  final List<ExpenseModel> _registeredExpenses = [];

  void addExpenses(ExpenseModel expense) {
    setState(
      () {
        _registeredExpenses.add(expense);
        _registeredExpenses;
      },
    );
  }

  void removeExpenses(ExpenseModel expense) {
    final expenseInsed = _registeredExpenses.indexOf(expense);
    setState(
      () {
        _registeredExpenses.remove(expense);
        _registeredExpenses;
      },
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.purple[100],
        duration: const Duration(seconds: 3),
        content: Text(
          'Expense of ${expense.title} on ${formatter.format(expense.date)} Deleted!',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        action: SnackBarAction(
          backgroundColor: Colors.white,

          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseInsed, expense);
            });
          },
        ),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        addExpenses: addExpenses,
      ),
    );
  }

  @override
  Widget build(context) {
    Widget mainContent = const Center(
      child: Text('Add Expenses to Display!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = Expenseslist(
        expenses: _registeredExpenses,
        removeExpenses: removeExpenses,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          const Text('The Chart'),
          Expanded(
            child: mainContent,
          )
        ],
      ),
    );
  }
}
