import 'dart:convert';

import 'package:login/controller/auth_controller.dart';
import 'package:http/http.dart' as http;
import 'package:login/model/transfer.dart';
import 'package:login/utils/const.dart';

Future<Transfer> transferCoin(accountNum, amount) async {
  var xAccessToken = AuthController.instance.jwt;

  Map<String, String> header = <String, String>{
    'x-access-token': xAccessToken,
  };

  Map<String, dynamic> body = {
    'to_account_number': accountNum,
    'transfer_amount': amount,
  };

  final response = await http.post(
    Uri.parse('${baseUrl}transfer'),
    headers: header,
    body: body,
  );

  print(response.body);

  if (response.statusCode == 200 || response.statusCode == 400) {
    return Transfer.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to transfer Coin");
  }
}
