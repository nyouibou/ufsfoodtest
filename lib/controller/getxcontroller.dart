import 'package:get/get.dart';
import '../model/categorymodel.dart';
import '../model/foodmodel.dart';
import '../controller/apicontroller.dart';

class HomeController extends GetxController {
  final ApiService apiService = ApiService();

  // Reactive variables
  var categories = <Category>[].obs;
  var selectedCategory = ''.obs;
  var meals = <Meal>[].obs;
  var cart = <Meal>[].obs;

  // Fetch categories
  void fetchCategories() async {
    try {
      final response = await apiService.fetchCategories();
      categories.value = response.categories!;
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch categories: $e");
    }
  }

  // Fetch meals based on selected category
  void fetchMeals(String category) async {
    try {
      final response = await apiService.fetchMeals(category);
      selectedCategory.value = category;
      meals.value = response.meals!;
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch meals: $e");
    }
  }

  // Add a meal to the cart
  void addToCart(Meal meal) {
    if (!cart.contains(meal)) {
      cart.add(meal);
    }
  }

  // Remove a meal from the cart
  void removeFromCart(Meal meal) {
    cart.remove(meal);
  }
}
