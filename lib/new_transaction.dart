import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {//statefull wigdet of the new transaction
  final Function addTx;

  const NewTransaction(this.addTx, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  // ignore: non_constant_identifier_names
  final TitleController = TextEditingController();

  // ignore: non_constant_identifier_names
  final AmountController = TextEditingController();

  void addSubmitData(){
     final enteredtitle=TitleController.text;
      final enteredamount=double.parse(AmountController.text);
      if(enteredtitle.isEmpty||enteredamount<=0){
        return;
      }
     widget.addTx(
     
                  enteredtitle,
                  enteredamount,
                );
                Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {//text lable to write th name of the folder
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'title'),
              controller: TitleController,//keeping the name of the folder 
              onSubmitted: (_) =>addSubmitData(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'folder Number bof the day'),
              controller: AmountController,//keeping folder info
              keyboardType: TextInputType.number,
              onSubmitted: (_) =>addSubmitData(),
            ),
            TextButton(
              onPressed: addSubmitData
              ,
              child: const Text("Add transaction"),
            ),
          ],
        ),
      ),
    );
  }
}
