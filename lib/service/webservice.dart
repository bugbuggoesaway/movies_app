import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Resource<T> {
  final String url;
  T Function(Response response) parse;

  Resource({required this.url, required this.parse});
}

class WebService {
  Future<T> load<T>(Resource<T> resource) async {
    final Response response = await http.get(Uri.parse(resource.url), headers: {
      "Content-Type": "application/json;charset=utf-8",
    });
    if (response.statusCode == 200) {
      return resource.parse(response);
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
