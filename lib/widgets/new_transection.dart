import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class NewTransection extends StatefulWidget {
  final Function addTx;

  NewTransection(this.addTx);

  @override
  State<NewTransection> createState() => _NewTransectionState();
}

class _NewTransectionState extends State<NewTransection> {
  final titleContainer = TextEditingController();

  final amountContainer = TextEditingController();

  void _submitData() {
    final enteredTitle = titleContainer.text;
    final enteredAmount = double.parse(amountContainer.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      return;
    }

    widget.addTx(
        //widget. is used to call the constructor and make a different class out of it, like widget.addtx(), widget give access to the class itself!
        enteredTitle,
        enteredAmount,
        selectedDate);
    Navigator.of(context)
        .pop(); //the add new transection screen on the homepage automatically closes as soon as we hit tick on the keyboard after entering the amount
    // context give access to the context of your widget!
  }

  DateTime selectedDate;
  void datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        selectedDate = pickedDate;
      });
      print('...');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 6,
        child: Container(
          padding: EdgeInsets.only(
              top: 20,
              right: 5,
              left: 15,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                keyboardType: TextInputType.text,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleContainer,
                onSubmitted: (_) => _submitData(),
                // onChanged: (value) {
                //   titleInput = value;
                // },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountContainer,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                // onChanged: ((value) {
                //   amountInput = value;
                // }),
              ),
              Container(
                height: 75,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        selectedDate == null
                            ? 'No date Chosen!'
                            : 'Date: ${DateFormat.yMMMMd("en_US").format(selectedDate)}',
                      ),
                    ),
                    ElevatedButton(
                        // hoverColor: Colors.grey,
                        // elevation: 3,
                        // color: Color.fromARGB(255, 255, 227, 240),
                        onPressed: () {
                          datePicker();
                        },
                        child: Text(
                          'Choose Date',
                          style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).primaryColor),
                        ))
                  ],
                ),
              ),
              ElevatedButton(
                child: Text(
                  'Add Transection',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _submitData;
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
