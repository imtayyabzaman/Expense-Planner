import './transection_Item.dart';

import '../models/transection.dart';


import 'package:flutter/material.dart';

class TransectionList extends StatelessWidget {
  final List<Transection> _userTransection;
  // ignore: prefer_typing_uninitialized_variables
  final _deletetx;
  const TransectionList(this._userTransection, this._deletetx, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return //Container(
        //height: MediaQuery.of(context).size.height * 0.6,
        //child:
        _userTransection.isEmpty
            ? LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    children: [
                      Text(
                        'No transection added yet!',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const SizedBox(
                        //sizedbox creates some space between text and image on screen
                        height: 30,
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.6,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  );
                },
              )
            : ListView(
                children: _userTransection
                    .map(
                      (tx) => transactionItem(
                        userTransection: tx,
                        deletetx: _deletetx,
                        key: ValueKey(tx.id),
                      ),
                    )
                    .toList(),

                //ListView is an alternative for Column Widget, just with an addition of Scrolling property in it!
                // children: _userTransection.map((tx) {}).toList(),
                //),
              );
  }
}
