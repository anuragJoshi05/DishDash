import 'dart:convert';
import 'package:dishdash/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// Keep 'package:flutter/cupertino.dart'; if you need Cupertino widgets

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchController = TextEditingController();
  String url =
      "https://api.edamam.com/search?q=peanutbutter&app_id=55af708b&app_key=da796bcdc6572ed166fdd80db8989449&from=0&to=3&calories=591-722&health=alcohol-free";
  Future<void> getRecipe(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=55af708b&app_key=da796bcdc6572ed166fdd80db8989449&from=0&to=3&calories=591-722&health=alcohol-free";
    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> data = jsonDecode(response.body);
    data["hits"].forEach((element) {
      RecipeModel recipeMod = RecipeModel();
      recipeMod = RecipeModel.fromMap(element["recipe"]);
      recipeList.add(recipeMod);
    });
    for (var recipe in recipeList) {
      print(recipe.appLabel);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecipe("chocolate");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purple,
                  Colors.pink,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    margin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if ((searchController.text).replaceAll(" ", "") ==
                                "") {
                              print("no value");
                            } else {
                              getRecipe(searchController.text);
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                            child: Icon(
                              Icons.search,
                              color: Colors.lightBlue.shade300,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            onSubmitted: (value) {
                              if (value.trim().isNotEmpty) {
                                getRecipe(value.trim());
                              }
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Yummy Search!!!",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "WHAT DO YOU WANT TO COOK TODAY?",
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Let's cook something new",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 1000,
                    itemBuilder: (context, index) {
                      return const Text("This is my widget");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
