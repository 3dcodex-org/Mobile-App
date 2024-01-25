/*import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String lable;
  final double spendingamount;
  final double spendingPctOfTotal;
  ChartBar(this.lable, this.spendingamount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('\N_o:${spendingamount.toStringAsFixed(0)}'),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10)),
            ),
            FractionallySizedBox(
              heightFactor: spendingPctOfTotal,
              child: Container(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
              ),
            )
          ]),
        ),
        SizedBox(
          height: 4,
        ),
      ],
    );
  }
}
*/