import 'package:expense_tracker/expenses.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(expense.category.toString()),
                const SizedBox(width: 10),
                Icon(cIcons[expense.category]),
                const SizedBox(width: 60),
                Row(
                  children: [
                    //const Icon(Icons.date_range),
                    //Text(expense.date.toString()),
                    Text(expense.formattedDate),
                    const SizedBox(width: 40),
                    Text('\$${expense.amount.toString()}'),
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
