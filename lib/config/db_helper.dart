import 'package:doby_safer/enums/config_type.dart';
import 'package:doby_safer/models/config.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  var _db;

  Future<Database> get database async {
    if (_db != null) return _db;
    _db = openDatabase(join(await getDatabasesPath(), 'dobby.db'),
        onCreate: (db, version) => _onCreate(db, version), version: 1);
    return _db;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS config (
        type TEXT PRIMARY KEY,
        value DECIMAL(2,1) NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS day (
        targetDate TEXT PRIMARY KEY,
        startTime TEXT NOT NULL,
        endTime TEXT NOT NULL,
        overTimeWork INTEGER,
        holidayWorkWithinEight INTEGER,
        holidayWorkOverEight INTEGER,
        nightShift INTEGER
      );
    ''');
  }

  Future<void> insertDefaultConfig() async {
    final db = await database;

    await db.insert("config", {
      'type': ConfigType.overtimeWork.name,
      'value': 1.5
    }, conflictAlgorithm: ConflictAlgorithm.rollback);

    await db.insert("config", {
      'type': ConfigType.holidayWorkWithinEight.name,
      'value': 1.5
    }, conflictAlgorithm: ConflictAlgorithm.rollback);

    await db.insert("config", {
      'type': ConfigType.holidayWorkOverEight.name,
      'value': 2.0
    }, conflictAlgorithm: ConflictAlgorithm.rollback);

    await db.insert("config", {
      'type': ConfigType.nightShift.name,
      'value': 0.5
    }, conflictAlgorithm: ConflictAlgorithm.rollback);
  }

  Future<void> insertConfig(Config config) async {
    final db = await database;

    await db.insert("config", config.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Config>> getAllConfig() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('config');

    return List.generate(maps.length, (i) {
      return Config(
        type: parseToType(maps[i]['type']),
        value: maps[i]['value'].runtimeType == int ? maps[i]['value'].toDouble() : maps[i]['value'],
      );
    });
  }

  Future<dynamic> getConfig(ConfigType configType) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = (await db.query(
      'config',
      where: 'type = ?',
      whereArgs: [configType.name],
    ));

    return maps.isNotEmpty ? maps : null;
  }

  Future<void> updateConfig(Config config) async {
    final db = await database;

    await db.update(
      "config",
      config.toMap(),
      where: "type = ?",
      whereArgs: [config.type.name],
    );
  }

  Future<void> deleteConfig(ConfigType configType) async {
    final db = await database;

    await db.delete(
      "config",
      where: "type = ?",
      whereArgs: [configType.name],
    );
  }
}