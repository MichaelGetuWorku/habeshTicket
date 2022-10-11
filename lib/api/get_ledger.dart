import 'dart:convert';

import 'package:login/controller/auth_controller.dart';
import 'package:login/model/get_ledger.dart';
import 'package:http/http.dart' as http;
import 'package:login/utils/const.dart';

Future<GetLedger> getLedger() async {
  var xAccessToken = AuthController.instance.jwt;
  print(xAccessToken);
  Map<String, String> _header = <String, String>{
    'x-access-token': xAccessToken
  };

  final response = await http.post(
    Uri.parse('${baseUrl}get_ledger'),
    headers: _header,
  );
  // print(response.body);
  if (response.statusCode == 200) {
    return GetLedger.fromJson(
      jsonDecode(response.body),
    );
  } else {
    throw Exception("Failed to get Ledger");
  }
}
