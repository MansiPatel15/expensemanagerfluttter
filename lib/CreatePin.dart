import 'package:expensemanager/ExpenseManagerPage.dart';
import 'package:expensemanager/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'EnterPin.dart';

class CreatePin extends StatefulWidget {

  @override
  State<CreatePin> createState() => _CreatePinState();
}

class _CreatePinState extends State<CreatePin> {

  GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController _pin = TextEditingController();
  TextEditingController _confirm = TextEditingController();


  checkpin() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("Pin"))
    {
      if(prefs.containsKey("counter"))
      {
        if(prefs.getInt("counter")>=3)
        {
          Navigator.of(context).pop();
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => ExpenseManagerPage())
          );
        }
        else
        {
          Navigator.of(context).pop();
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => EnterPin())
          );
        }
      }
      else
      {
        Navigator.of(context).pop();
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => EnterPin())
        );
      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkpin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CreatePinPage....."),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child : Form(
            key: _form,
            child :Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Create A Pin",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                SizedBox(
                  height: 20,
                ),
                Text("PIN : ",style: TextStyle(fontSize: 20,),),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: _pin,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    decoration: InputDecoration(border: OutlineInputBorder(),
                    ),
                    validator: (val)
                    {
                      if(val.isEmpty)
                      {
                        return 'Empty';
                      }
                      else
                      {
                        return null;
                      }
                    }
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Confirm Pin : ",style: TextStyle(fontSize: 20,),),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: _confirm,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    decoration: InputDecoration(border: OutlineInputBorder(),
                    ),
                    validator: (val)
                    {
                      if(val.isEmpty)
                      {
                        return 'Empty';
                      }
                      else if(val != _pin.text)
                      {
                        return 'Not Match';
                      }
                      else
                      {
                        return null;
                      }
                    }
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          if(_form.currentState.validate())
                          {
                            var pin = _pin.text.toString();

                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("Pin", pin);

                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => HomePage())
                            );

                          }
                        },
                        child: Text("Submit",style: TextStyle(fontSize: 20),),
                      ),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
