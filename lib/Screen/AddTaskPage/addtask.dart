import 'package:flutter/material.dart';
import 'package:tasktrack1/Database/dbhelper.dart';

class Addtask extends StatefulWidget {
  const Addtask({super.key});

  @override
  State<Addtask> createState() => _AddtaskState();
}

class _AddtaskState extends State<Addtask> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _taskControler = TextEditingController();
  TextEditingController _DescriptionControler = TextEditingController();
  TextEditingController _datePickerControler = TextEditingController();

  List<String> _Priority = ["Low", "Medium", "High"];
  String? _SelectPriority;

  final dbhelper=MyDb.instance;

  @override
  void initState() {
    super.initState();
    _SelectPriority = _Priority.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _taskControler,
                  validator: (val){
                    if(val!.isEmpty){
                      return "Please Enter Task";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Any Task ",
                  ),
                ),
                SizedBox(height: 15),

                // Description field
                TextFormField(
                  controller: _DescriptionControler,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  validator: (val){
                    if(val!.isEmpty){
                      return "Please Enter Task Description";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Task Description",
                  ),
                ),
                SizedBox(height: 15),

                TextFormField(
                  controller: _datePickerControler,
                  readOnly: true,
                  validator: (val){
                    if(val!.isEmpty){
                      return "Please Enter Date";
                    }
                    return null;
                  },
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    await _selectDatePick(context);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Select Date",
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),

                SizedBox(height: 15),

                DropdownButtonFormField(
                  value: _SelectPriority,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Select Priority"),
                  items: _Priority.map((String prt) {
                    return DropdownMenuItem(
                      value: prt,
                      child: Text(prt),
                    );
                  }).toList(),
                  onChanged: (String? val) {
                    setState(() {
                      _SelectPriority = val;
                    });
                  },
                ),

                SizedBox(height: 15),

                ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _insertData();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    "Save",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDatePick(BuildContext context) async {
    DateTime? datepick = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (datepick != null) {
      setState(() {
        _datePickerControler.text =
        "${datepick.day}/${datepick.month}/${datepick.year}";
      });
    }
  }

  void _insertData() async{
    Map<String,dynamic> row={
      MyDb.titlecol:_taskControler.text.toString(),
      MyDb.taskdec:_DescriptionControler.text.toString(),
      MyDb.taskduedate:_datePickerControler.text.toString(),
      MyDb.taskpriority:_SelectPriority,
    };
    print("Insert Data In The Table");
    setState(() {
      _taskControler.clear();
      _DescriptionControler.clear();
      _datePickerControler.clear();
      _SelectPriority = _Priority.first;
    });
    final id=await dbhelper.InsertDate(row);
    print('inserted row id: $id');
  }
}
