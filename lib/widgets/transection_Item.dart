// ignore_for_file: camel_case_types

import 'dart:math';

import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import '../models/transection.dart';

// ignore: camel_case_types
class transactionItem extends StatefulWidget {
  const transactionItem({
    Key key,
    @required Transection userTransection,
    @required deletetx,
  })  : _userTransection = userTransection,
        _deletetx = deletetx,
        super(key: key);

  final Transection _userTransection;
  final Function _deletetx;

  @override
  State<transactionItem> createState() => _transactionItemState();
}

class _transactionItemState extends State<transactionItem> {
  Color _bgColor;
  @override
  void initState() {
    super.initState();
    const availableColors = [
      Colors.white,
      Colors.purple,
      Colors.black,
      Colors.amber
    ];

    _bgColor = availableColors[Random().nextInt(4)];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      elevation: 5,
      child: ListTile(
        //listTile is an alternative for arranging different widgets in a sequence, leading, title in row, subtitle in column with the title
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          radius: 45,
          child: CircleAvatar(
            backgroundColor: _bgColor,
            radius: 40,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child:
                  FittedBox(child: Text('\$${widget._userTransection.amount}')),
            ),
          ),
        ),
        title: Text(
          widget._userTransection.title,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        subtitle: Text(
          DateFormat.yMd().add_jm().format(widget._userTransection.date),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? TextButton.icon(
                onPressed: () => widget._deletetx(widget._userTransection.id),
                icon: Icon(Icons.delete),
                label: Text('Delete'))
            : IconButton(
                color: Theme.of(context).errorColor,
                onPressed: () => widget._deletetx(widget._userTransection.id),
                icon: Icon(Icons.delete)),
      ),
    );
  }
}
