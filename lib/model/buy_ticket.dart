class BuyTicket {
  BuyTicket({
    required this.data,
    required this.error,
    required this.errorMsg,
  });
  late final List<Data> data;
  late final bool error;
  late final String errorMsg;

  BuyTicket.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    error = json['error'];
    errorMsg = json['error_msg'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['error'] = error;
    _data['error_msg'] = errorMsg;
    return _data;
  }
}

class Data {
  Data({
    required this.yo,
  });
  late final bool yo;

  Data.fromJson(Map<String, dynamic> json) {
    yo = json['yo'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['yo'] = yo;
    return _data;
  }
}
