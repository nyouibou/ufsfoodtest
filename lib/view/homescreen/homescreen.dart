// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../controller/getxcontroller.dart';
// import '../cartscreen/cartscreen.dart';

// class HomeScreeen extends StatelessWidget {
//   final HomeController controller = Get.put(HomeController());

//   HomeScreeen() {
//     // Fetch categories when the screen loads
//     controller.fetchCategories();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("FoodyGo"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.shopping_bag),
//             onPressed: () {
//               showModalBottomSheet(
//                 context: context,
//                 builder: (_) => CartScreeen(),
//               );
//             },
//           )
//         ],
//       ),
//       body: Column(
//         children: [
//           // Dropdown for categories
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Obx(
//               () {
//                 if (controller.categories.isEmpty) {
//                   return Center(child: CircularProgressIndicator());
//                 }

//                 return DropdownButtonFormField<String>(
//                   decoration: InputDecoration(
//                     labelText: "Select a Category",
//                     border: OutlineInputBorder(),
//                   ),
//                   value: controller.selectedCategory.value.isEmpty
//                       ? null
//                       : controller.selectedCategory.value,
//                   items: controller.categories
//                       .map(
//                         (category) => DropdownMenuItem<String>(
//                           value: category.strCategory,
//                           child: Text(category.strCategory!),
//                         ),
//                       )
//                       .toList(),
//                   onChanged: (value) {
//                     if (value != null) {
//                       controller.fetchMeals(value);
//                     }
//                   },
//                 );
//               },
//             ),
//           ),

//           // Meals grid
//           Expanded(
//             child: Obx(
//               () {
//                 if (controller.meals.isEmpty) {
//                   return Center(child: Text("No meals found"));
//                 }

//                 return GridView.builder(
//                   padding: EdgeInsets.all(8.0),
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 3 / 4,
//                   ),
//                   itemCount: controller.meals.length,
//                   itemBuilder: (context, index) {
//                     final meal = controller.meals[index];
//                     final isInCart = controller.cart.contains(meal);

//                     return Card(
//                       child: Column(
//                         children: [
//                           Image.network(
//                             meal.strMealThumb!,
//                             height: 200,
//                             width: double.infinity,
//                             fit: BoxFit.cover,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               meal.strMeal!,
//                               textAlign: TextAlign.center,
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                           ElevatedButton(
//                             onPressed: () {
//                               if (isInCart) {
//                                 controller.removeFromCart(meal);
//                               } else {
//                                 controller.addToCart(meal);
//                               }
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor:
//                                   isInCart ? Colors.red : Colors.green,
//                             ),
//                             child: Text(isInCart ? "Remove" : "Add to Cart"),
//                           )
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/getxcontroller.dart';
import '../cartscreen/cartscreen.dart';

class HomeScreeen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  HomeScreeen() {
    // Fetch categories when the screen loads
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
          // Dropdown for categories
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
                    border: OutlineInputBorder(),
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

          // Meals grid
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
                            child: Text(isInCart ? "Remove" : "Add to Cart"),
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
