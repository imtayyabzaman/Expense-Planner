import 'dart:io';
import 'package:flutter/services.dart';

import 'widgets/new_transection.dart';

import 'package:flutter/material.dart';

import '../models/transection.dart';
import 'widgets/transection_list.dart';
import 'widgets/charts.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([
  //  DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  runApp(MaterialApp(home: MyApp()));
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        fontFamily: 'ARIALBD',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText2: TextStyle(
              fontFamily: 'ANTQUAB',
              fontSize: 18,
            ),
            button: TextStyle(color: Colors.white)),
        appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
                fontFamily: 'ARIALBD',
                fontSize: 23,
                fontWeight: FontWeight.bold)),
      ),
      home: Planner(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class Planner extends StatefulWidget {
  @override
  State<Planner> createState() => _PlannerState();
}

class _PlannerState extends State<Planner> {
  final List<Transection> _userTransection = [
    Transection(
        id: '0001', title: 'Clothes', amount: 32.99, date: DateTime.now()),
    Transection(
        id: '0002', title: 'Groceries', amount: 19.56, date: DateTime.now())
  ];

  bool _showChart = false;

  List<Transection> get _recentTransections {
    return _userTransection.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransection(String title, double amount, DateTime Date) {
    final newTx = Transection(
        title: title,
        amount: amount,
        date: Date,
        id: DateTime.now().toString());

    setState(() {
      _userTransection.add(newTx); //to add new values
    });
  }

  void _startAddNewTransection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (bcontext) {
        return GestureDetector(
          onTap: () {},
          child: NewTransection(_addNewTransection),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransections(String id) {
    setState(() {
      _userTransection.removeWhere((element) => element.id == id);
    });
  }

  List<Widget> _buildPortraitMode(
      MediaQueryData mediaQuery, AppBar appbarVariable) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appbarVariable.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Charts(_recentTransections),
      ),
      Container(
          height: (mediaQuery.size.height -
                  appbarVariable.preferredSize.height -
                  mediaQuery.padding.top) *
              0.7,
          child: TransectionList(_userTransection, _deleteTransections))
    ];
  }

  List<Widget> _buildLandscapeMode(
      MediaQueryData mediaQuery, AppBar appbarVariable) {
    return [
      Row(
        children: [
          Text('Show Chart'),
          Switch.adaptive(
            value: _showChart,
            onChanged: (value) {
              setState(
                () {
                  _showChart = value;
                },
              );
            },
          ),
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appbarVariable.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Charts(_recentTransections))
          : Container(
              height: (mediaQuery.size.height -
                      appbarVariable.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: TransectionList(_userTransection,
                  _deleteTransections)) //Switch.adaptive changes the look of the swtich while using an iphone or android
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(
        context); //an object initialized for the MediaQuerry to use it everywhere in the main.dart file
    final landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appbarVariable = AppBar(
      title: Text(
        'Expense Tracker', // style: Theme.of(context).appBarTheme.
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransection(context),
        )
      ],
    );
    return Scaffold(
      appBar: appbarVariable,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (landscape)
            ..._buildLandscapeMode(
              mediaQuery,
              appbarVariable,
            ),
          //
          //
          if (!landscape)
            ..._buildPortraitMode(
              mediaQuery,
              appbarVariable,
            ),
          //
          //
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: Icon(
                Icons.add,
              ),
              onPressed: () => _startAddNewTransection(context),
            ),
    );
  }
}
//if we return MaterialApp(), the standard blue colour will be implemented ignoring the theme swatch , so return Scaffold()
