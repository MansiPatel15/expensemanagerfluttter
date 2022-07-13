import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'HomePage.dart';
import 'helpers/DataBaseHelper.dart';

class UpdateExpense extends StatefulWidget {
  var updateid="";
  UpdateExpense({this.updateid});

  @override
  State<UpdateExpense> createState() => _UpdateExpenseState();
}

class _UpdateExpenseState extends State<UpdateExpense> {
  var operation = "Expense";
  var finaldate="";

  TextEditingController _title =TextEditingController();
  TextEditingController _amount =TextEditingController();


  getsingledata() async
  {
    DatabaseHelper obj = new DatabaseHelper();
    var data=await obj.getsingleexpense(widget.updateid);
    setState(() {
      _title.text = data[0]["title"].toString();
      _amount.text = data[0]["amount"].toString();
      operation = data[0]["type"].toString();
      finaldate = data[0]["datetime"].toString();
      print("Date : "+finaldate);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getsingledata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UpdateExpenseManagerPage"),
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
              (finaldate!="")?DateTimePicker(
                type: DateTimePickerType.dateTimeSeparate,
                dateMask: 'd MMM, yyyy',
                initialValue:finaldate.toString(),
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
              ):SizedBox(height: 0),

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
                        var status = await obj.updateexpense(title,amount,operation,finaldate,widget.updateid);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=> HomePage())
                        );
                        Fluttertoast.showToast(
                            msg: "Expense Updated Successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      },
                      child: Text(
                        "Update",
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
