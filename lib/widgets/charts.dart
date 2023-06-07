import 'package:expense_planner/models/transection.dart';
import 'package:expense_planner/widgets/barCharts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Charts extends StatelessWidget {
  final List<Transection> recentTransection;

  Charts(this.recentTransection);

  List<Map<String, dynamic>> get groupedTransectionValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));

        var totalSum = 0.0;
        for (var i = 0; i < recentTransection.length; i++) {
          if (recentTransection[i].date.day == weekDay.day &&
              recentTransection[i].date.month == weekDay.month &&
              recentTransection[i].date.year == weekDay.year) {
            totalSum += recentTransection[i].amount;
          }
        }
        print(DateFormat.E().format(weekDay).substring(0, 1));
        print(totalSum);

        return {
          'day': DateFormat.E().format(weekDay).substring(0, 1),
          'amount': totalSum
        };
      },
    ).reversed.toList();
  }

  double get totalSpending {
    return groupedTransectionValues.fold(
      0.0,
      (sum, item) {
        return sum + item['amount'];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransectionValues);
    return //Container(
        //height: MediaQuery.of(context).size.height * 0.4,
        //child:
        Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransectionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: BarCharts(
                  data['day'],
                  data['amount'] as double,
                  totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
      //),
    );
  }
}
