import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getTable(String sql) async {
  final String dbPath = await getDatabasesPath();
  String path = getDbPath(dbPath);
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(sql);
    },
    version: 1,
//      onDowngrade: onDatabaseDowngradeDelete,
  );
}

String getDbPath(String dbPath) {
  final String path = join(dbPath, 'bytebank.db');
  return path;
}
