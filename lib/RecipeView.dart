import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'webview_controller.dart';

class RecipeView extends StatelessWidget {
  final String url;

  RecipeView(this.url);

  @override
  Widget build(BuildContext context) {
    final WebViewController controller = Get.put(WebViewController());
    controller.setUrl(url);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "DishDash",
          style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 2.0,
        backgroundColor: Colors.deepPurple,
      ),
      body: Obx(() {
        WebUri webUri = WebUri(controller.url.value);
        return InAppWebView(
          initialUrlRequest: URLRequest(url: webUri),
        );
      }),
    );
  }
}
