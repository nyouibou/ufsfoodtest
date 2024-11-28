import 'package:flutter/material.dart';

import '../../controller/apicontroller.dart';
import '../../model/categorymodel.dart';
import '../../model/foodmodel.dart';
import '../cartscreen/cartviewscreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  late Future<CategoryModel> categoriesFuture;
  String? selectedCategory;
  List<Meal> meals = [];
  List<Meal> cart = [];

  @override
  void initState() {
    super.initState();
    categoriesFuture = apiService.fetchCategories();
  }

  void fetchMeals(String category) async {
    final mealsResponse = await apiService.fetchMeals(category);
    setState(() {
      selectedCategory = category;
      meals = mealsResponse.meals!;
    });
  }

  void addToCart(Meal meal) {
    setState(() {
      if (!cart.contains(meal)) {
        cart.add(meal);
      }
    });
  }

  void removeFromCart(Meal meal) {
    setState(() {
      cart.remove(meal);
    });
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
                builder: (_) => CartScreen(cart: cart),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          FutureBuilder<CategoryModel>(
            future: categoriesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData ||
                  snapshot.data!.categories!.isEmpty) {
                return Center(child: Text("No categories found"));
              } else {
                final categories = snapshot.data!.categories!;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "Select a Category",
                      border: OutlineInputBorder(),
                    ),
                    value: selectedCategory,
                    items: categories
                        .map((category) => DropdownMenuItem<String>(
                              value: category.strCategory,
                              child: Text(category.strCategory!),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        fetchMeals(value);
                      }
                    },
                  ),
                );
              }
            },
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
              ),
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                final isInCart = cart.contains(meal);
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
                            removeFromCart(meal);
                          } else {
                            addToCart(meal);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isInCart ? Colors.red : Colors.green,
                        ),
                        child: Text(isInCart ? "Remove" : "Add to Cart"),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
