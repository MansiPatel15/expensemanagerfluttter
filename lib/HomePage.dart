import 'package:expensemanager/Balance.dart';
import 'package:expensemanager/ExpenseManagerPage.dart';
import 'package:expensemanager/Transactions.dart';
import 'package:expensemanager/UpdateExpense.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'helpers/DataBaseHelper.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List> alldata;

  getdata() async {
    DatabaseHelper obj = new DatabaseHelper();
    setState(() {
      alldata = obj.getAllExpense();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  _createDialog(id) {
    AlertDialog alert = AlertDialog(
      title: Text(
        "Are You Sure ?",
        textAlign: TextAlign.center,
      ),
      content: Text(
        "Do you really want to delete permanently ?",
        style: TextStyle(fontSize: 13),
      ),
      contentPadding: EdgeInsets.all(15.0),
      actions: [
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                  onPressed: () async {
                    DatabaseHelper obj = new DatabaseHelper();
                    int status = await obj.deleteExpense(id);
                    print("Status : " + status.toString());
                    Navigator.of(context).pop();
                    if (status == 1) {
                      print("Record Deleted");
                      Fluttertoast.showToast(
                          msg: "Expense Deleted Successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      getdata();
                    } else {
                      print("Error");
                    }
                  },
                  child: Text("Yes")),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("No")),
            )
          ],
        )
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("ExpenseManager"),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text("Transaction"),
                icon: Icon(Icons.compare_arrows_outlined),
              ),
              Tab(
                child: Text("Balance"),
                icon: Icon(Icons.attach_money_outlined),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Transactions(),
            Balance()
          ],
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 20,
          // isExtended: true,
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ExpenseManagerPage()));
          },
        ),
        // body: SingleChildScrollView(
        //   child: Column(
        //     children: [
        //       Padding(
        //         padding: EdgeInsets.all(10),
        //         child : Column(
        //           children: [
        //             Container(
        //               color: Colors.black,
        //               width: MediaQuery.of(context).size.width,
        //               height: 250,
        //               child: Card(
        //                 color: Colors.red,
        //                 child : Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Container(
        //                       width: MediaQuery.of(context).size.width/2.2,
        //                       padding: EdgeInsets.all(10),
        //                       alignment: Alignment.bottomCenter,
        //                       child: ElevatedButton(
        //                         onPressed: (){},
        //                         child: Text("Edit"),
        //                       ),
        //                     ),
        //                     Container(
        //                       width: MediaQuery.of(context).size.width/2.2,
        //                       padding: EdgeInsets.all(10),
        //                       alignment: Alignment.bottomCenter,
        //                       child: ElevatedButton(
        //                         onPressed: (){},
        //                         child: Text("Delete"),
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ],
        //         )
        //       ),
        //       Padding(
        //           padding: EdgeInsets.all(10),
        //           child : Column(
        //             children: [
        //               Container(
        //                 color: Colors.black,
        //                 width: MediaQuery.of(context).size.width,
        //                 height: 250,
        //                 child: Card(
        //                   color: Colors.green,
        //                   child : Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Container(
        //                         width: MediaQuery.of(context).size.width/2.2,
        //                         padding: EdgeInsets.all(10),
        //                         alignment: Alignment.bottomCenter,
        //                         child: ElevatedButton(
        //                           onPressed: (){},
        //                           child: Text("Edit"),
        //                         ),
        //                       ),
        //                       Container(
        //                         width: MediaQuery.of(context).size.width/2.2,
        //                         padding: EdgeInsets.all(10),
        //                         alignment: Alignment.bottomCenter,
        //                         child: ElevatedButton(
        //                           onPressed: (){},
        //                           child: Text("Delete"),
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           )
        //       ),
        //       Padding(
        //           padding: EdgeInsets.all(10),
        //           child : Column(
        //             children: [
        //               Container(
        //                 color: Colors.black,
        //                 width: MediaQuery.of(context).size.width,
        //                 height: 250,
        //                 child: Card(
        //                   color: Colors.purple,
        //                   child : Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Container(
        //                         width: MediaQuery.of(context).size.width/2.2,
        //                         padding: EdgeInsets.all(10),
        //                         alignment: Alignment.bottomCenter,
        //                         child: ElevatedButton(
        //                           onPressed: (){},
        //                           child: Text("Edit"),
        //                         ),
        //                       ),
        //                       Container(
        //                         width: MediaQuery.of(context).size.width/2.2,
        //                         padding: EdgeInsets.all(10),
        //                         alignment: Alignment.bottomCenter,
        //                         child: ElevatedButton(
        //                           onPressed: (){},
        //                           child: Text("Delete"),
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           )
        //       ),
        //     ],
        //   )
        // ),
        // body: FutureBuilder(
        //   future: alldata,
        //   builder: (context,snapshots)
        //   {
        //     if(snapshots.hasData)
        //     {
        //       //if data loaded
        //       if(snapshots.data.length<=0)
        //       {
        //         return Center(child: Text("No Data!"));
        //       }
        //       else
        //       {
        //         return ListView.builder(
        //           itemCount: snapshots.data.length,
        //           itemBuilder: (context,index)
        //           {
        //             return Card(
        //               color: (snapshots.data[index]["type"].toString()=="Income")?Colors.green.shade300:Colors.red.shade300,
        //               elevation: 20,
        //               margin: EdgeInsets.all(15.0),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text(snapshots.data[index]["title"].toString(),style: TextStyle(fontSize: 20,color: Colors.white),),
        //                   Divider(
        //                     color: Colors.white,
        //                   ),
        //                   Text(snapshots.data[index]["amount"].toString(),style: TextStyle(fontSize: 20,color: Colors.white),),
        //                   Divider(
        //                     color: Colors.white,
        //                   ),
        //                   Text(snapshots.data[index]["datetime"].toString(),style: TextStyle(fontSize: 20,color: Colors.white),),
        //                   Divider(
        //                     color: Colors.white,
        //                   ),
        //                   SizedBox(
        //                     height: 10,
        //                   ),
        //                   Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Padding(padding: EdgeInsets.all(5)),
        //                       Container(
        //                         width: MediaQuery.of(context).size.width/2.5,
        //                         child: ElevatedButton(
        //                           onPressed: (){
        //                             var id = snapshots.data[index]["eid"].toString();
        //                             _createDialog(id);
        //                           },
        //                           child: Text("Delete"),
        //                         ),
        //                       ),
        //                       Padding(padding: EdgeInsets.all(5)),
        //                       Container(
        //                         width: MediaQuery.of(context).size.width/2.5,
        //                         child: ElevatedButton(
        //                           onPressed: (){
        //                             var id = snapshots.data[index]["eid"].toString();
        //                             Navigator.of(context).push(
        //                                 MaterialPageRoute(builder: (context)=> UpdateExpense(updateid: id))
        //                             );
        //                           },
        //                           child: Text("Update"),
        //                         ),
        //                       ),
        //                       Padding(padding: EdgeInsets.all(5)),
        //                     ],
        //                   ),
        //                 ],
        //               ),
        //             );
        //           },
        //         );
        //       }
        //     }
        //     else
        //     {
        //       //data not loaded yet
        //       return Center(child: CircularProgressIndicator(),);
        //     }
        //   },
        // ),
      ),
    );
  }
}
