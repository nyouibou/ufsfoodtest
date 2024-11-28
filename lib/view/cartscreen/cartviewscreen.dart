import 'package:flutter/material.dart';

import '../../model/foodmodel.dart';

class CartScreen extends StatelessWidget {
  final List<Meal> cart;

  const CartScreen({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        children: [
          Text(
            "Cart",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Divider(),
          Expanded(
            child: cart.isEmpty
                ? Center(child: Text("Your cart is empty"))
                : ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final meal = cart[index];
                      return ListTile(
                        leading: Image.network(
                          meal.strMealThumb!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(meal.strMeal!),
                        trailing: IconButton(
                          icon: Icon(Icons.remove_circle, color: Colors.red),
                          onPressed: () {
                            Navigator.pop(context); // Close the sheet
                          },
                        ),
                      );
                    },
                  ),
          ),
          ElevatedButton(onPressed: () {}, child: Text("Buy Now")),
        ],
      ),
    );
  }
}
