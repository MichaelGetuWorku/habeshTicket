import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/model/login.dart';
import 'package:login/utils/const.dart';

Future<Login> loginApi(firebaseIdToken) async {
  var map = <String, dynamic>{};
  map['firebase_id_token'] = firebaseIdToken;

  final response = await http.post(
    Uri.parse('${baseUrl}login'),
    body: map,
  );

  if (response.statusCode == 200) {
    // print(response.body);
    return Login.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to Login!!');
  }
}
