import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'HomePage.dart';
import 'helpers/DataBaseHelper.dart';


class ExpenseManagerPage extends StatefulWidget {
  @override
  State<ExpenseManagerPage> createState() => _ExpenseManagerPageState();
}

class _ExpenseManagerPageState extends State<ExpenseManagerPage> {
  var operation = "Expense";
  var finaldate="";

  TextEditingController _title =TextEditingController();
  TextEditingController _amount =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ExpenseManagerPage"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Title : ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _title,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter a Title'),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Amount : ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _amount,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter a amount'),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Radio(
                      groupValue: operation,
                      value: "Expense",
                      activeColor: Colors.red,
                      // fillColor: MaterialStateColor.resolveWith((states) => Colors.red),
                      onChanged: (val) {
                        setState(() {
                          operation = val;
                        });
                      },
                    ),
                    Text(
                      "Expense",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    Radio(
                      groupValue: operation,
                      value: "Income",
                      activeColor: Colors.green,
                      //   fillColor: MaterialStateColor.resolveWith((states) => Colors.green),
                      onChanged: (val) {
                        setState(() {
                          operation = val;
                        });
                      },
                    ),
                    Text(
                      "Income",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Date : ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              DateTimePicker(
                type: DateTimePickerType.dateTimeSeparate,
                dateMask: 'd MMM, yyyy',
                initialValue: DateTime.now().toString(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                // icon: Icon(Icons.event),
                dateLabelText: 'Date',
                timeLabelText: "Hour",
                selectableDayPredicate: (date) {
                  // Disable weekend days to select from the calendar
                  if (date.weekday == 6 || date.weekday == 7)
                  {
                    return false;
                  }
                  return true;
                },
                onChanged: (val){
                  setState(() {
                    finaldate=val;
                  });
                },
                validator: (val)
                {
                  print(val);
                  return null;
                },
                onSaved: (val) => print(val),
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                  child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    var title = _title.text.toString();
                    var amount = _amount.text.toString();

                    DatabaseHelper obj = new DatabaseHelper();
                    var id = await obj.addexpense(title,amount,operation,finaldate);
                    print("Record Inserted at : "+id.toString());

                    Fluttertoast.showToast(
                        msg: "Expense Inserted Successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                    _title.text="";
                    _amount.text="";
                    operation="";
                    finaldate="";

                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => HomePage())
                    );
                    },
                  child: Text(
                    "Add",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
