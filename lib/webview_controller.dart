import 'package:get/get.dart';

class WebViewController extends GetxController {
  var url = ''.obs;

  void setUrl(String newUrl) {
    if (newUrl.contains("http://")) {
      url.value = newUrl.replaceAll("http://", "https://");
    } else {
      url.value = newUrl;
    }
  }
}
