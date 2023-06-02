//main page that shows chart expense list

import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget{
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses>{
  final List<Expense> _registeredExpenses =[
    Expense(
      title: 'Flutter course', 
      amount: 19.74, 
      date: DateTime.now(), 
      category: Category.work
    ),
    Expense(
      title: 'Movie RRR', 
      amount: 10, 
      date: DateTime.now(), 
      category: Category.leisure
    ),
    Expense(
      title: 'Movie Orange', 
      amount: 10, 
      date: DateTime.now(), 
      category: Category.leisure
    ),
  ];

  void _addExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);   
    });
  }

  void _removeExpense(Expense expense){
    final expenseIndex= _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
        ),
    );
  }

  void _openAddExpenseOverlay(){
    showModalBottomSheet(
      isScrollControlled: true,// for full screen view??
      useSafeArea: true,
      constraints: const BoxConstraints(minWidth : 0 , maxWidth: double.infinity),
      context: context, //this context is context of parent widget
      builder: (cxt) =>NewExpense(onAddExpense: _addExpense)//cxt=this is going to be passed by flutter automatically and its the context of showModalBottomSheet
    );
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    Widget _mainContent = const Center(
    child: 
     Text(
      'No expenses found. Start adding some !'
      ),
   );
    if(_registeredExpenses.isNotEmpty){
      _mainContent = ExpensesList(
              expenses: _registeredExpenses,
              onRemoveExpense: _removeExpense,
            );
    }
    return Scaffold(
      //backgroundColor: Colors.amber,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay, 
            icon: const Icon(Icons.add),
          )
        ]
      ),
      body: height>width ? Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(//using expanded resolves this
            child: _mainContent
          ),
        ]
      ):Row(
        children: [
          Expanded(
            child: Chart(expenses: _registeredExpenses),
          ),
          Expanded(//using expanded resolves this
            child: _mainContent
          ),
        ],
      )
    );
  }
}