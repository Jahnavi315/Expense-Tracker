//this is used to display all the expenses
//ListView.builder is used to display all expenses which takes input as a function that returns our widget

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

//this widget to keep build method clean in expenses
class ExpensesList extends StatelessWidget{
  const ExpensesList({
    required this.expenses,
    required this.onRemoveExpense,
    super.key
  });
  final List<Expense> expenses;
  final void Function(Expense) onRemoveExpense;
  @override
  Widget build(BuildContext context) {
    //print(Theme.of(context).cardTheme.margin!.horizontal);
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (cxt,index)=>Dismissible(
        background: Container( 
          color: Theme.of(context).colorScheme.error,
          //margin: Theme.of(context).cardTheme.margin,
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal/2,
            // ==>horizontal returns total offset in horizontal direction so divide by 2
            vertical: Theme.of(context).cardTheme.margin!.vertical/2
          )
        ),
        key: ValueKey(expenses[index]),//Value key creates a unique key with the input parameter for each widget?
        onDismissed: (direction){
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseItem(expense: expenses[index])
      )
      );
  }
}