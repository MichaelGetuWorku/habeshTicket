import 'dart:convert';
import 'package:login/controller/auth_controller.dart';
import 'package:http/http.dart' as http;
import 'package:login/model/transfer_ticket.dart';
import 'package:login/utils/const.dart';

Future<TransferTicket> transferTicket(
  accountNum,
  ticketId,
) async {
  var xAccessToken = AuthController.instance.jwt;

  Map<String, String> header = <String, String>{
    'x-access-token': xAccessToken,
  };

  Map<String, dynamic> body = {
    'receiver_account_no': accountNum,
    'ticket_id': ticketId,
  };

  final response = await http.post(
    Uri.parse('${baseUrl}transfer_ticket'),
    headers: header,
    body: body,
  );

  // print(response.body);

  if (response.statusCode == 200 || response.statusCode == 400) {
    return TransferTicket.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to transfer Ticket");
  }
}
