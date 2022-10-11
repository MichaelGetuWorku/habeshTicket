import 'dart:convert';

import 'package:login/controller/auth_controller.dart';
import 'package:http/http.dart' as http;
import 'package:login/model/get_tickets.dart';
import 'package:login/model/get_transactions.dart';
import 'package:login/utils/const.dart';


Future<GetTransactions> getTransactions() async {
  var xAccessToken = AuthController.instance.jwt;

  Map<String, String> header = <String, String>{
    'x-access-token': xAccessToken,
  };

  final response = await http.post(
    Uri.parse('${baseUrl}get_transactions'),
    headers: header,
  );
  // print(response.body);
  if (response.statusCode == 200) {
    return GetTransactions.fromJson(
      jsonDecode(response.body),
    );
  } else {
    throw Exception("Failed to get transactions.");
  }
}
