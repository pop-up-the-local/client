import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:pop_up_the_local/models/pop_up_model.dart';

class PopUpListService {
  String? apiUrl = dotenv
      .env['BASE_URL']; // Make sure this is correctly set in your .env file

  Future<dynamic> fetchPopUps() async {
    try {
      var response = await http.get(Uri.parse('$apiUrl/api/popups/list'));
      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes))['data'];
        print(data);
        return data.map((e) => PopUpModel.fromJson(e)).toList();
      } else {
        print('Failed to load popups from the server');
        return [];
      }
    } catch (e) {
      print('Error occurred while fetching data: $e');
      return [];
    }
  }
}
