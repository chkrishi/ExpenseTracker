import 'package:expense_tracker/expenses.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onremoveexpense});
  final List<Expense> expenses;
  final void Function(Expense expense) onremoveexpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctxz, index) => Dismissible(
              key: ValueKey(expenses[index]),
              background: Container(
                color: Theme.of(context).colorScheme.error.withOpacity(0.70),
                margin: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onDismissed: (direction) {
                onremoveexpense(expenses[index]);
              }, //requires a funtion with dismissed direction as parameter to determine what to do when swiped left and when swiped right.
              child: ExpenseItem(
                expenses[index],
              ),
            )
//dismissible is a spl type function where we can dismiss/delete data by swiping them away.
//it requires a child to perform this action on and a unique key such that each value is identified and
//the wrong data isn't deleted. Valuekey is spl.fucntion that takes cares of values generation

        /*  itemBuilder: (ctxz, index) => ExpenseItem(expenses[index]) */
        //     or
        /* itemBuilder: (ctxz, index) => Text(expenses[index].title), */
        );
    //Listview is used to display a scrollable list. itemcount is used to give a parameter to the fns how many lists are to be passed
    //itembuilder takes a function with return value widget to display list values.
    //context takes in the value
    //index is indexing of the list values from 0-n
    //=> means returns Text widget
    // Text(expenses[index].title) where index acceses the particular expenses list value and tagets the title using .title
  }
}
