import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'Addition.dart';
// import 'GridViewExample.dart';
// import 'ImageExample.dart';
// import 'Mobile.dart';
// import 'MxPlayerExample.dart';
// import 'Tab1Ex.dart';
// import 'Tab2Ex.dart';
// import 'Tab3Ex.dart';
// import 'TextFieldEx.dart';
class TabExample extends StatefulWidget {

  @override
  _TabExampleState createState() => _TabExampleState();
}

class _TabExampleState extends State<TabExample> with SingleTickerProviderStateMixin  {

  TabController _tabController;
  var position=0;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
    _tabController.addListener(getTabIndex);
  }
  void getTabIndex() {
    var index = _tabController.index;
    setState(() {
      position=index;
    });
    // print("Current Index : "+index.toString());
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
        appBar: AppBar(
        backgroundColor: (position==0)?Colors.purple:(position==1)?Colors.pink[600]:Colors.green[900],
            title: Text("Whatsapp"),
          actions: [
            IconButton(
              onPressed:(){} ,
              icon: Icon(Icons.search),
            ),
            (position==0)?PopupMenuButton(
            onSelected: (val)
                  {
                    // if(val==1)
                    // {
                    //   Navigator.of(context).push(
                    //       MaterialPageRoute(builder: (context) => Addition())
                    //   );
                    // }
                    // else if(val==2)
                    // {
                    //   Navigator.of(context).push(
                    //       MaterialPageRoute(builder: (context) => ImageExample())
                    //   );
                    // }
                    // else if(val==3)
                    // {
                    //   Navigator.of(context).push(
                    //       MaterialPageRoute(builder: (context) => GridViewExample())
                    //   );
                    // }
                    // else if(val==4)
                    // {
                    //   Navigator.of(context).push(
                    //       MaterialPageRoute(builder: (context) => Mobile())
                    //   );
                    // }
                    // else if(val==5)
                    // {
                    //   Navigator.of(context).push(
                    //       MaterialPageRoute(builder: (context) => MxPlayerExample())
                    //   );
                    // }
                    // else
                    // {
                    //   Navigator.of(context).push(
                    //       MaterialPageRoute(builder: (context) => TextFieldEx())
                    //   );
                    // }
                  },
              itemBuilder: (context) =>
              [
                PopupMenuItem(
                  child: Text("New group"),
                  value: 1,
                ),
                PopupMenuItem(
                  child: Text("New broadcast"),
                  value: 2,
                ),
                PopupMenuItem(
                  child: Text("Linked devices"),
                  value: 3,
                ),
                PopupMenuItem(
                  child: Text("Starred messages"),
                  value: 4,
                ),
                PopupMenuItem(
                  child: Text("Payments"),
                  value: 5,
                ),
                PopupMenuItem(
                  child: Text("Settings"),
                  value: 6,
                ),
              ],
            ):(position==1)?PopupMenuButton(
              itemBuilder: (context) =>
              [
                PopupMenuItem(
                  child: Text("Status privacy"),
                ),
                PopupMenuItem(
                  child: Text("Settings"),
                ),
              ],
            ):PopupMenuButton(
              itemBuilder: (context) =>
              [
                PopupMenuItem(
                  child: Text("Clear Call log"),
                ),
                PopupMenuItem(
                  child: Text("Settings"),
                ),
              ],
            )
          ],
          bottom: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // Creates border
                color: Colors.indigo), //Change background color from here
            tabs: [
              Tab(
                child: Text("chats"),
              ),
              Tab(
                child: Text("status"),
              ),
              Tab(
                child: Text("calls"),
              ),
            ],
          ),
        ),
          body: TabBarView(
            controller: _tabController,
            children: [
              // Tab1Ex(),
              // Tab2Ex(),
              // Tab3Ex(),
            ],
          ),
          floatingActionButton:
          (position==0)?FloatingActionButton(
               child: Icon(Icons.message)
             ):
          (position==1)?FloatingActionButton(
              child: Icon(Icons.camera_alt)
          ):
          FloatingActionButton(
            child: Icon(Icons.call)
          )
          ),
        );
  }
}
          // actions: [
          //   PopupMenuButton(
          //       onSelected: (val)
          //       {
          //         if(val==1)
          //         {
          //           Navigator.of(context).push(
          //               MaterialPageRoute(builder: (context) => Addition())
          //           );
          //         }
          //         else if(val==2)
          //         {
          //           Navigator.of(context).push(
          //               MaterialPageRoute(builder: (context) => ImageExample())
          //           );
          //         }
          //         else if(val==3)
          //         {
          //           Navigator.of(context).push(
          //               MaterialPageRoute(builder: (context) => GridViewExample())
          //           );
          //         }
          //         else if(val==4)
          //         {
          //           Navigator.of(context).push(
          //               MaterialPageRoute(builder: (context) => Mobile())
          //           );
          //         }
          //         else if(val==5)
          //         {
          //           Navigator.of(context).push(
          //               MaterialPageRoute(builder: (context) => MxPlayerExample())
          //           );
          //         }
          //         else
          //         {
          //           Navigator.of(context).push(
          //               MaterialPageRoute(builder: (context) => TextFieldEx())
          //           );
          //         }
          //       },
          //       itemBuilder: (context) => [
          //         PopupMenuItem(
          //           child: Text("New group"),
          //           value: 1,
          //         ),
          //         PopupMenuItem(
          //           child: Text("New broadcast"),
          //           value: 2,
          //         ),
          //         PopupMenuItem(
          //           child: Text("Linked devices"),
          //           value: 3,
          //         ),
          //         PopupMenuItem(
          //           child: Text("Starred message"),
          //           value: 4,
          //         ),
          //         PopupMenuItem(
          //           child: Text("Payments"),
          //           value: 5,
          //         ),
          //         PopupMenuItem(
          //           child: Text("Settings"),
          //           value: 6,
          //         )
          //       ]
          //   )
          // ],
          // bottom:  PreferredSize(
          //   child: TabBar(
          //             indicatorColor: Colors.blue,
          //             unselectedLabelColor: Colors.grey,
          //             labelColor: Colors.white,
          //             isScrollable: false,

    // to customise tab indicator
    //                   indicator: UnderlineTabIndicator(
    //                   borderSide: BorderSide(width: 5.0, color: Colors.blue),
    //                   insets: EdgeInsets.symmetric(horizontal: 16.0)),



              // indicatorWeight: 10,
            //  isScrollable: true,
              // indicatorColor: Colors.white,
              // indicator: BoxDecoration(
              //     borderRadius: BorderRadius.circular(30), // Creates border
              //     color: Colors.white),
              // labelColor: Colors.black,
          //     tabs: [
          //       Tab(
          //   child: FittedBox(child: Text('CHATS', style: TextStyle(color: Colors.black),))
          //       ),
          //       Tab(
          //           child: FittedBox(child: Text('STATUS', style: TextStyle(color: Colors.black),))
          //       ),
          //       Tab(
          //           child: FittedBox(child: Text('CALLS', style: TextStyle(color: Colors.black),))
          //       ),
          //       Tab(
          //           child: FittedBox(child: Text('HOME', style: TextStyle(color: Colors.black),))
          //       ),
          //       Tab(
          //           child: FittedBox(child: Text('ABOUT', style: TextStyle(color: Colors.black),))
          //       ),
          //       Tab(
          //           child: FittedBox(child: Text('CONTACT', style: TextStyle(color: Colors.black),))
          //       ),
          //       Tab(
          //           child: FittedBox(child: Text('PHOTOS', style: TextStyle(color: Colors.black),))
          //       ),
          //     ],
          //   ),
          //     preferredSize: Size.fromHeight(60.0)),
          // ),

