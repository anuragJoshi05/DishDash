import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RecipeController extends GetxController {
  var isLoading = true.obs;
  var recipeList = <RecipeModel>[].obs;
  TextEditingController searchController = TextEditingController();

  List recipeCatList = [
    {
      "imgUrl":
      "https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c3BpY3klMjBmb29kfGVufDB8fDB8fHww",
      "heading": "Chilli Food"
    },
    {
      "imgUrl":
      "https://images.unsplash.com/photo-1541599188778-cdc73298e8fd?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fGRlc3NlcnR8ZW58MHx8MHx8fDA%3D",
      "heading": "Deserts"
    },
    {
      "imgUrl":
      "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "heading": "Diet Food"
    },
    {
      "imgUrl":
      "https://cdn.pixabay.com/photo/2020/03/21/04/00/shrimp-4952607_1280.jpg",
      "heading": "Sea Food"
    },
    {
      "imgUrl":
      "https://media.istockphoto.com/id/184946701/photo/pizza.jpg?s=612x612&w=0&k=20&c=97rc0VIi-s3mn4xe4xDy9S-XJ_Ohbn92XaEMaiID_eY=",
      "heading": "Pizza"
    },
    {
      "imgUrl":
      "https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8dmVnYW4lMjBmb29kfGVufDB8fDB8fHww",
      "heading": "Vegan"
    },
    {
      "imgUrl":
      "https://images.unsplash.com/photo-1546069901-eacef0df6022",
      "heading": "Breakfast"
    },
    {
      "imgUrl":
      "https://images.unsplash.com/photo-1552332386-f8dd00dc2f85?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8c291cCUyMGZvb2R8ZW58MHx8MHx8fDA%3D",
      "heading": "Soup"
    },
    {
      "imgUrl":
      "https://images.unsplash.com/photo-1556817411-31ae72fa3ea0",
      "heading": "Salad"
    },
    {
      "imgUrl":
      "https://images.unsplash.com/photo-1498654896293-37aacf113fd9",
      "heading": "Appetizers"
    },
  ];

  Future<void> getRecipe(String query) async {
    isLoading(true);
    String url =
        "https://api.edamam.com/search?q=$query&app_id=55af708b&app_key=da796bcdc6572ed166fdd80db8989449&from=0&to=10&calories=591-722&health=alcohol-free";
    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> data = jsonDecode(response.body);
    recipeList.clear();
    data["hits"].forEach((element) {
      RecipeModel recipeMod = RecipeModel.fromMap(element["recipe"]);
      recipeList.add(recipeMod);
    });
    isLoading(false);
  }

  Future<void> loadData() async {
    // newly added: Method to load initial data
    await getRecipe("Pasta"); // newly added
  }

  @override
  void onInit() {
    super.onInit();
    loadData(); // newly added: Initialize data loading on controller initialization
  }
}
