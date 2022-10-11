class TransferTicket {
  TransferTicket({
    required this.data,
    required this.error,
    required this.errorMsg,
  });
  late final List<Data> data;
  late final bool error;
  late final String errorMsg;

  factory TransferTicket.fromJson(Map<String, dynamic> json) {
    return TransferTicket(
      data: List.from(json['data']).map((e) => Data.fromJson(e)).toList(),
      error: json['error'],
      errorMsg: json['error_msg'],
    );
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
    required this.transfered,
  });
  late final bool transfered;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      transfered: json['transfered'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['transfered'] = transfered;
    return _data;
  }
}
