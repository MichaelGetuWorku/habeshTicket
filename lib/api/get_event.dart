// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/model/get_event.dart';
import 'package:login/utils/const.dart';

Future<GetEvent> fetchEvent() async {
  final response = await http.get(Uri.parse('${baseUrl}get_events'));

  print(GetEvent.fromJson(jsonDecode(response.body)));
  print('1111112');

  return GetEvent.fromJson(jsonDecode(response.body));
}
