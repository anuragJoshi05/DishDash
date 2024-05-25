import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecipeModel {
  final String appLabel;
  final String appImgUrl;
  final double appCal;

  RecipeModel(
      {required this.appLabel, required this.appImgUrl, required this.appCal});

  factory RecipeModel.fromMap(Map<String, dynamic> map) {
    return RecipeModel(
      appLabel: map['label'],
      appImgUrl: map['image'],
      appCal: map['calories'],
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<RecipeModel> recipeList = <RecipeModel>[];
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
  ];

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
                SizedBox(
                  height: 250, // Provide a fixed height for the ListView
                  child: ListView.builder(
                    itemCount: recipeCatList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(20),
                        child: InkWell(
                          onTap: () {},
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 0.00,

                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    recipeCatList[index]["imgUrl"],
                                    fit: BoxFit.cover,
                                    width: 200,
                                    height: 250,
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  top: 0,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    decoration: const BoxDecoration(
                                        color: Colors.black26),
                                    child: Center(
                                      child: Text(
                                        recipeCatList[index]["heading"],
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 28),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
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
