import 'package:sqflite/sqflite.dart';

import '../../models/contact.dart';
import '../app_database.dart';

class ContactDao {

  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_accountNumber INTEGER)';
  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';

  Future<int> save(Contact contact) async {
    final Database db = await getDataBase();
    Map<String, dynamic> contactMap = toMap(contact);
    return db.insert(_tableName, contactMap);
  }

  Map<String, dynamic> toMap(Contact contact) {
    final Map<String, dynamic> contactMap = {};
    contactMap[_name] = contact.name;
    contactMap[_accountNumber] = contact.accountNumber;
    return contactMap;
  }

  Future<List<Contact>> findAll() async {
    final Database db = await getDataBase();
    final List<Map<String, dynamic>> result = await db.query('contacts');
    List<Contact> contacts = toList(result);
    return contacts;
  }

  List<Contact> toList(List<Map<String, dynamic>> result) {
    final List<Contact> contacts = [];
    for (Map<String, dynamic> row in result) {
      final Contact contact = Contact(
        row[_id],
        row[_name],
        row[_accountNumber],
      );
      contacts.add(contact);
    }
    return contacts;
  }

}