import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'recipe_controller.dart';
import 'RecipeView.dart';

class Search extends StatefulWidget {
  final String query;
  const Search(this.query, {Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final RecipeController controller = Get.put(RecipeController());

  @override
  void initState() {
    super.initState();
    controller.getRecipe(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DishDash"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.grey[900]!,
                  Colors.grey[800]!,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (controller.searchController.text.trim().isNotEmpty) {
                                controller.getRecipe(controller.searchController.text);
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                              child: Icon(
                                Icons.search,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: controller.searchController,
                              style: TextStyle(color: Colors.black87),
                              onSubmitted: (value) {
                                if (value.trim().isNotEmpty) {
                                  controller.getRecipe(value.trim());
                                }
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search for recipes...",
                                hintStyle: TextStyle(color: Colors.grey),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    // Add your action here
                                  },
                                  icon: Icon(
                                    Icons.favorite_border,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Obx(() {
                  if (controller.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.recipeList.length,
                      itemBuilder: (context, index) {
                        final recipe = controller.recipeList[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => RecipeView(recipe.appUrl));
                          },
                          child: Card(
                            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: [
                                  Image.network(
                                    recipe.appImgUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 200.0,
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: Colors.black45,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: Text(
                                        recipe.appLabel,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 10,
                                    top: 10,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.deepPurpleAccent,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                      child: Row(
                                        children: [
                                          Icon(Icons.local_fire_department, color: Colors.white),
                                          SizedBox(width: 5),
                                          Text(
                                            recipe.appCal.toStringAsFixed(0),
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
