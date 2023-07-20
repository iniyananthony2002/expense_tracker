import 'package:expense_tracker/models/expenseModel.dart';
import 'package:flutter/material.dart';
import 'expenses_item.dart';

class Expenseslist extends StatelessWidget {
  const Expenseslist({super.key, required this.expenses});

  final List<ExpenseModel> expenses;

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => ExpensesItem(expenses[index]),
    );
  }
}