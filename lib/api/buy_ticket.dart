import 'dart:convert';

import 'package:login/controller/auth_controller.dart';
import 'package:login/model/buy_ticket.dart';
import 'package:http/http.dart' as http;
import 'package:login/utils/const.dart';


Future<BuyTicket> buyTicket(eventId, ticketType, quantity) async {
  var xAccessToken = AuthController.instance.jwt;
  // print(xAccessToken);
  Map<String, String> header = <String, String>{
    'x-access-token': xAccessToken
  };
  Map<String, dynamic> body = {
    'event_id': eventId.toString(),
    'ticket_type': ticketType,
    'quantity': quantity
  };

  final response = await http.post(
    Uri.parse('${baseUrl}buy_ticket'),
    headers: header,
    body: body,
  );
  // print(response.body);
  if (response.statusCode == 200 || response.statusCode == 400) {
    return BuyTicket.fromJson(
      jsonDecode(response.body),
    );
  } else {
    throw Exception("Failed to buy tickets");
  }
}
