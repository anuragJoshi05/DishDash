import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class RecipeView extends StatefulWidget {
  final String url;

  RecipeView(this.url);

  @override
  _RecipeViewState createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  late String finalUrl;
  @override
  void initState() {
    if (widget.url.toString().contains("http://")) {
      finalUrl = widget.url.toString().replaceAll("http://", "https://");
    } else {
      finalUrl = widget.url;
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    // Create a WebUri object using the constructor
    WebUri webUri = WebUri(finalUrl);

    return Scaffold(
      appBar: AppBar(
        title: Text("DishDash"),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: webUri),
      ),
    );
  }
}
