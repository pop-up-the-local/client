import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:pop_up_the_local/models/member_detail_model.dart';

Future<dynamic> getMemberDetail(String memberId) async {
  String? baseUrl = dotenv.env['BASE_URL'];

  final response = await http.get(Uri.parse('$baseUrl/api/members'));
  if (response.statusCode == 200) {
    final Map<String, dynamic> data =
        jsonDecode(utf8.decode(response.bodyBytes));
    return MemberDetail.fromJson(data);
  } else {
    throw Exception('Failed to load member detail');
  }
}
