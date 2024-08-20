import 'package:flutter/foundation.dart';

import 'package:mt_of_wac/models/banner_single_model.dart';
import 'package:mt_of_wac/models/banner_slider_model.dart';
import 'package:mt_of_wac/models/categories_model.dart';
import 'package:mt_of_wac/models/products_model.dart';
import 'package:mt_of_wac/services/api_service.dart';
import 'package:mt_of_wac/services/database_helper.dart';
import 'package:mt_of_wac/services/imagesecurity.dart';

class DataViewModel extends ChangeNotifier {


  final ApiService _apiService = ApiService();
  final DatabaseHelper _dbHelper = DatabaseHelper();



  List<BannerSliderModel> _banners = [];
  List<BannerSingleModel> _singleBanners = [];
  List<ProductsModel> _popularProducts = [];
  List<ProductsModel> _featuredProducts = [];
  List<CategoriesModel> _categories = [];



  List<BannerSliderModel> get banners => _banners;
  List<BannerSingleModel> get singleBanners => _singleBanners;
  List<ProductsModel> get popularProducts => _popularProducts;
  List<ProductsModel> get featuredProducts => _featuredProducts;
  List<CategoriesModel> get categories => _categories;



  DataViewModel() {
    _initialize();
  }

  Future<void> _initialize() async {
    await _fetchDataFromApi();
    await _saveDataToDatabase();
    await _loadDataFromDatabase();
    notifyListeners();
  }




//**************************************************************************************//
  Future<void> _fetchDataFromApi() async {
    try {
      final data = await _apiService.fetchData();

      _categories = _parseData<CategoriesModel>(data, 'catagories', 'contents');
      _banners = _parseData<BannerSliderModel>(data, 'banner_slider', 'contents');
      _singleBanners = _parseSingleBannerData(data);

      _featuredProducts = _parseProductData(data, 'Best Sellers');
      _popularProducts = _parseProductData(data, 'Most Popular');

      await _dbHelper.clearAllData();
    } catch (e) {
      debugPrint('Error fetching data from API: $e');
    }
  }

  List<T> _parseData<T>(List<dynamic> data, String type, String key) {
    return data
        .where((item) => item['type'] == type)
        .expand(
            (item) => (item[key] as List<dynamic>).map((p) => _fromJson<T>(p)))
        .toList();
  }

  List<BannerSingleModel> _parseSingleBannerData(List<dynamic> data) {
    return data
        .where((item) => item['type'] == 'banner_single')
        .map((item) => BannerSingleModel.fromJson(item))
        .toList();
  }

  List<ProductsModel> _parseProductData(List<dynamic> data, String title) {
    return data
        .where((item) => item['type'] == 'products' && item['title'] == title)
        .expand((item) => (item['contents'] as List<dynamic>)
            .map((p) => ProductsModel.fromJson({
                  ...p as Map<String, dynamic>,
                  'title': title,
                })))
        .toList();
  }

  T _fromJson<T>(dynamic json) {
    if (T == BannerSliderModel) {
      return BannerSliderModel.fromJson(json) as T;
    } else if (T == CategoriesModel) {
      return CategoriesModel.fromJson(json) as T;
    } else {
      throw UnsupportedError('Unsupported model type');
    }
  }

  Future<void> _saveDataToDatabase() async {
    try {
      await Future.wait([
        _saveBannersToDb(),
        _saveSingleBannersToDb(),
        _saveProductsToDb(_popularProducts, 'Most Popular'),
        _saveProductsToDb(_featuredProducts, 'Best Sellers'),
        _saveCategoriesToDb(),
      ]);
      debugPrint("Data saved to database");
    } catch (e) {
      debugPrint('Error saving data to database: $e');
    }
  }

  Future<void> _saveBannersToDb() async {
    for (var banner in _banners) {
      final imagePath =
          await _saveImage(banner.imageUrl, 'banner_${banner.title}.png');
          if (imagePath.isNotEmpty) {
      await _dbHelper.insertBanner(banner, imagePath);
    } else {
      debugPrint('Image path is empty for banner: ${banner.title}');
    }
    }
  }




//****************************************************************************//
  Future<void> _saveSingleBannersToDb() async {
    for (var singleBanner in _singleBanners) {
      final imagePath = await _saveImage(
          singleBanner.imageUrl, 'single_banner_${singleBanner.title}.png');
      await _dbHelper.insertSingleBanner(singleBanner, imagePath);
    }
  }

  Future<void> _saveProductsToDb(
      List<ProductsModel> products, String type) async {
    for (var product in products) {
      final imagePath = await _saveImage(
          product.productImage, '${type.toLowerCase()}_${product.sku}.png');
      await _dbHelper.insertProduct(product, type, imagePath);
    }
  }

  Future<void> _saveCategoriesToDb() async {
    for (var category in _categories) {
      final imagePath =
          await _saveImage(category.imageUrl, 'category_${category.title}.png');
      await _dbHelper.insertCategory(category, imagePath);
    }
  }

  Future<String> _saveImage(String imageUrl, String fileName) async {
    try {
      return await saveImageToFileSystem(imageUrl, fileName);
    } catch (e) {
      debugPrint('Error saving image: $e');
      return '';
    }
  }




//**********************************************************************//
  Future<void> _loadDataFromDatabase() async {
    try {
      debugPrint('Loading data from database...');
      await Future.wait([
        _loadBannersFromDb(),
        _loadSingleBannersFromDb(),
        _loadProductsFromDb('Most Popular'),
        _loadProductsFromDb('Best Sellers'),
        _loadCategoriesFromDb(),
      ]);
    } catch (e) {
      debugPrint('Error loading data from database: $e');
    }
  }

  Future<void> _loadBannersFromDb() async {
    _banners = await _dbHelper.getBanners();
    notifyListeners();
  }

  Future<void> _loadSingleBannersFromDb() async {
    _singleBanners = await _dbHelper.getSingleBanners();
    notifyListeners();
  }

  Future<void> _loadProductsFromDb(String productType) async {
    if (productType == 'Most Popular') {
      _popularProducts = await _dbHelper.getProducts(productType);
    } else if (productType == 'Best Sellers') {
      _featuredProducts = await _dbHelper.getProducts(productType);
    }
    notifyListeners();
  }

  Future<void> _loadCategoriesFromDb() async {
    _categories = await _dbHelper.getCategories();
    notifyListeners();
  }
}
