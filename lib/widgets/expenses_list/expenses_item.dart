import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expenseModel.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem(this.expense, {super.key});

  final ExpenseModel expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          children: [
            Text(expense.title),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text('\u{20B9}${expense.amount.toStringAsFixed(0)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(caregoryIcons[expense.category]),
                    const SizedBox(width: 8,),
                    Text(expense.formattedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
