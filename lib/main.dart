import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'splash_screen.dart';
import 'home.dart';
import 'recipe_controller.dart';

void main() {
  Get.put(RecipeController()); // Initialize the controller
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'DishDash',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Pacifico',
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/home', page: () => Home()),
      ],
    );
  }
}
