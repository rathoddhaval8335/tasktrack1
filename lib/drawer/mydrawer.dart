import 'package:flutter/material.dart';

import '../Screen/AddTaskPage/addtask.dart';
import '../Screen/EditTaskPage/edittask.dart';
import '../Screen/HomePage/homepage.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {

  int _SelectedIndex=0;
  List Pages=[
    HomePage(),
    Addtask(),
    EditPage(),

  ];

  List PageTitle=["Home","Add Task","Edit Task"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text(PageTitle[_SelectedIndex]),
         backgroundColor: Colors.blue,
      ),
      body: Pages[_SelectedIndex],
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text("Dhaval Rathod"),
                accountEmail: Text("dj12@gmail.com"),
              currentAccountPicture: CircleAvatar(
                child: Text("D",style: TextStyle(fontSize: 40),),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: (){
                setState(() {
                  _SelectedIndex=0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Add Task"),
              onTap: (){
                setState(() {
                  _SelectedIndex=1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Task"),
              onTap: (){
                setState(() {
                  _SelectedIndex=2;
                });
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
