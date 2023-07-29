import 'package:expense_tracker/models/expenseModel.dart';
import 'package:flutter/material.dart';
import 'expenses_item.dart';

class Expenseslist extends StatelessWidget {
  const Expenseslist(
      {super.key, required this.expenses, required this.removeExpenses});

  final List<ExpenseModel> expenses;
  final void Function(ExpenseModel expense) removeExpenses;

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        onDismissed: (direction) {
          removeExpenses(expenses[index]);
        },
        key: ValueKey(expenses[index]),
        child: ExpensesItem(expenses[index]),
      ),
    );
  }
}
