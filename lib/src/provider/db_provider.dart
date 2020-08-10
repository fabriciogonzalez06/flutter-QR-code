import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:qrreadapp/src/models/scan_model.dart';
export 'package:qrreadapp/src/models/scan_model.dart';

class DbProvider {
  static Database _database;
  //constructor privado
  static final DbProvider db = DbProvider._();

  //este es el contructor privado
  DbProvider._();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDB();
      return _database;
    }
  }

  Future<Database> initDB() async {
    //path de la base datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Scans ('
          ' id INTEGER PRIMARY KEY,'
          ' tipo TEXT,'
          ' valor TEXT'
          ')');
    });
  }

  //Crear registros
  nuevoScanRaw(ScanModel nuevoScan) async {
    final db = await database;
    //devulve int de filas afectadas
    final res = await db.rawInsert("INSERT INTO scans(id,tipo,valor) "
        "VALUES ( ${nuevoScan.id}, '${nuevoScan.tipo}', '${nuevoScan.valor}')");

    return res;
  }

  nuevoScan(ScanModel nuevoScan) async {
    final db = await database;

    final res = await db.insert('Scans', nuevoScan.toJson());
    return res;
  }

  //Select - obtener informacion
  Future<ScanModel> getScanId(int id) async {
    final db = await this.database;

    //retorna un listado de mapas
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getTodosScans() async {
    final db = await database;
    final res = await db.query('Scans');

    List<ScanModel> list = res.isNotEmpty
        ? res.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];

    return list;
  }

  Future<List<ScanModel>> getScansPorTipo(String tipo) async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Scans WHERE tipo='$tipo'");

    List<ScanModel> list = res.isNotEmpty
        ? res.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];

    return list;
  }

  //actualizar
  Future<int> updateScan(ScanModel scan) async {
    final db = await this.database;
    final res =
        db.update('Scans', scan.toJson(), where: 'id= ?', whereArgs: [scan.id]);
    return res;
  }

  //eliminar registros
  Future<int> deleteScan(int id) async {
    final db = await this.database;
    final res = await db.delete('Scans', where: 'id= ?', whereArgs: [id]);
    return res;
  }

  //eliminar registros
  Future<int> deleteAll() async {
    final db = await this.database;
    final res = await db.rawDelete('DELETE FROM Scans');
    return res;
  }
}
