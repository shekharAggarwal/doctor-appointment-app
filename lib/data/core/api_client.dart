import 'dart:convert';

import 'package:http/http.dart';

import 'unathorised_exception.dart';

class ApiClient {
  final Client _client;

  ApiClient(this._client);

  dynamic post(String jsonString) async {
    final response = await _client.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      body: jsonString,
      headers: {
        "Content-Type": "application/json",
        "Authorization":
            "key=AAAAZp2nx18:APA91bGU7jxNnDVbkEKfFoodM4qbHdk8CCZL83VkuvAFhLqxD-rRiW8ukw3Ye4dfmVqQkPHanCdk5npGVSEBgxaQhrsY34ooL5bFJBWAxsFHNIOh6t_flf8Q9tq2MlJmSPYC7FGnp3uH"
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic postData(String path, {Map<dynamic, dynamic>? params}) async {
    final response = await _client.post(
      Uri.parse("http://10.10.133.35:8080/demo-0.0.1$path"),
      body: jsonEncode(params),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw Exception([json.decode(response.body)["errorMessage"]]);
    }
  }
}
