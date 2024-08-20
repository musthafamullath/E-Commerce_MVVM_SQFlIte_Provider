import 'dart:developer';
import 'package:mt_of_wac/models/banner_slider_model.dart';
import 'package:mt_of_wac/models/banner_single_model.dart';
import 'package:mt_of_wac/models/categories_model.dart';
import 'package:mt_of_wac/models/products_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');

    return openDatabase(
      path,
      version: 2,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE banners (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          image_path TEXT
        )
      ''');
        db.execute('''
        CREATE TABLE single_banners (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          image_path TEXT
        )
      ''');
        db.execute('''
        CREATE TABLE products (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          sku TEXT,
          product_name TEXT,
          product_image TEXT,
          product_rating INTEGER,
          actual_price TEXT,
          offer_price TEXT,
          discount TEXT,
          product_type TEXT
        )
      ''');
        db.execute('''
        CREATE TABLE categories (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          image_path TEXT
        )
      ''');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < 2) {
          db.execute('''
          ALTER TABLE products
          ADD COLUMN product_type TEXT
        ''');
        }
      },
    );
  }

  Future<void> insertBanner(BannerSliderModel banner, String imagePath) async {
    final db = await database;
    await db.insert(
      'banners',
      {
        'title': banner.title,
        'image_path': imagePath,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertSingleBanner(
      BannerSingleModel singleBanner, String imagePath) async {
    log('Image Path Single: $imagePath');
    final db = await database;
    await db.insert(
      'single_banners',
      {
        'title': singleBanner.title,
        'image_path': imagePath,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertProduct(
      ProductsModel product, String productType, String imagePath) async {
    final db = await database;
    await db.insert(
      'products',
      {
        ...product.toJson(),
        'product_type': productType,
        'product_image': imagePath,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertCategory(CategoriesModel category, String imagePath) async {
    final db = await database;
    await db.insert(
      'categories',
      {
        'title': category.title,
        'image_path': imagePath,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<BannerSliderModel>> getBanners() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('banners');
    return List.generate(maps.length, (i) {
      return BannerSliderModel.fromJson(maps[i]);
    });
  }

  Future<List<BannerSingleModel>> getSingleBanners() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('single_banners');
    return List.generate(maps.length, (i) {
      return BannerSingleModel.fromJson(maps[i]);
    });
  }

  Future<List<ProductsModel>> getProducts(String productType) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: 'product_type = ?',
      whereArgs: [productType],
    );
    return List.generate(maps.length, (i) {
      return ProductsModel.fromJson(maps[i]);
    });
  }

  Future<List<CategoriesModel>> getCategories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('categories');
    return List.generate(maps.length, (i) {
      return CategoriesModel.fromJson(maps[i]);
    });
  }

  Future<void> clearAllData() async {
    final db = await database;
    await db.delete('banners');
    await db.delete('single_banners');
    await db.delete('products');
  }
}
