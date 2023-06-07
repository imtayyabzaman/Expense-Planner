import 'package:flutter/material.dart';

class BarCharts extends StatelessWidget {
  final String day;
  final double amount;
  final double percentage;

  BarCharts(this.day, this.amount, this.percentage);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Container(
                height: constraints.maxHeight * 0.15,
                child:
                    FittedBox(child: Text('\$${amount.toStringAsFixed(0)}'))),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 25,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).accentColor, width: 1),
                        color: Color.fromARGB(255, 211, 208, 208),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  FractionallySizedBox(
                    //insted of container here , use a fractionSizedBox , as it allows to style a box that is the fraction of the surrounding container in the stack
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
                height: constraints.maxHeight * 0.15,
                child: FittedBox(
                    child: Text(
                        day))), //fittedbox automatically resizes the text according to the device size
          ],
        );
      },
    );
  }
}
