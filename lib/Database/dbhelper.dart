import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDb {
  //Database Details
  static final _dbname = "dhaval.db";
  static final _dbversion = 1;

  //Table Details
  static final tabalenm = "tasks";
  static final idcol = "id";
  static final titlecol = "task_name";
  static final taskdec = "task_description";
  static final taskduedate = "task_date";
  static final taskstuts = "task_status";
  static final taskpriority = "task_priority";

  //private constructor
  MyDb._taskconst();

  //database object
  Database? db;

  //const intilization
  static final MyDb instance = MyDb._taskconst();

  //get database details
  Future<Database> get database async => db ??= await _initDatabase();

  Future _initDatabase() async {
    Directory directorypath = await getApplicationDocumentsDirectory();
    String finalpath = join(directorypath.path, _dbname);

    return await openDatabase(
      finalpath,
      version: _dbversion,
      onCreate: _Oncreate,
    );
  }

  Future<void> _Oncreate(Database db, int version) async {
    await db.execute(''' 
        CREATE TABLE $tabalenm(
          $idcol INTEGER PRIMARY KEY,
          $titlecol TEXT NOT NULL,
          $taskdec TEXT NOT NULL,
          $taskduedate TEXT NOT NULL,
          $taskstuts TEXT NOT NULL DEFAULT 'pending',
          $taskpriority TEXT NOT NULL
        )
       ''');
  }

  Future<int> InsertDate(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db.insert(tabalenm, row);
  }

  //view
  Future<List<Map<String, dynamic>>> queryalltask() async {
    Database db = await instance.database;
    return await db.query(tabalenm);
  }

  //Update
  Future<int> UpdateTask(Map<String,dynamic> row,int id) async{
     Database db=await instance.database;
     return await db.update(
      tabalenm,
       row,
       where: "$idcol= ?",
       whereArgs: [id],
     );
  }
}
