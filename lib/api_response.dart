import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class ApiResponse {
  String? answer;
  bool? forced;
  String? image;

  ApiResponse({
    this.answer,
    this.forced,
    this.image,
  });
}

class ApiResponseProvider {
  Future<ApiResponse> getAnswer() async {
    final response = await http.get(Uri.parse('https://yesno.wtf/api'));

    return ApiResponse(
      answer: convert.jsonDecode(response.body)['answer'],
      forced: convert.jsonDecode(response.body)['forced'],
      image: convert.jsonDecode(response.body)['image'],
    );
  }
}
