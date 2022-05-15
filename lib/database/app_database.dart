import 'package:bytebank_final/database/dao/contact_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDataBase() async {
  const String _dbName = 'bytebank.db';

  final String path = join(await getDatabasesPath(), _dbName);
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ContactDao.tableSql);
    },
    version: 1,
    // onDowngrade: onDatabaseDowngradeDelete,
  );
}

