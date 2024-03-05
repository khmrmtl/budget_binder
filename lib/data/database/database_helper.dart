// database_helper.dart
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/constants.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'expense_tracker.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $kUserTable (
            id INTEGER PRIMARY KEY,
            username TEXT UNIQUE
          );
        ''');

        await db.execute('''
          CREATE TABLE $kExpensesTable (
            id INTEGER PRIMARY KEY,
            user_id INTEGER,
            amount REAL,
            description TEXT,
            category TEXT,
            date TEXT,
            FOREIGN KEY (user_id) REFERENCES users(id)
          );
        ''');

        await db.execute('''
          CREATE TABLE $kIncomeTable (
            id INTEGER PRIMARY KEY,
            user_id INTEGER,
            amount REAL,
            source TEXT,
            date TEXT,
            FOREIGN KEY (user_id) REFERENCES users(id)
          );
        ''');
      },
    );
  }

  // Add methods for user, expense, and income operations here.
}
