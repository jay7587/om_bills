import 'package:flutter/material.dart';

import 'add_bill_screen.dart';

class BillList extends StatefulWidget {
  static const routeName = '/BillList';
  @override
  _BillListState createState() => _BillListState();
}

class _BillListState extends State<BillList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Om Bills"),
      ),
      body: Center(
        child: Text(
          'Your bills',
        ),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed(AddBillScreen.routeName);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
