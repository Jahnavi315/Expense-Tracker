//this is to display each expense
//uses card widget to display each expense

import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget{
  const ExpenseItem({super.key,required this.expense});
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    //card has a default margin
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16 ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text('\$${expense.amount.toStringAsFixed(2)}'),//after decimal=> 2 digits are only displayed
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 10),
                    Text(expense.formattedDate)//its a getter so no need to call as function
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}