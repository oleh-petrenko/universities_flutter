import 'dart:convert';
import 'package:http/http.dart' as http;

enum HttpMethod {
  get,
  post,
  put,
  delete,
}

class HttpService {
  final String baseUrl;

  HttpService({required this.baseUrl});

  Future<dynamic> request({
    required String endpoint,
    required HttpMethod method,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    dynamic body,
  }) async {
    final url = Uri(
      scheme: 'http',
      host: baseUrl,
      path: endpoint,
      queryParameters: queryParams,
    );
    http.Response response;

    switch (method) {
      case HttpMethod.get:
        response = await http.get(url, headers: headers);
        break;
      case HttpMethod.post:
        response = await http.post(url, headers: headers, body: jsonEncode(body));
        break;
      case HttpMethod.put:
        response = await http.put(url, headers: headers, body: jsonEncode(body));
        break;
      case HttpMethod.delete:
        response = await http.delete(url, headers: headers);
        break;
      default:
        throw Exception('HTTP Method not supported');
    }

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body);
    } else {
      throw Exception('Failed with status code: ${response.statusCode}');
    }
  }
}
