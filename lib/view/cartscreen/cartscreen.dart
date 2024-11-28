// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/getxcontroller.dart';

class CartScreeen extends StatelessWidget {
  final HomeController controller = Get.find();

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
            child: Obx(
              () {
                if (controller.cart.isEmpty) {
                  return Center(child: Text("Your cart is empty"));
                }

                return ListView.builder(
                  itemCount: controller.cart.length,
                  itemBuilder: (context, index) {
                    final meal = controller.cart[index];
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
                          controller.removeFromCart(meal);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
