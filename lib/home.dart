import 'dart:convert';
import 'package:dishdash/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchController = TextEditingController();

  Future<void> getRecipe(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=55af708b&app_key=da796bcdc6572ed166fdd80db8989449&from=0&to=10&calories=591-722&health=alcohol-free";
    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> data = jsonDecode(response.body);
    recipeList.clear(); // Clear the list before adding new items
    data["hits"].forEach((element) {
      RecipeModel recipeMod = RecipeModel.fromMap(element["recipe"]);
      recipeList.add(recipeMod);
    });
    for (var recipe in recipeList) {
      print(recipe.appLabel);
      print(recipe.appImgUrl); // Print image URLs to verify
    }
    setState(() {}); // To refresh the UI with new data
  }

  @override
  void initState() {
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
                    margin: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 20),
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
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "WHAT DO YOU WANT TO COOK TODAY?",
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Let's cook something new",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recipeList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0.00,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                recipeList[index].appImgUrl,
                                fit: BoxFit
                                    .cover, // Ensures the image covers the entire area
                                width: double.infinity,
                                height:
                                    200.0, // You can adjust the height as needed
                              ),
                            ),
                            Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    decoration: const BoxDecoration(
                                      color: Colors.black26,
                                    ),
                                    child: Text(
                                      recipeList[index].appLabel,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ))),
                            Positioned(
                                right: 0,
                                height: 40,
                                width: 80,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.greenAccent,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.local_fire_department),
                                        Text(
                                          recipeList[index]
                                              .appCal
                                              .toStringAsFixed(0),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                // Add other widget elements for your card here if needed
                                ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
