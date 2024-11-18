//import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


import 'package:student_app/models/course_model.dart';

class DatabaseHelper{
  DatabaseHelper._internal();
  static final DatabaseHelper _instance=DatabaseHelper._internal();
  factory DatabaseHelper()=> _instance;
  static Database? _database;
  Future<Database> get database async{
    if(_database!=null)return _database!;
    _database =await _initDatabase();
    return _database!;
  }
  Future<Database>_initDatabase() async{
    String path=join(await getDatabasesPath(),'course_db.db');
    return openDatabase(
        path,
        version: 2,
        onCreate: (db,version){
          return db.execute(
              '''
          CREATE TABLE courses(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          firstname TEXT NOT NULL,
          lastname TEXT NOT NULL,
          gender TEXT NOT NULL,
          email TEXT NOT NULL,
          title TEXT NOT NULL,
          category TEXT NOT NULL,
          studentid TEXT NOT NULL)
          '''
         );

        },
      onUpgrade: (db,oldVersion,newVersion) async{
          if(oldVersion<newVersion){
            await db.execute('ALTER TABLE courses ADD COLUMN category TEXT NOT NULL');
            print('Column added');
          }
      }
     );
  }
  Future<void> insertCourse(CourseModel course) async{
    final db=await database;
    await db.insert('courses', course.toMap(),
      conflictAlgorithm:
      ConflictAlgorithm.replace,
    );
  }
  Future<List<CourseModel>>courseModel() async{
    final db=await database;
    final List<Map<String,dynamic>> maps=await db.query('courses');
    return List.generate(maps.length,(i){
      return CourseModel(
          id:maps[i]['id'],
          firstname: maps[i]['firstname'],
          lastname: maps[i]['firstname'],
          gender: maps[i]['lastname'],
          email: maps[i]['email'],
          title: maps[i]['title'],
          category: maps[i]['category'],
          studentid: maps[i]['studentid']
      );
    });
  }
  Future<void> updateCourse(CourseModel course,int id)async{
    final db=await database;
    await db.update('courses',course.toMap(),
      where: 'id=?',
      whereArgs: [course.id],
    );
  }
  Future<void> deleteCourse(int  id)async{
    final db=await database;
    await db.delete(
      'courses',
      where: 'id=?',
      whereArgs: [id],
    );
  }

}