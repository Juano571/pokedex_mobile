//import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:pokedex_mobile/dtos/category_model.dart';
//import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
//patron de diseño singleton
class CategoryDatabase {
  static final CategoryDatabase instance = CategoryDatabase._init();

  static Database? _database;

  CategoryDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('pokedex.db'); // crear la base de datos;
    return _database!;
  }

  _initDB(String file) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath,file);
    return await openDatabase(path,version: 1, onCreate: _createDB);
  }
  
  Future _createDB(Database db,int version)async{
    
    await db.execute('''
      CREATE TABLE $tableCategory (
        ${CategoryField.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${CategoryField.name} TEXT NOT NULL,
        ${CategoryField.image} TEXT NOT NULL
      )
    ''');
  }

  Future<void> create(CategoryModel category)async{
    final db= await instance.database;
// ler pamaetro - > nombre de la tabla
// 2 parametro -> Map donde el key —> columna, value = valor
//CategoryModel(1, nombrel, imagel)
// [idl =1, [namel = nombrel, [imagel = imagel
    await db.insert(tableCategory, category.toJson());
  }

  Future<List<CategoryModel>> readAllCategories()async{
    final db = await instance.database;
    final results=await db.query(tableCategory);
    //list ->
    //        Map([id 1, name: Nombre, image: Image 1])
    //        Map([id 2, name: Nombre, image: Image 2])
    //List(objet01) -> List(objet02)
    //List( integers) -> List(string)
    return results.map((mapCategories) => CategoryModel.fromJson(mapCategories)).toList();
  }

  Future<void> delete(int id)async{
    final db=await instance.database;
    await db.delete(tableCategory,where: '${CategoryField.id} = ?',
    whereArgs: [id]);
  }


  Future<void> close() async {
    final db=await instance.database;
    db.close();
  }

}
