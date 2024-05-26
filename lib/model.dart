class RecipeModel {
  late String appLabel;
  late String appImgUrl;
  late double appCal;
  late String appUrl;

  RecipeModel(
      {this.appLabel = "app",
        this.appImgUrl = "img",
        this.appCal = 0.000,
        this.appUrl = "url"});

  factory RecipeModel.fromMap(Map recipe){
    return RecipeModel(
      appUrl: recipe["url"],
      appLabel: recipe["label"],
      appCal: recipe["calories"],
      appImgUrl: recipe["image"],
    );
  }
}
