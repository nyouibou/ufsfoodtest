import 'package:http/http.dart' as http;

import '../model/categorymodel.dart';
import '../model/foodmodel.dart';

class ApiService {
  static const String baseUrl = "https://www.themealdb.com/api/json/v1/1/";

  // Fetch Categories
  Future<CategoryModel> fetchCategories() async {
    final response = await http.get(Uri.parse("${baseUrl}categories.php"));
    if (response.statusCode == 200) {
      return sampleApiRespFromJson(response.body);
    } else {
      throw Exception("Failed to load categories");
    }
  }

  // Fetch Meals by Category
  Future<MealModel> fetchMeals(String categoryName) async {
    final response =
        await http.get(Uri.parse("${baseUrl}filter.php?c=$categoryName"));
    if (response.statusCode == 200) {
      return sampleFoodApiRespFromJson(response.body);
    } else {
      throw Exception("Failed to load meals");
    }
  }
}
