import 'package:get/get.dart';
import '../model/categorymodel.dart';
import '../model/foodmodel.dart';
import '../controller/apicontroller.dart';

class HomeController extends GetxController {
  final ApiService apiService = ApiService();

  var categories = <Category>[].obs;
  var selectedCategory = ''.obs;
  var meals = <Meal>[].obs;
  var cart = <Meal>[].obs;

  void fetchCategories() async {
    try {
      final response = await apiService.fetchCategories();
      categories.value = response.categories!;
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch categories: $e");
    }
  }

  void fetchMeals(String category) async {
    try {
      final response = await apiService.fetchMeals(category);
      selectedCategory.value = category;
      meals.value = response.meals!;
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch meals: $e");
    }
  }

  void addToCart(Meal meal) {
    if (!cart.contains(meal)) {
      cart.add(meal);
    }
  }

  void removeFromCart(Meal meal) {
    cart.remove(meal);
  }
}
