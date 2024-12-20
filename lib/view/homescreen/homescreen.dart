// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/getxcontroller.dart';
import '../cartscreen/cartscreen.dart';

class HomeScreeen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  HomeScreeen() {
    controller.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FoodyGo"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_bag),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => CartScreeen(),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(
              () {
                if (controller.categories.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }

                return DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Select a Category",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  value: controller.selectedCategory.value.isEmpty
                      ? null
                      : controller.selectedCategory.value,
                  items: controller.categories
                      .map(
                        (category) => DropdownMenuItem<String>(
                          value: category.strCategory,
                          child: Text(category.strCategory!),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.fetchMeals(value);
                    }
                  },
                );
              },
            ),
          ),
          Expanded(
            child: Obx(
              () {
                if (controller.meals.isEmpty) {
                  return Center(child: Text("No meals found"));
                }

                return GridView.builder(
                  padding: EdgeInsets.all(8.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 4,
                  ),
                  itemCount: controller.meals.length,
                  itemBuilder: (context, index) {
                    final meal = controller.meals[index];
                    final isInCart = controller.cart.contains(meal);

                    return Card(
                      child: Column(
                        children: [
                          Image.network(
                            meal.strMealThumb!,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              meal.strMeal!,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (isInCart) {
                                controller.removeFromCart(meal);
                                Get.snackbar(
                                  "Removed from Cart",
                                  "${meal.strMeal} has been removed from your cart.",
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              } else {
                                controller.addToCart(meal);
                                Get.snackbar(
                                  "Added to Cart",
                                  "${meal.strMeal} has been added to your cart.",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor:
                                      const Color.fromARGB(255, 0, 0, 0),
                                  colorText: Colors.white,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  isInCart ? Colors.red : Colors.green,
                            ),
                            child: Text(
                              isInCart ? "Remove" : "Add to Cart",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
