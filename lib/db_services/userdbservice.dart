import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:student_app/models/user_model.dart';

class Dbservice {
  Dbservice._internal();

  static final Dbservice _instance = Dbservice._internal();
  static Database? _database;

  factory Dbservice(){
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initdb();
    return _database!;
  }

  initdb() async {
    String path = join(await getDatabasesPath(), "studentsdb.db");
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute(
            '''
          CREATE TABLE students(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          firstname TEXT NOT NULL,
          lastname TEXT NOT NULL,
          email TEXT NOT NULL,
          password TEXT NOT NULL
          )
          '''
        );
      },
    );
  }

  Future<int> createuser(Student student) async {
    var dbclient = await database;
    return await dbclient.insert("students", student.toMap());
  }

  Future<int> insertUser(String email, String password) async {
    final dbclient = await database;
    return await dbclient.insert(
        'students', {'email': email, 'password': password});
  }

  Future<Map<String, dynamic>?> getUser(String email, String password) async {
    final dbclient = await database;
    final result = await dbclient.query(
        "students", where: "email=? AND password=?", whereArgs: [email, password]);
    return result.isNotEmpty ? result.first: null;
  }
}
