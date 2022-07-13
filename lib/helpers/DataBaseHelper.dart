import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper
{
  Database db;

  //Database Create
  Future<Database> create_db() async
  {
    //databse already exist
    if(db!=null)
    {
      return db;
    }
    else
    {
      //databse create
      Directory dir = await getApplicationDocumentsDirectory();
      String path = join(dir.path,"shopdb");
      var db = await openDatabase(path,version: 1,onCreate: create_table);
      return db;
    }
  }
  create_table(Database db,int version) async
  {
    //table create
    db.execute("create table expense (eid integer primary key autoincrement,title text,amount double,type text,datetime text)");
    print("Table Create");
  }
  Future<int> addexpense(title,amount,operation,finaldate) async
  {
    var db = await create_db();
    var id = await db.rawInsert("insert into expense (title,amount,type,datetime) values(?,?,?,?)",[title,amount,operation,finaldate]);
    return id;
  }
  Future<int> updateexpense(title,amount,operation,finaldate,updateid) async
  {
    var db = await create_db();
    var status = await db.rawUpdate("update expense set title=?,amount=?,type=?,datetime=? where eid=?",[title,amount,operation,finaldate,updateid]);
    return status;
  }

  Future<List> getAllExpense() async
  {
    var db = await create_db();
    var data = await db.rawQuery("select * from expense");
    return data.toList();
  }

  Future<int> deleteExpense(id) async
  {
    var db = await create_db();
    var status = await db.rawDelete("delete from expense where eid=?",[id]);
    return status;
  }
  Future<List> getsingleexpense(id) async
  {
    var db = await create_db();
    var data = await db.rawQuery("select * from expense where eid=?",[id]);
    return data.toList();
  }
}