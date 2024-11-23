import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // FFI untuk Desktop
import 'package:flutter/foundation.dart'; // Untuk kIsWeb
import 'package:path_provider/path_provider.dart'; // Untuk mendapatkan direktori aplikasi

class DatabaseHelper {
  static const _databaseName = "my_database.db";
  static const _databaseVersion = 1;

  // Singleton DatabaseHelper
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  // Gunakan databaseFactory secara dinamis sesuai platform
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  // Inisialisasi Database sesuai platform
  Future<Database> _initDB() async {
    if (Platform.isWindows || Platform.isLinux) {
      // Desktop (Windows/Linux/Mac) menggunakan sqflite_common_ffi
      sqfliteFfiInit();
      final databaseFactory = databaseFactoryFfi;
      final appDocumentsDir = await getApplicationDocumentsDirectory();
      final dbPath = join(appDocumentsDir.path, "databases", _databaseName);
      final winLinuxDB = await databaseFactory.openDatabase(
        dbPath,
        options: OpenDatabaseOptions(
          version: _databaseVersion,
          onCreate: _onCreate,
        ),
      );
      return winLinuxDB;
    } else if (Platform.isAndroid || Platform.isIOS) {
      // Android/iOS menggunakan sqflite biasa
      final documentsDirectory = await getApplicationDocumentsDirectory();
      final path = join(documentsDirectory.path, _databaseName);
      final iOSAndroidDB = await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate,
      );
      return iOSAndroidDB;
    } else {
      throw Exception("Unsupported platform");
    }
  }

  // Fungsi untuk membuat tabel
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        email TEXT NOT NULL,
        password TEXT NOT NULL,
        username TEXT NOT NULL
      )
    ''');
  }

  // Mendapatkan pengguna berdasarkan email dan password
  Future<Map<String, dynamic>?> getUser(String email, String password) async {
    Database db = await instance.database;

    // Ambil hanya satu pengguna dengan LIMIT 1
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
      limit: 1, // Batasi hasil menjadi satu baris
    );

    if (result.isEmpty) {
      return null; // Kembalikan null jika tidak ditemukan
    }
    return result.first; // Ambil baris pertama
  }

  // Menyisipkan banyak pengguna ke database
  Future<void> insertUsers(List<Map<String, dynamic>> users) async {
    Database db = await instance.database;
    final batch = db.batch();
    for (var user in users) {
      batch.insert('users', user);
    }
    await batch.commit();
  }
}


