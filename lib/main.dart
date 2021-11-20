import 'package:flutter/material.dart';
import 'package:om_bills/screen/add_bill_screen.dart';
import 'package:om_bills/screen/bill_list.dart';

void main() => {
  runApp(MyApp())
};

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Om Billing',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.amber,
      ),
      home: MyHomePage(),
      routes: {
        BillList.routeName : (ctx) => BillList(),
        AddBillScreen.routeName : (ctx) => AddBillScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BillList();
  }
}



