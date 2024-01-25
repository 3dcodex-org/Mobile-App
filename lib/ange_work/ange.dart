/* import 'package:expence_app/widgets/new_transaction.dart';
import './widgets/chart.dart';

import '/widgets/transaction_list.dart';
import 'package:expence_app/widgets/new_transaction.dart';
// import '/widgets/user_transaction.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Quicksand',
        // appBarTheme: AppBarTheme(
        //   titleTextStyle:'OpenSans' ,
        // )
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<transaction> _usertransaction = [//list of folder
    // transaction(
    //   id: 't1',
    //   title: 'New shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // transaction(
    //   id: 't2',
    //   title: 'new table',
    //   amount: 17.79,
    //   date: DateTime.now(),
    // )
  ];
  List<transaction> get _recentTransaction {
    return _usertransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewtransaction(String Txtitle, double Txamount) {//function to add a transaction
    final newTX = transaction(
      id: DateTime.now().toString(),
      title: Txtitle,
      amount: Txamount,
      date: DateTime.now(),
    );

    setState(() {
      _usertransaction.add(newTX);
    });
  }

  void StratAddNewTransaction(BuildContext ctx) {//starting the proccess
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(_addNewtransaction),
          );
        });
  }

  @override
  Widget build(BuildContext context) {// scafold and app bar emplimentation
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Personal Expense'),
        actions: <Widget>[
          IconButton(
              onPressed: () => StratAddNewTransaction(context),
              icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransaction),
            TransactionList(_usertransaction)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,//floating button emplimentation at th e buttom of the page
      floatingActionButton: FloatingActionButton(
        onPressed: () => StratAddNewTransaction(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
*/