import 'package:flutter/material.dart';

import 'helpers/DataBaseHelper.dart';

class Balance extends StatefulWidget {

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  var totalincome=0.0,totalexpense=0.0,balance=0.0;

  getdata() async {
    DatabaseHelper obj = new DatabaseHelper();
    var alldata = await obj.getAllExpense();
    for(var row in alldata)
      {
        if(row["type"].toString()=="Income")
          {
            setState(() {
              totalincome=totalincome +  double.parse(row["amount"].toString());
            });
          }
        else {
          setState(() {
            totalexpense = totalexpense + double.parse(row["amount"].toString());
          });
        }
      }
      setState(() {
        balance=totalincome-totalexpense;
      });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child :Container(
          color: Color(0xFFf3e5f5),
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child:Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Expense : "+totalexpense.toString(),style: TextStyle(fontSize: 18,color: Color(0xFF4a148c)),),
                    SizedBox(width: 20,),
                    Text("Income : "+totalincome.toString(),style: TextStyle(fontSize: 18,color: Color(0xFF4a148c)),),
                  ],
                ),
                SizedBox(height: 40,),
                Text("Balance : "+balance.toString(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Color(0xFF4a148c)),),
              ],
            ),

        ),
        ),
    );
  }
}
