import 'package:expense_tracker/expenses_list.dart';
import 'package:expense_tracker/models/chart.dart';
import 'package:expense_tracker/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final x_formatter = DateFormat.yMd();

final uuid = Uuid(); //Global Variable

enum Category1 { food, travel, leisure, work }

var x = ThemeMode.system;

const cIcons = {
  Category1.food: Icons.lunch_dining,
  Category1.leisure: Icons.movie,
  Category1.travel: Icons.flight_takeoff,
  Category1.work: Icons.work,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date; //builtin fns
  //final String category; the problem is that ,it will accept all types from [0-9][a-z]
  //strings but we need only specific ones like food,travel,work ..etc so we have created a enum to have only specific values
  final Category1 category;

  String get formattedDate {
    return x_formatter.format(date);
  }
}

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> registeredValues = [
    Expense(
        title: 'P1',
        amount: 20.00,
        date: DateTime.now(),
        category: Category1.food),
    Expense(
        title: 'P2',
        amount: 30.00,
        date: DateTime.timestamp(),
        category: Category1.travel)
  ];
  void _addoverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpenese(
        onAddExpense: _addexpense,
      ),
      /* {
          return const Text('Nikitha Verma');
        } */
    );
  }

  void _addexpense(Expense expense) {
    setState(() {
      registeredValues.add(expense);
    });
  }

  void _removeexpense(Expense expense) {
    final expenseindex = registeredValues.indexOf(expense);
    setState(() {
      registeredValues.remove(expense);
    });
    ScaffoldMessenger.of(context)
        .clearSnackBars(); //clearsnackbars clears any leftover snackbars on the screens
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Delted Expense'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              registeredValues.insert(expenseindex, expense);
            });
          },
        ),
      ),
    );
    /* When the ScaffoldMessenger has nested Scaffold descendants, 
    the ScaffoldMessenger will only present the notification to the 
    root Scaffold of the subtree of Scaffolds.

    SnackBar, which is a temporary notification typically shown near the 
    bottom of the app using the ScaffoldMessengerState.showSnackBar method.

    MaterialBanner, which is a temporary notification typically shown at the top 
    of the app using the ScaffoldMessengerState.showMaterialBanner method. */
  }

  @override
  Widget build(BuildContext context) {
    final width1 = MediaQuery.of(context)
        .size
        .width; //width1 stores the device's current width
    //final height1 = MediaQuery.of(context).size.height; //height1 stores the device's current height1
    Widget maincontent = const Center(
      child: Text('No Expenses'),
    );

    if (registeredValues.isNotEmpty) {
      maincontent = ExpensesList(
          expenses: registeredValues, onremoveexpense: _removeexpense);
    }
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Expense Tracker',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
          actions: [
/*             IconButton(
                onPressed: () {
                  setState(() {
                    x = ThemeMode.dark;
                  });
                },
                icon: const Icon(Icons.sunny)), */
            IconButton(
              onPressed: _addoverlay,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: width1 < 600
            ? //Terneary condition to either display the chart in row or coloumn
            Column(
                children: [
                  const Text(
                    'List of Expenses',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Chart(expenses: registeredValues),
                  Expanded(
                    child: maincontent,
                  ),
                ],
              )
            : Row(
                //Ternary condition
                children: [
                  const Text(
                    'List of Expenses',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(child: Chart(expenses: registeredValues)),
                  Expanded(
                    child: maincontent,
                  ),
                ],
              ));
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});
  ExpenseBucket.cons2(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList(); //: is to map the values form list to allexpenses.
  //where is universal list function to filter values. It takes a list item as argument for where fucntion and points it => Ture||False, it gets removed.
  //Here we are comparing expense.category to this.category such that the recieved category belongs to the correct category or not i.e, True || False
  //2nd constructor, ususally a class can have 1. This is the format to have more than 1 constructor.
  final Category1 category;
  final List<Expense> expenses;
  double get totalexpenses {
    double sum = 0;

    for (final i in expenses) {
      sum = sum + i.amount;
    }
    return sum;
  }
}
