import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget{
  const NewExpense({required this.onAddExpense, super.key});
  final void Function(Expense) onAddExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense>{
  /*var _enteredTitle='';
  void _saveTitleInput(String input){
    _enteredTitle=input;
  }*/
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _datePicker() async{
    final now = DateTime.now();
    final dateChoosen =await showDatePicker(
      context: context, 
      initialDate: now, 
      firstDate: DateTime(now.year-1,now.month,now.day), 
      lastDate: now
    );
    //using then ?
    setState(() {
      _selectedDate=dateChoosen;
    });
  }

  void _selectCategory(Category? selectedValue){
    if(selectedValue==null)
    {return;}
    setState(() {
      _selectedCategory = selectedValue;
    });
  }

  void _showDialog(){
    if(Platform.isIOS){
      showCupertinoDialog(
        context: context, 
        builder: (ctx)=> CupertinoAlertDialog(
          title: const Text('Invalid input'),
          content: const Text('Please make sure a valid title, amount, date and category was entered!'),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(ctx);
              }, 
              child: const Text('Okay')
            ),
          ],
        ),
      );
    }else{
      showDialog(
        context: context, 
        builder: (ctx)=> AlertDialog(
          title: const Text('Invalid input'),
          content: const Text('Please make sure a valid title, amount, date and category was entered!'),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(ctx);
              }, 
              child: const Text('Okay')
            ),
          ],
        ),
        //ctx will be provided by flutter automatically when this builder block gets executed
      );
    }
    
  }
  void _submitExpenseData(){
    final amount = double.tryParse(_amountController.text);//returns a double or null
    final amountIsInvalid = amount==null || amount<=0;
    //trim() trims off extra white spaces
    if(_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate == null){
      _showDialog();
      return;
    }
    widget.onAddExpense(
      Expense(
        title: _titleController.text, 
        amount: amount, 
        date: _selectedDate!, 
        category: _selectedCategory
      )
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyBoardSpace = MediaQuery.of(context).viewInsets.bottom;//where system UI obscurts app UI, mostly keyboard
    return  LayoutBuilder(builder: (cxt,constraints){
      final width = constraints.maxWidth;//width of parent widget
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
              padding: EdgeInsets.fromLTRB(16,16,16,keyBoardSpace + 16),
              child: Column(
                children: [
                  if(width>600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          //onChanged: _saveTitleInput,
                          maxLength: 50,
                          //showCursor: true ?,
                          //keyboardType: TextInputType.text, //=>default
                          decoration: const InputDecoration(
                            label: Text('Title')
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType : TextInputType.number,
                          decoration: const InputDecoration(
                            prefix: Text('\$'),
                            label:Text('Amount'),
                          ),
                        ),
                      ),
                    ]
                  )
                  else
                  TextField(
                    controller: _titleController,
                    //onChanged: _saveTitleInput,
                    maxLength: 50,
                    //showCursor: true ?,
                    //keyboardType: TextInputType.text, //=>default
                    decoration: const InputDecoration(
                      label: Text('Title')
                    ),
                  ),
                  if(width>600)
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,//default that is shown
                        items: Category.values.map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase())
                          )
                        ).toList(), 
                        onChanged: (value){
                          _selectCategory(value);
                        }
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,//default anyways
                          children: [
                            Text((_selectedDate == null)?'No date selected':formatter.format(_selectedDate!)),
                            //! makes sure that its never null
                            IconButton(
                              onPressed: _datePicker, 
                              icon: const Icon(Icons.calendar_month),
                            )
                          ],
                        ),
                      )
                    ],)
                  else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType : TextInputType.number,
                          decoration: const InputDecoration(
                            prefix: Text('\$'),
                            label:Text('Amount'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,//default anyways
                          children: [
                            Text((_selectedDate == null)?'No date selected':formatter.format(_selectedDate!)),
                            //! makes sure that its never null
                            IconButton(
                              onPressed: _datePicker, 
                              icon: const Icon(Icons.calendar_month),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  if(width>600)
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);//to exit from the modal sheet when cancel is clicked
                        }, 
                        child: const Text('Cancel')
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseData, 
                        child: const Text('Save Expense')
                      )
                    ],
                  )
                  else
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,//default that is shown
                        items: Category.values.map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase())
                          )
                        ).toList(), 
                        onChanged: (value){
                          _selectCategory(value);
                        }
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);//to exit from the modal sheet when cancel is clicked
                        }, 
                        child: const Text('Cancel')
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseData, 
                        child: const Text('Save Expense')
                      )
                    ],
                  )
                ],
              ),
        ),
      ),
    );
    });
    
  }
}