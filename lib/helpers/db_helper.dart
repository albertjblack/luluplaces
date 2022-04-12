import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DbHelper {
  // databse
  static Future<sql.Database> getOrCreateDb(String tableName) async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, "places_database.db"),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE $tableName(id TEXT PRIMARY KEY, title TEXT,image TEXT)");
    }, version: 1);
  }

  // insert
  static Future<void> insert(String tableName, Map<String, Object> data) async {
    final sqlDb = await DbHelper.getOrCreateDb(tableName);
    sqlDb.insert(tableName, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return;
  }

  // fetch
  static Future<List<Map<String, dynamic>>> getData(String tableName) async {
    final sqlDb = await DbHelper.getOrCreateDb(tableName);
    return sqlDb.query(tableName);
  }
}
