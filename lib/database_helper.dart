import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = "EmployeeDatabase.db";
  static final _databaseVersion = 2;

  static final table = 'employee';

  static final columnId = 'id';
  static final columnName = 'name';
  static final columnDesignation = 'designation';
  static final columnSalary = 'salary';
  static final columnJoiningDate = 'joiningDate';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnDesignation TEXT NOT NULL,
            $columnSalary REAL NOT NULL,
            $columnJoiningDate TEXT NOT NULL
          )
          ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute('ALTER TABLE $table ADD COLUMN $columnJoiningDate TEXT');
    }
  }

  Future<int> insertEmployee(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(table, row);
  }

  Future<int> updateEmployee(int id, Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteEmployee(int id) async {
    Database? db = await instance.database;
    return await db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> queryAllEmployees() async {
    Database? db = await instance.database;
    return await db!.query(table);
  }
}
