import 'dart:io';

import 'package:expense_tracker/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NewExpenese extends StatefulWidget {
  const NewExpenese({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpenese> createState() => _NewExpeneseState();
}

class _NewExpeneseState extends State<NewExpenese> {
  final _titlevalue = TextEditingController();
  final _expensevalue = TextEditingController();
  Category1 _selectedvalue = Category1.leisure;
  /*TextEditingController() takes up the heavy load of taking user input,storing
  and deleting values. Alternative for below method.*/
  DateTime? selectedDate;
/*   void _datepicker() {
    final now = DateTime.now();
    showDatePicker(
        context: context,
        firstDate: DateTime(1900, 0, 0, 0, 0),
        currentDate: now,
        lastDate: DateTime(2200, 0, 0, 0, 0)).then((value) => null);
  } */
  void _datepicker() async {
    //async ans wait are spl keywords that say that a certain future value will be produced but isnt currently avialable.
    final now = DateTime.now();
    final valuegot = await showDatePicker(
        //returns a future datatype variable. It's a variable that currently has no value but will produce in the future.
        context: context,
        firstDate: DateTime(1900, 0, 0, 0, 0),
        currentDate: now,
        lastDate: DateTime(2200, 0, 0, 0, 0));
    setState(() {
      selectedDate = valuegot;
    });
  }

/*   var x='Selected Date',
  _textvaluetodisplay() {
    setState(() {
      x=
    });
  } */

  void _submitform() {
    final enteredamount = double.tryParse(_expensevalue
        .text); //try parse converets the string to double else it return null if the type conversion isn't possible.
    final amountisvalid = enteredamount == null ||
        enteredamount <=
            0; //amountisvalid will be true when enteredamount is null i.e; when tryparse isn't able to return a value.
    if (_titlevalue.text.trim().isEmpty ||
        amountisvalid ||
        selectedDate == null) {
      //error msg
      if (Platform.isIOS) {
        showCupertinoDialog(
          //CUPERTINO ELEMENTS are ios native elements.
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
            title: const Text('Invalid Input'),
            content: const Text('Enter All Values'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'),
              )
            ],
          ),
        );
      }
      if (Platform.isAndroid) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            //show dialog is a fucntion that has a context value and requires a builder fucntion
            //that takes context as input value and returns widget as a value.
            //Alert dialouge is spl. type to show alert messages.
            title: const Text('Invalid Input'),
            content: const Text('Enter All Values'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'),
              )
            ],
          ),
        );
      }
      return;
    }
    widget.onAddExpense(Expense(
        title: _titlevalue.text,
        amount: enteredamount,
        date: selectedDate!,
        category: _selectedvalue));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titlevalue.dispose();
    _expensevalue
        .dispose(); /*As after text input is done, the texteditingcontroller 
    would live on in the memory, so to dispose it after its use we use dispose.
    We have to dispose all texteditingcontrollers as it takes up all the memory 
    and causes the app to crash.*/
    super.dispose();
  }
/*   var _enteredvalue = '';

  void _saveTitle(String inputvalue) {
    _enteredvalue = inputvalue;
  } */

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            //onChanged: _saveTitle,
            controller: _titlevalue, //replacement for onchanged for controller.
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(label: Text('Title')),
          ),
          /*    Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    print(_titlevalue.text);
                  },
                  child: const Text('Save Expense'))
            ],
          ) */
          Row(
            children: [
              Expanded(
                //TextFeild wants as much space as possibile, to avoid padding issues
                child: TextField(
                  //we've encapsulated it with Expanded widget.
                  controller: _expensevalue,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      prefixText: '\$', label: Text('Value')),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                //To avoid padding issues in nestesd Row, we use Expanded
                children: [
                  Text(selectedDate == null
                      ? 'No Date Selected'
                      : x_formatter.format(selectedDate!)),
                  IconButton(
                      onPressed: _datepicker,
                      icon: const Icon(Icons.calendar_month))
                ],
              ))
            ],
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedvalue,
                  items: Category1.values
                      .map(
                        //mapping it to list type as Category is of Enumeration type.
                        (Category1) => DropdownMenuItem(
                          value:
                              Category1, //Value stores the user selected value i.e, All category values
                          child: Text(
                            Category1.name
                                .toUpperCase(), //Typecasting to uppercase string.
                          ),
                        ),
                      )
                      .toList(), //Tolist() type
                  onChanged: (value) {
                    if (value == Null) {
                      return;
                    }
                    setState(() {
                      _selectedvalue = value!;
                    });
                  }),
              ElevatedButton(onPressed: _submitform, child: const Text('Save')),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Exit'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
