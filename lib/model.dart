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
      appLabel: recipe["label"],
      appCal: recipe["calories"],
      appImgUrl: recipe["image"],
      appUrl: recipe["url"],
    );
  }
}
